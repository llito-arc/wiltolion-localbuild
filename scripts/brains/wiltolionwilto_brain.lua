require("behaviours/wander")
require("behaviours/faceentity")
require("behaviours/chaseandattack")
require("behaviours/panic")
require("behaviours/follow")
require("behaviours/attackwall")
require("behaviours/standstill")
require("behaviours/leash")
require("behaviours/runaway")
require("behaviours/doaction")

local BrainCommon = require("brains/braincommon")
local SPEECH_WILTO = require("speech_wilto")
local WiltolionWiltoBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

-- ============================================================================
-- CONSTANTS & DISTANCES
-- ============================================================================
local START_FACE_DIST = 4
local KEEP_FACE_DIST = 8
local KEEP_DANCING_DIST = 2
local AVOID_EXPLOSIVE_DIST = 5

-- Follow & Area Tracking
local MIN_FOLLOW_DIST = 0.2     
local TARGET_FOLLOW_DIST = 5  
local MAX_FOLLOW_DIST = 9     
local COURTESY_RADIUS_SQ = 8    -- Distance squared (2.8 units) for plant picking courtesy

-- Combat & Kiting
local MAX_KITE_DIST = 10
local DROP_TARGET_KITE_DIST_SQ = 14 * 14
local RUN_AFTER_KITE_DELAY = 1
local TOLERANCE_DIST = 0.5
local WILTO_ATTACK_WINDUP = 0.5
local KITE_DIST = 4
local STOP_KITE_DIST = 6
local SERVER_TICK_TOLERANCE = 0.15
-- ============================================================================
-- SEARCH TAGS (Pre-allocated to prevent memory garbage collection overhead)
-- ============================================================================
-- Work Actions
local ANY_TOWORK_ACTIONS = { ACTIONS.CHOP, ACTIONS.MINE, ACTIONS.DIG }
local ANY_TOWORK_MUSTONE_TAGS = { "CHOP_workable", "MINE_workable", "DIG_workable" }
local TOWORK_CANT_TAGS = { "fire", "smolder", "event_trigger", "waxedplant", "INLIMBO", "NOCLICK", "carnivalgame_part", "structure", "wiltolion_pylon" }
local DIG_TAGS = { "stump", "grave", "farm_debris" }

-- Gathering & Sorting
local INVENTORY_MUST_TAGS = { "_inventoryitem" }
local NO_PICKUP_TAGS = { "INLIMBO", "NOCLICK", "catchable", "fire", "irreplaceable", "nosteal", "heavy", "backpack", "trap" }
local CONTAINER_MUST_TAGS = { "_container" }
local CONTAINER_CANT_TAGS = { "INLIMBO", "NOCLICK" }

-- Plant Harvesting
local PICK_CANT_TAGS = { "INLIMBO", "NOCLICK", "fire", "smolder", "catchable", "thorny", "flower", "crop", "berrybush" }

-- Healing
local HEALTH_MUST_TAGS = { "_health" }
local HEALTH_CANT_TAGS = { "INLIMBO", "playerghost", "hostile" }
local HEALTH_MUSTONE_TAGS = { "player", "companion", "character" }

-- Danger & RunAway
local EXPLOSIVE_MUST_TAGS = { "explosive" }
local DANGER_CANT_TAGS = { "INLIMBO", "player" }
local DANGER_MUSTONE_TAGS = { "_combat", "_health" }

-- ============================================================================
-- PREFAB BLACKLISTS
-- ============================================================================
local IGNORED_PLANTS = {
    berrybush = true,
    berrybush2 = true,
    berrybush_juicy = true,
}

local BLACKLISTED_HEAL_TARGETS = {
    wiltolion_buddy = true,
    wone = true,
}

-- ============================================================================
-- CORE HELPERS
-- ============================================================================
local function GetLeader(inst)
    return inst.components.follower ~= nil and inst.components.follower:GetLeader() or nil
end

local function GetLeaderPos(inst)
    local leader = GetLeader(inst)
    return leader ~= nil and leader:GetPosition() or nil
end

local function GetFaceLeaderFn(inst)
    local target = GetLeader(inst)
    return target ~= nil and target.entity:IsVisible() and inst:IsNear(target, START_FACE_DIST) and target or nil
end

local function KeepFaceLeaderFn(inst, target)
    -- FIX: Added target nil check to prevent crash if leader disconnects or is removed
    return target ~= nil and target:IsValid() and target.entity:IsVisible() and inst:IsNear(target, KEEP_FACE_DIST)
end

-- ============================================================================
-- CACHE & BLACKLIST SYSTEM
-- ============================================================================
-- Prevents Wilto from attempting to interact with unreachable or glitched entities
local function IsEntityBlacklisted(inst, target)
    if inst._blacklisted_items ~= nil and inst._blacklisted_items[target] ~= nil then
        if inst._blacklisted_items[target] > GetTime() then
            return true
        else
            -- Garbage collection: clean up expired memory
            inst._blacklisted_items[target] = nil
        end
    end
    return false
end

-- ============================================================================
-- PHASE 2: WORK ENGINE (Chop, Mine, Dig)
-- ============================================================================

local function PickValidActionFrom(inst, target) 
    if target.components.workable == nil then 
        return nil, nil 
    end
    
    local desired_act = target.components.workable:GetWorkAction()
    local toggles = inst.wilto_toggles or {}
    
    -- Abort if the user toggled off this specific action category
    if (desired_act == ACTIONS.CHOP and toggles.chop == false) or
       (desired_act == ACTIONS.MINE and toggles.mine == false) or
       (desired_act == ACTIONS.DIG and toggles.dig == false) then
        return nil, nil
    end

    for _, act in ipairs(ANY_TOWORK_ACTIONS) do
        if desired_act == act then
            local inv = inst.components.inventory
            if inv == nil then return nil, nil end

            -- 1. Check currently equipped item in hands first (Optimized)
            local equipped = inv:GetEquippedItem(EQUIPSLOTS.HANDS)
            if equipped ~= nil and equipped.components.tool ~= nil and equipped.components.tool:CanDoAction(act) then
                return act, equipped
            end
            
            -- 2. Scan inventory for a valid tool and equip it automatically
            for _, item in pairs(inv.itemslots) do
                if item ~= nil and item.components.tool ~= nil and item.components.tool:CanDoAction(act) then
                    inv:Equip(item)
                    return act, item
                end
            end
        end
    end
    
    return nil, nil
end

local function IsValidWorkTarget(inst, target, toggles)
    -- Fast physical and blacklist validation
    if target == nil or not target:IsValid() or IsEntityBlacklisted(inst, target) then
        return false
    end

    if target.components.workable == nil or not target.components.workable:CanBeWorked() then
        return false
    end

    -- Fire guard
    if target.components.burnable ~= nil and (target.components.burnable:IsBurning() or target.components.burnable:IsSmoldering()) then
        return false
    end

    -- CHOPPING LOGIC: Only fully grown trees or burnt trees
    if target:HasTag("CHOP_workable") and toggles.chop ~= false then
        if target:HasTag("tree") and not target:HasTag("stump") then
            if target.components.growable ~= nil and target.components.growable.stage == 3 then
                return true
            elseif target:HasTag("burnt") then
                return true
            end
        end
        return false
    end

    -- DIGGING LOGIC: Only specific tags (stumps, graves, farm debris)
    if target:HasTag("DIG_workable") and toggles.dig ~= false then
        for _, tag in ipairs(DIG_TAGS) do
            if target:HasTag(tag) then
                return true
            end
        end
        return false
    end

    -- MINING LOGIC: Any mineable target is accepted if not toggled off
    if target:HasTag("MINE_workable") and toggles.mine ~= false then
        return true
    end

    return false
end

local function GetWorkAction(inst)
    -- 1. STATEGRAPH GUARD: Prevent cache spamming while Wilto is physically swinging a tool.
    if inst.sg ~= nil and inst.sg:HasStateTag("busy") then 
        return nil 
    end

    local leader = GetLeader(inst)
    if leader == nil then 
        return nil 
    end

    local toggles = inst.wilto_toggles or {}
    local current_time = GetTime()

    -- 2. STRICT CACHE SYSTEM
    if inst._work_target ~= nil then
        local target = inst._work_target
        
        -- INSTANT WIPE: If the chunk was unloaded by the engine, forget the target
        if target:IsAsleep() then
            inst._work_target = nil
            inst._next_work_scan = nil
        else
            -- Verify if cached target is still physically safe and valid
            local is_safe_cache = IsValidWorkTarget(inst, target, toggles) and target:IsOnValidGround()
            
            if is_safe_cache then
                local action, tool = PickValidActionFrom(inst, target)
                if action ~= nil then
                    return BufferedAction(inst, target, action, tool)
                else
                    -- Tool broke or user toggled the action off mid-walk
                    inst._work_target = nil
                end
            else
                -- THE CHAINING FIX: Target compromised (e.g. tree caught fire). 
                -- Wipe cache and force an instant scan to prevent standing still.
                inst._work_target = nil
                inst._next_work_scan = nil 
            end
        end
    end

    -- 3. THROTTLING SYSTEM
    if inst._next_work_scan ~= nil and current_time < inst._next_work_scan then
        return nil
    end

    -- Default 2.0 second penalty to protect server CPU if no targets exist nearby
    inst._next_work_scan = current_time + 2.0
    
    local x, y, z = inst.Transform:GetWorldPosition()
    local valid_target = nil

    -- 4. SPATIAL SCAN (Around Wilto First)
    local targets_near_wilto = TheSim:FindEntities(x, y, z, 25, nil, TOWORK_CANT_TAGS, ANY_TOWORK_MUSTONE_TAGS)
    for _, t in ipairs(targets_near_wilto) do
        -- Skip sleeping targets completely before running the heavy validation
        if not t:IsAsleep() and IsValidWorkTarget(inst, t, toggles) then
            valid_target = t
            break -- Optimization: Stop scanning once we find the first valid target
        end
    end
    
    -- 5. SPATIAL SCAN (Around Leader Fallback)
    if valid_target == nil then
        local lx, ly, lz = leader.Transform:GetWorldPosition()
        local targets_near_leader = TheSim:FindEntities(lx, ly, lz, 25, nil, TOWORK_CANT_TAGS, ANY_TOWORK_MUSTONE_TAGS)
        for _, t in ipairs(targets_near_leader) do
            -- Skip sleeping targets here as well
            if not t:IsAsleep() and IsValidWorkTarget(inst, t, toggles) then
                valid_target = t
                break
            end
        end
    end
    
    -- 6. CACHE AND RETURN
    if valid_target ~= nil then
        local action, tool = PickValidActionFrom(inst, valid_target)
        if action ~= nil then
            inst._work_target = valid_target 
            inst._next_work_scan = nil -- Clear penalty immediately
            return BufferedAction(inst, valid_target, action, tool)
        end
    end
    
    return nil
end

-- ============================================================================
-- PHASE 3: INVENTORY & LOGISTICS ENGINE (Pickup, Sort, Give)
-- ============================================================================

local function IsLeaderInCombat(leader)
    local leader_combat = leader.components.combat
    if leader_combat == nil then return false end
    
    local timeout_time = GetTime() - 6
    local attack_time = math.max(leader_combat.laststartattacktime or 0, leader_combat.lastdoattacktime or 0)
    
    if attack_time > timeout_time then return true end
    if leader_combat:GetLastAttackedTime() > timeout_time then return true end
    
    return false
end

local function CanLeaderAcceptItem(leader, item)
    local inv = leader.components.inventory
    if inv == nil then return false end
    
    -- 1. Main inventory has empty slots
    if not inv:IsFull() then return true end
    
    -- 2. Backpack has empty slots
    local body_item = inv:GetEquippedItem(EQUIPSLOTS.BODY)
    if body_item ~= nil and body_item.components.container ~= nil and not body_item.components.container:IsFull() then
        return true
    end
    
    -- 3. Check for incomplete stacks
    if item.components.stackable ~= nil then
        -- Search main inventory
        for _, v in pairs(inv.itemslots) do
            if v.prefab == item.prefab and v.components.stackable ~= nil and not v.components.stackable:IsFull() then
                return true 
            end
        end
        -- Search backpack
        if body_item ~= nil and body_item.components.container ~= nil then
            for _, v in pairs(body_item.components.container.slots) do
                if v.prefab == item.prefab and v.components.stackable ~= nil and not v.components.stackable:IsFull() then
                    return true 
                end
            end
        end
    end
    
    return false
end

local function GetGiveAction(inst)
    -- SG Guard: Do not attempt to give items if currently busy
    if inst.sg ~= nil and inst.sg:HasStateTag("busy") then return nil end

    if inst.wilto_toggles ~= nil and inst.wilto_toggles.give == false then return nil end
    
    local leader = GetLeader(inst)
    if leader == nil or leader:HasTag("playerghost") or IsLeaderInCombat(leader) then return nil end
    
    -- Leader is too far to initiate giving action
    if not inst:IsNear(leader, 10) then return nil end
    
    local inv = inst.components.inventory
    if inv == nil or inv.itemslots == nil then return nil end

    for _, item in pairs(inv.itemslots) do
        -- Give valid, non-equippable items (prevents giving away his armor/tools)
        if item ~= nil and item.components.equippable == nil then
            if CanLeaderAcceptItem(leader, item) then
                return BufferedAction(inst, leader, ACTIONS.GIVEALLTOPLAYER, item)
            end
        end
    end
    
    return nil
end

local function GetStoreAction(inst)
    -- SG Guard
    if inst.sg ~= nil and inst.sg:HasStateTag("busy") then return nil end
    if inst.wilto_toggles ~= nil and inst.wilto_toggles.give == false then return nil end

    local inv = inst.components.inventory
    if inv == nil or inv.itemslots == nil or next(inv.itemslots) == nil then return nil end

    -- THROTTLING: Container scanning is extremely CPU heavy. Throttle severely.
    local t = GetTime()
    if inst._next_sort_scan ~= nil and t < inst._next_sort_scan then return nil end
    inst._next_sort_scan = t + 2.5 

    local x, y, z = inst.Transform:GetWorldPosition()
    local containers = TheSim:FindEntities(x, y, z, 20, CONTAINER_MUST_TAGS, CONTAINER_CANT_TAGS)
    
    if #containers == 0 then return nil end 

    for _, item in pairs(inv.itemslots) do
        if item ~= nil and not item:HasTag("irreplaceable") then
            for _, container_ent in ipairs(containers) do
                local cont = container_ent.components.container
                local inv_item = container_ent.components.inventoryitem
                local is_held = inv_item ~= nil and inv_item.owner ~= nil
                
                -- Only interact with closed, static chests that aren't blacklisted
                if cont ~= nil and not is_held and cont:IsOpen() == false and not IsEntityBlacklisted(inst, container_ent) then
                    
                    -- Smart check: Chest must already contain at least 1 of this item type
                    if cont:Has(item.prefab, 1) then
                        local can_store = false
                        
                        if not cont:IsFull() then
                            can_store = true
                        elseif item.components.stackable ~= nil then
                            for _, v in pairs(cont.slots) do
                                if v.prefab == item.prefab and v.components.stackable ~= nil and not v.components.stackable:IsFull() then
                                    can_store = true
                                    break
                                end
                            end
                        end
                        
                        if can_store then
                            -- Clear scan timer to chain store actions rapidly
                            inst._next_sort_scan = nil
                            local action = BufferedAction(inst, container_ent, ACTIONS.STORE, item)
                            action.distance = 1.5
                            return action
                        end
                    end
                end
            end
        end
    end
    
    return nil
end

local function GetPickupAction(inst)
    -- SG Guard
    if inst.sg ~= nil and inst.sg:HasStateTag("busy") then return nil end
    if inst.wilto_toggles ~= nil and inst.wilto_toggles.pickup == false then return nil end

    local inv = inst.components.inventory
    if inv ~= nil and inv:IsFull() then return nil end

    local leader = GetLeader(inst)
    if leader == nil then return nil end

    -- 1. STRICT CACHE SYSTEM
    if inst._pickup_target ~= nil then
        local target = inst._pickup_target
        
        -- Proactive safeguard
        local is_safe_cache = target:IsValid() and 
                              target.components.inventoryitem ~= nil and 
                              target.components.inventoryitem.canbepickedup and 
                              not target.components.inventoryitem:IsHeld() and
                              target:IsOnValidGround() and
                              not IsEntityBlacklisted(inst, target)

        if is_safe_cache and target.components.burnable ~= nil and (target.components.burnable:IsBurning() or target.components.burnable:IsSmoldering()) then
            is_safe_cache = false
        end

        if is_safe_cache then
            return BufferedAction(inst, target, ACTIONS.PICKUP)
        else
            inst._pickup_target = nil
        end
    end

    -- 2. THROTTLING SYSTEM
    local t = GetTime()
    if inst._next_pickup_scan ~= nil and t < inst._next_pickup_scan then return nil end
    inst._next_pickup_scan = t + 0.5 -- 0.5s is safe for pickups

    local x, y, z = inst.Transform:GetWorldPosition()
    
    -- Utilizing pre-allocated tables from Phase 1
    local ents = TheSim:FindEntities(x, y, z, 15, INVENTORY_MUST_TAGS, NO_PICKUP_TAGS)
    local ignorethese = leader._brain_pickup_ignorethese or {}

    for _, item in ipairs(ents) do
        if item:IsValid() and not ignorethese[item] and not IsEntityBlacklisted(inst, item) then
            if item.components.inventoryitem ~= nil and item.components.inventoryitem.canbepickedup and not item.components.inventoryitem:IsHeld() then
                if item.components.container == nil and item:IsOnValidGround() and not item:HasTag("trap") then
                    
                    -- Distance safeguard: Don't pick up items too far from the leader
                    if item:GetDistanceSqToInst(leader) < 400 then
                        inst._pickup_target = item 
                        inst._next_pickup_scan = nil 
                        return BufferedAction(inst, item, ACTIONS.PICKUP)
                    end
                    
                end
            end
        end
    end

    return nil
end

-- ============================================================================
-- PHASE 4: SUPPORT & NATURE ENGINE (Pick, Heal, Interact)
-- ============================================================================

local function GetPickAction(inst)
    -- SG Guard
    if inst.sg ~= nil and inst.sg:HasStateTag("busy") then return nil end
    if inst.wilto_toggles ~= nil and inst.wilto_toggles.harvest == false then return nil end

    local inv = inst.components.inventory
    if inv ~= nil and inv:IsFull() then return nil end

    local leader = GetLeader(inst)
    if leader == nil then return nil end

    -- 1. STRICT CACHE SYSTEM
    if inst._pick_target ~= nil then
        local target = inst._pick_target
        
        local is_safe_cache = target:IsValid() and 
                              target.components.pickable ~= nil and 
                              target.components.pickable:CanBePicked() and
                              not target:HasTag("fire") and
                              not target:HasTag("smolder") and
                              not IsEntityBlacklisted(inst, target)

        if is_safe_cache then
            return BufferedAction(inst, target, ACTIONS.PICK)
        else
            inst._pick_target = nil
        end
    end

    -- 2. THROTTLING SYSTEM
    local t = GetTime()
    if inst._next_pick_scan ~= nil and t < inst._next_pick_scan then return nil end
    inst._next_pick_scan = t + 0.6 

    local x, y, z = inst.Transform:GetWorldPosition()
    
    -- Utilizing a dynamic local table since MUST tags for picking are extremely simple
    local ents = TheSim:FindEntities(x, y, z, 15, { "pickable" }, PICK_CANT_TAGS)
    
    for _, plant in ipairs(ents) do
        if plant:IsValid() and plant.components.pickable ~= nil and plant.components.pickable:CanBePicked() then
            if not IGNORED_PLANTS[plant.prefab] and not IsEntityBlacklisted(inst, plant) then
                
                -- COMPLEXITY PRESERVED: Courtesy Logic
                -- Do not pick the plant if the leader is extremely close to it (let the player have it)
                if plant:GetDistanceSqToInst(leader) > COURTESY_RADIUS_SQ then
                    inst._pick_target = plant
                    inst._next_pick_scan = nil
                    return BufferedAction(inst, plant, ACTIONS.PICK)
                end
                
            end
        end
    end

    return nil
end

local function GetHealAction(inst)
    -- SG Guard
    if inst.sg ~= nil and inst.sg:HasStateTag("busy") then return nil end
    if inst.wilto_toggles ~= nil and inst.wilto_toggles.heal == false then return nil end

    local inv = inst.components.inventory
    if inv == nil then return nil end

    -- 1. COMPLEXITY PRESERVED: Validate healing capability before scanning
    local heal_item = nil
    for _, item in pairs(inv.itemslots) do
        if item ~= nil and item.components.healer ~= nil then
            heal_item = item
            break
        end
    end
    
    -- Abort immediately if Wilto has no healing items (saves CPU)
    if heal_item == nil then return nil end

    -- 2. THROTTLING SYSTEM
    local t = GetTime()
    if inst._next_heal_scan ~= nil and t < inst._next_heal_scan then return nil end
    inst._next_heal_scan = t + 1.0 -- Scan every 1 second, healing is lower priority than combat

    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 15, HEALTH_MUST_TAGS, HEALTH_CANT_TAGS, HEALTH_MUSTONE_TAGS)
    
    for _, target in ipairs(ents) do
        if target:IsValid() and target.components.health ~= nil and not target.components.health:IsDead() then
            -- Only heal if target is below 80% health and not blacklisted (e.g., wone, other buddies)
            if target.components.health:GetPercent() < 0.80 and not BLACKLISTED_HEAL_TARGETS[target.prefab] then
                inst._next_heal_scan = nil
                return BufferedAction(inst, target, ACTIONS.HEAL, heal_item)
            end
        end
    end
    
    return nil
end

-- ============================================================================
-- INTERACTIVE & PASSIVE STATES (Dance, Minigames)
-- ============================================================================

local function ShouldDanceParty(inst)
    local leader = GetLeader(inst)
    return leader ~= nil and leader.sg ~= nil and leader.sg:HasStateTag("dancing")
end

local function ShouldWatchMinigame(inst)
    local leader = GetLeader(inst)
    if leader ~= nil and leader.components.minigame_participator ~= nil then
        local minigame = leader.components.minigame_participator:GetMinigame()
        return minigame ~= nil and minigame.components.minigame ~= nil and minigame.components.minigame:GetIsPlaying()
    end
    return false
end

local function GetMinigameWatchTarget(inst)
    local leader = GetLeader(inst)
    if leader ~= nil and leader.components.minigame_participator ~= nil then
        return leader.components.minigame_participator:GetMinigame()
    end
    return nil
end

-- ============================================================================
-- PHASE 5: COMBAT & EVASION ENGINE
-- ============================================================================

-- ============================================================================
-- ADVANCED CHEAT KITING V2 (Ping Tolerance & Aggro Prediction)
-- ============================================================================
local SERVER_TICK_TOLERANCE = 0.15 -- 4 to 5 server frames of safety buffer

local function ShouldCheatKite(inst)
    local target = inst.components.combat.target
    if target == nil or not target:IsValid() or target.components.health == nil or target.components.health:IsDead() then
        return false
    end

    local t_combat = target.components.combat
    if t_combat == nil then
        return false
    end

    -- 1. EXPLOIT INCAPACITATION
    if target.components.sleeper ~= nil and target.components.sleeper:IsAsleep() then return false end
    if target.components.freezable ~= nil and target.components.freezable:IsFrozen() then return false end
    if target.sg ~= nil and target.sg:HasStateTag("stunned") then return false end

    -- 2. DYNAMIC RANGE CALCULATION (Including Wilto's own physics radius)
    local enemy_reach = t_combat:GetAttackRange() 
        + (target:GetPhysicsRadius(0) or 0) 
        + (inst:GetPhysicsRadius(0) or 0) 
        + 0.5
    
    -- If the enemy is exclusively targeting Wilto, they will walk towards him.
    -- We add an artificial safety margin to the distance check to prevent late dodges.
    local is_targeting_wilto = t_combat.target == inst
    local aggro_margin = is_targeting_wilto and 1.5 or 0
    
    local dist_sq = inst:GetDistanceSqToInst(target)
    local safe_dist = enemy_reach + aggro_margin

    if dist_sq > (safe_dist * safe_dist) then
        return false -- We are safely out of reach, go in for the attack
    end

    -- 3. ANIMATION STATE CHECK (Added charge/leap detection)
    if target.sg ~= nil and (
        target.sg:HasStateTag("attack") or 
        target.sg:HasStateTag("abouttoattack") or
        target.sg:HasStateTag("charge") or
        target.sg:HasStateTag("leapattack")
    ) then
        return true
    end

    -- 4. COOLDOWN MATH WITH NETWORK BUFFER
    local last_attack = t_combat.laststartattacktime or t_combat.lastdoattacktime or 0
    local attack_period = t_combat.min_attack_period or 2
    local time_since_attack = GetTime() - last_attack
    local time_to_next_attack = attack_period - time_since_attack

    -- If the time before the enemy strikes is less than Wilto's windup PLUS our safety buffer, we flee
    if time_to_next_attack <= (WILTO_ATTACK_WINDUP + SERVER_TICK_TOLERANCE) then
        return true
    end

    return false
end

local function GetExplosiveTarget(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local explosives = TheSim:FindEntities(x, y, z, AVOID_EXPLOSIVE_DIST, EXPLOSIVE_MUST_TAGS, DANGER_CANT_TAGS)
    
    for _, bomb in ipairs(explosives) do
        if bomb:IsValid() then
            return bomb
        end
    end
    return nil
end

local function GetCombatTarget(inst)
    -- SG Guard
    if inst.sg ~= nil and inst.sg:HasStateTag("busy") then return nil end
    if inst.wilto_toggles ~= nil and inst.wilto_toggles.fight == false then return nil end
    
    local combat = inst.components.combat
    if combat == nil then return nil end

    -- 1. Self Preservation: Wilto is actively being attacked
    if combat.target ~= nil and combat.target:IsValid() and not combat.target:HasTag("INLIMBO") then
        return combat.target
    end
    
    -- 2. Leader Defense: Assist leader in combat
    local leader = GetLeader(inst)
    if leader ~= nil and leader.components.combat ~= nil then
        local leader_target = leader.components.combat.target
        
        if leader_target ~= nil and leader_target:IsValid() and not leader_target:HasTag("INLIMBO") then
            -- Prevent Wilto from attacking other players by accident
            if not leader_target:HasTag("player") then
                return leader_target
            end
        end
    end
    
    return nil
end

local function ShouldCheatKite(inst)
    local target = inst.components.combat.target
    
    -- Fast nil checks to abort early
    if target == nil or not target:IsValid() or target.components.combat == nil then
        return false
    end

    -- OPTIMIZATION: Using GetDistanceSqToInst to avoid expensive square root math on every tick
    local dist_sq = inst:GetDistanceSqToInst(target)
    
    -- If Wilto is out of the immediate danger zone, drop the kiting behavior
    if dist_sq > DROP_TARGET_KITE_DIST_SQ then
        return false
    end

    -- Math validation for the attack range
    local target_combat = target.components.combat
    local attack_range = target_combat:GetAttackRange()
    local safe_distance = attack_range + TOLERANCE_DIST
    
    -- Wilto initiates kiting ONLY if the target is aiming at him and is within striking distance
    if target_combat.target == inst and dist_sq <= (safe_distance * safe_distance) then
        return true
    end

    return false
end

local function KeepCombatTarget(inst, target)
    if inst.wilto_toggles ~= nil and inst.wilto_toggles.fight == false then return false end
    
    return target ~= nil 
           and target:IsValid() 
           and target.components.health ~= nil 
           and not target.components.health:IsDead() 
           and inst:IsNear(target, MAX_KITE_DIST)
end

-- ============================================================================
-- PHASE 6: BEHAVIOUR TREE HELPERS & EVENT CALLBACKS
-- ============================================================================
local function IsOnFire(inst)
    return inst.components.burnable ~= nil and inst.components.burnable:IsBurning()
end

local function ShouldRetreatFromCombat(inst)
    local leader = GetLeader(inst)
    local target = inst.components.combat.target
    return target ~= nil and leader ~= nil and inst:GetDistanceSqToInst(leader) > 225
end

local function IsDangerTarget(inst, target)
    -- Fast exit if not in panic mode
    if inst.ShouldFleeForSurvival == nil or not inst:ShouldFleeForSurvival() then 
        return false 
    end
    
    -- Ally shield: Never flee from players or companions
    if target:HasTag("player") or target:HasTag("companion") then 
        return false 
    end
    
    -- Flee from monsters or entities actively targeting Wilto
    return target:HasTag("monster") or (target.components.combat ~= nil and target.components.combat.target == inst)
end

local function GetCheatKiteEvasionTarget(inst, hunter)
    return hunter == inst.components.combat.target 
end

-- ============================================================================
-- AMBIENT CHAT AND GREETING SYSTEM (BT Integrated)
-- ============================================================================
local function CheckAmbientGreeting(inst)
    -- 1. Strict guards to ensure Wilto is completely idle
    if inst.sg == nil or inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("moving") then
        return false
    end
    
    -- Abort if a brain action is already buffered or in combat
    if inst:GetBufferedAction() ~= nil or (inst.components.combat ~= nil and inst.components.combat:HasTarget()) then
        return false
    end

    local t = GetTime()
    
    -- 2. Cooldown validation (45 seconds)
    if inst._next_greet_time ~= nil and t < inst._next_greet_time then
        return false
    end

    local x, y, z = inst.Transform:GetWorldPosition()
    local players = TheSim:FindEntities(x, y, z, 6, { "player" }, { "ghost", "playerghost", "INLIMBO" })
    
    for _, player in ipairs(players) do
        if player:IsValid() then
            inst._greet_target = player
            return true 
        end
    end

    -- 3. Throttle the scan if no players are nearby (Check again in 3 seconds to save CPU)
    inst._next_greet_time = t + 3
    return false
end

local function DoAmbientGreeting(inst)
    local target = inst._greet_target
    inst._greet_target = nil                 -- Clear the cache
    inst._next_greet_time = GetTime() + 45   -- Apply the 45s cooldown
    
    if target ~= nil and target:IsValid() then
        inst:FacePoint(target.Transform:GetWorldPosition())
        inst:PushEvent("wilto_greet", { target = target })
        
        if inst.components.talker ~= nil and SPEECH_WILTO ~= nil and SPEECH_WILTO.GREETING ~= nil then
            local player_name = target:GetDisplayName() or "friend"
            local dialogues = SPEECH_WILTO.GREETING
            local random_index = math.random(#dialogues)
            local chosen_line = dialogues[random_index]
            
            inst.components.talker:Say(string.format(chosen_line, player_name))
        end
    end
end

-- ============================================================================
-- MAIN BRAIN STARTUP
-- ============================================================================
function WiltolionWiltoBrain:OnStart()
    
    -- =====================================================
    -- 1. LEXICAL CLOSURES
    -- =====================================================
    -- Action Handlers
    local function DoDanceParty() self.inst:PushEvent("dance") end
    local function DoRetreat() self.inst.components.combat:DropTarget() end
    local function CheckGreeting() return CheckAmbientGreeting(self.inst) end

    -- Condition Checkers for WhileNodes
    local function CheckWatchGame() return ShouldWatchMinigame(self.inst) end
    local function CheckDance() return ShouldDanceParty(self.inst) end
    local function CheckOnFire() return IsOnFire(self.inst) end
    local function CheckRetreat() return ShouldRetreatFromCombat(self.inst) end
    local function CheckKiting() return ShouldCheatKite(self.inst) end

    -- Toggle Interrupters
    local function IsCombatEnabled() return self.inst.wilto_toggles == nil or self.inst.wilto_toggles.fight ~= false end
    local function IsHealEnabled() return self.inst.wilto_toggles == nil or self.inst.wilto_toggles.heal ~= false end
    local function IsPickEnabled() return self.inst.wilto_toggles == nil or self.inst.wilto_toggles.harvest ~= false end
    local function IsPickupEnabled() return self.inst.wilto_toggles == nil or self.inst.wilto_toggles.pickup ~= false end
    local function IsGiveEnabled() return self.inst.wilto_toggles == nil or self.inst.wilto_toggles.give ~= false end
    local function IsWorkEnabled() 
        local t = self.inst.wilto_toggles
        return t == nil or (t.chop ~= false or t.mine ~= false or t.dig ~= false)
    end

    -- Target filter for dodging
    local function CheckDodgeTarget(guy) return guy ~= nil and guy == self.inst.components.combat.target end

    -- Custom Hunter Target Checkers for RunAway
    local function CheckDangerTarget(hunter) return IsDangerTarget(self.inst, hunter) end
    local function CheckKiteEvasion(hunter) return GetCheatKiteEvasionTarget(self.inst, hunter) end
    local function GetWanderPos() return self.inst:GetPosition() end

    -- =====================================================
    -- 2. LOCAL NODES
    -- =====================================================
    local watch_game = WhileNode(CheckWatchGame, "Watching Game",
        PriorityNode({ 
            Follow(self.inst, GetMinigameWatchTarget, 0, 0, 0), 
            RunAway(self.inst, "minigame_participator", 5, 7), 
            FaceEntity(self.inst, GetMinigameWatchTarget, GetMinigameWatchTarget) 
        }, 0.25)
    )
    
    local dance_party = WhileNode(CheckDance, "Dance Party",
        PriorityNode({ 
            Leash(self.inst, GetLeaderPos, KEEP_DANCING_DIST, KEEP_DANCING_DIST), 
            ActionNode(DoDanceParty, "Dance") 
        }, 0.25)
    )

    -- =====================================================
    -- 3. BEHAVIOR TREE ROOT
    -- =====================================================
    local root = PriorityNode({
        
        -- [ SECTION 1: EMERGENCIES & PANIC ]
        RunAway(self.inst, "explosive", AVOID_EXPLOSIVE_DIST, AVOID_EXPLOSIVE_DIST),
        WhileNode(CheckOnFire, "OnFire", Panic(self.inst)),
        RunAway(self.inst, CheckDangerTarget, 10, 15),
        RunAway(self.inst, "fire", 2.5, 4.5),

        -- [ SECTION 2: SPECIAL EVENTS ]
        dance_party,
        watch_game,

        -- [ SECTION 3: HEALING & SUPPORT ]
        WhileNode(IsHealEnabled, "Heal Toggle", 
            DoAction(self.inst, GetHealAction, "Heal Target", true)
        ),

        -- [ SECTION 4: COMBAT & TACTICS ]
        WhileNode(IsCombatEnabled, "Combat Toggle",
            PriorityNode({
                WhileNode(CheckRetreat, "Retreat From Combat",
                    PriorityNode({
                        FailIfSuccessDecorator(ActionNode(DoRetreat, "Retreat")),
                        Follow(self.inst, GetLeader, 0, 3, 5)
                    }, 0.25)
                ),
                
                -- Advanced Kiting logic execution
                WhileNode(CheckKiting, "Cheat Kiting",
                    RunAway(self.inst, CheckDodgeTarget, KITE_DIST, STOP_KITE_DIST) 
                ),
                
                ChaseAndAttack(self.inst, nil, MAX_KITE_DIST, nil, nil, KeepCombatTarget)
            }, 0.25)
        ),

        -- [ SECTION 5: WORK & RESOURCE GATHERING ]
        -- Wrapped in WhileNodes to instantly abort ongoing actions if toggled off
        WhileNode(IsWorkEnabled, "Work Toggle", DoAction(self.inst, GetWorkAction, "Work Tasks", true)),
        WhileNode(IsPickEnabled, "Gather Toggle", DoAction(self.inst, GetPickAction, "Harvest Plants", true)),
        WhileNode(IsPickupEnabled, "Pickup Toggle", DoAction(self.inst, GetPickupAction, "Pickup Resources", true)),

        -- [ SECTION 6: INVENTORY MANAGEMENT ]
        WhileNode(IsGiveEnabled, "Give Toggle", 
            PriorityNode({
                DoAction(self.inst, GetStoreAction, "Store Items", true),
                DoAction(self.inst, GetGiveAction, "Give Resources", true)
            }, 0.25)
        ),

        -- [ SECTION 7: FOLLOW & IDLE ]
        Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST, true),

        -- GREETING NODE: Only executes if Follow falls through (Wilto is near the leader) 
        -- and no higher priority task is active.
        WhileNode(CheckGreeting, "Ambient Greet",
            ActionNode(function() DoAmbientGreeting(self.inst) end, "Do Greet")
        ),

        Wander(self.inst, GetWanderPos, 2.5, { 
            minwalktime = 0.5, 
            randwalktime = 0.5, 
            minwaittime = 4.0, 
            randwaittime = 4.0 
        }),

        FaceEntity(self.inst, GetFaceLeaderFn, KeepFaceLeaderFn),

    }, 0.25)

    -- Initialize the behaviour tree using the native Klei BT class
    self.bt = BT(self.inst, root)

    -- =====================================================
    -- 4. WATCHDOG STUCK SYSTEM 
    -- =====================================================
    self.watchdog_task = self.inst:DoPeriodicTask(1, function(inst)
        local current_action = inst:GetBufferedAction()
        if current_action ~= nil and current_action.target ~= nil then
            
            if inst.sg ~= nil and (inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("working") or inst.sg:HasStateTag("doing")) then
                inst._watchdog_stuck_ticks = 0
                inst._last_watchdog_pos = inst:GetPosition()
                return
            end

            local current_pos = inst:GetPosition()
            if inst._last_watchdog_pos ~= nil then
                if distsq(current_pos, inst._last_watchdog_pos) < 0.1 then
                    inst._watchdog_stuck_ticks = (inst._watchdog_stuck_ticks or 0) + 1
                    if inst._watchdog_stuck_ticks >= 3 then 
                        if inst._blacklisted_items == nil then
                            inst._blacklisted_items = {}
                        end
                        
                        inst._blacklisted_items[current_action.target] = GetTime() + 60
                        
                        inst:ClearBufferedAction()
                        if inst.components.locomotor ~= nil then
                            inst.components.locomotor:Stop()
                        end
                        
                        inst._work_target = nil
                        inst._pickup_target = nil
                        inst._pick_target = nil
                        
                        if self.bt ~= nil then
                            self.bt:Reset()
                        end
                        
                        inst._watchdog_stuck_ticks = 0
                        inst._last_watchdog_pos = nil
                    end
                else
                    inst._watchdog_stuck_ticks = 0
                    inst._last_watchdog_pos = current_pos
                end
            else
                inst._watchdog_stuck_ticks = 0
                inst._last_watchdog_pos = current_pos 
            end
        else
            inst._watchdog_stuck_ticks = 0
            inst._last_watchdog_pos = nil
        end
    end)
end

-- ============================================================================
-- ONSTOP CALLBACK
-- ============================================================================
function WiltolionWiltoBrain:OnStop()
    if self.watchdog_task ~= nil then
        self.watchdog_task:Cancel()
        self.watchdog_task = nil
    end
end

return WiltolionWiltoBrain