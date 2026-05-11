require "behaviours/runaway"
require "behaviours/wander"
require "behaviours/panic"
require "behaviours/follow"
require "behaviours/faceentity"
require "behaviours/standstill"

local MAX_WANDER_DIST = 10
local RUN_AWAY_DIST = 6
local STOP_RUN_AWAY_DIST = 10

local WiltolionThingyBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

-- =========================================================
-- LEADER TRACKING
-- =========================================================
local function GetLeader(inst)
    return inst.components.follower and inst.components.follower:GetLeader()
end

local function GetLeaderPos(inst)
    local leader = GetLeader(inst)
    return leader ~= nil and leader:GetPosition() or nil
end

local function GetFaceTargetFn(inst)
    local target = GetLeader(inst)
    return target ~= nil and target.entity:IsVisible() and inst:IsNear(target, 4) and target or nil
end

local function KeepFaceTargetFn(inst, target)
    return target.entity:IsVisible() and inst:IsNear(target, 8)
end

-- =========================================================
-- SURVIVAL LOGIC (Fleeing)
-- =========================================================
local function IsDanger(target, inst)
    -- Never run away from players or other companions
    if target:HasTag("player") or target:HasTag("companion") then 
        return false 
    end
    
    return target:HasTag("monster") or target:HasTag("hostile") or (target.components.combat and target.components.combat.target == inst)
end

-- =========================================================
-- HEALING LOGIC (Target acquisition)
-- =========================================================
local HEAL_CANT_TAGS = { "INLIMBO", "playerghost", "hostile", "wone" }
local HEAL_MUSTONE_TAGS = { "player", "companion", "wiltolion_buddy", "wiltolion_wilto" }

local function GetHealTarget(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local targets = TheSim:FindEntities(x, y, z, 15, { "_health" }, HEAL_CANT_TAGS, HEAL_MUSTONE_TAGS)
    
    local best_target = nil
    local lowest_hp = 0.35
    local current_time = GetTime()

    for _, target in ipairs(targets) do
        if target.components.health and not target.components.health:IsDead() then
            -- Verify if the target is NOT blacklisted (or if the cooldown expired)
            local is_blacklisted = inst.heal_blacklist and inst.heal_blacklist[target.GUID] and (inst.heal_blacklist[target.GUID] > current_time)
            
            if not is_blacklisted then
                local hp = target.components.health:GetPercent()
                if hp < lowest_hp then
                    lowest_hp = hp
                    best_target = target
                end
            end
        end
    end
    
    return best_target
end

-- =========================================================
-- MAIN BRAIN TREE
-- =========================================================
function WiltolionThingyBrain:OnStart()
    
    local root = PriorityNode({
        -- 1. Basic Panic (Fire)
        WhileNode(function() return self.inst.components.burnable and self.inst.components.burnable:IsBurning() end, "OnFire", Panic(self.inst)),

        -- 2. Passive Healing System
        WhileNode(function() 
            local target = self.inst.target_to_heal
            
            -- Clear the target if it becomes invalid, turns into a ghost, or dies
            if target ~= nil and (not target:IsValid() or target:HasTag("playerghost") or (target.components.health and target.components.health:IsDead())) then
                self.inst.target_to_heal = nil
            end

            -- If we don't have a valid target anymore, find a new one
            if self.inst.target_to_heal == nil then
                self.inst.target_to_heal = GetHealTarget(self.inst)
            end

            return self.inst.target_to_heal ~= nil 
        end, "Needs Healing",
            PriorityNode({
                -- Stand completely still to heal if close enough
                WhileNode(function() return self.inst:IsNear(self.inst.target_to_heal, 2.5) end, "Stand and Heal",
                    StandStill(self.inst)
                ),
                -- Follow the wounded target if they move away
                Follow(self.inst, function() return self.inst.target_to_heal end, 0, 1.5, 3)
            }, 0.25)
        ),

        -- 3. Survival (Run from danger)
        RunAway(self.inst, { fn = IsDanger, tags = {"_combat"}, notags = {"INLIMBO", "player", "companion"} }, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST),

        -- 4. Follow Leader (Default safe behavior)
        Follow(self.inst, GetLeader, 2, 4, 8),
        FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),

        -- 5. Free Time (Wander nearby)
        Wander(self.inst, function() return GetLeaderPos(self.inst) end, MAX_WANDER_DIST, nil, nil, nil, nil, { should_run = false, wander_dist = 4 })
    }, 0.25)
        
    self.bt = BT(self.inst, root)
end

function WiltolionThingyBrain:OnInitializationComplete()
    self.inst.components.knownlocations:RememberLocation("home", Point(self.inst.Transform:GetWorldPosition()))
end

return WiltolionThingyBrain