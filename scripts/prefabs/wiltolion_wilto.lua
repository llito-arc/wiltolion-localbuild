local assets = {
    Asset("ANIM", "anim/wilto.zip"),
}

local prefabs = {}

local brain = require("brains/wiltolionwilto_brain")
local speech = require("speech_wilto") -- External dialogue dictionary

-- =========================================================
-- CORE STATS & BALANCE
-- All variables modifying Wilto's power should be changed here.
-- =========================================================
local WILTO_STATS = {
    MAX_HEALTH = 120,
    REGEN_AMOUNT = 3,
    REGEN_PERIOD = 10,
    BASE_DAMAGE = 15,
    ATTACK_PERIOD = 0.50,
    RUN_SPEED = 8.5,
    WALK_SPEED = 5.5,
    DROWN_DAMAGE = -20,
    SINK_DAMAGE = -15
}

-- =========================================================
-- MEDICAL SYSTEM & HEALING TOKENS
-- =========================================================

local HEALING_VALUES = {
    -- Base Medical Items (Intended specifically for healing)
    spidergland = 15,
    mosquito_sack = 20,
    healingsalve = 30,
    bandage = 50, 
    
    -- Cheap "Trash" & Abundant Nature (1 to 3 points)
    petals = 5,
    foliage = 3,          -- Cave fern leaves
    kelp = 3,             -- Raw bull kelp from the ocean
    kelp_cooked = 3,
    cutlichen = 3,        -- Cave lichen
    lightbulb = 1,
    forgetmelots = 1,     -- Common weeds
    tillweed = 1,
    succulent_picked = 3, -- Desert succulents
    moon_tree_blossom = 5,              -- Can be eaten to cool down / minor heal
    seeds = 3,
    roasted_seeds = 5,
    
    -- Basic Forage & Meats (Low value)
    butterflywings = 10,
    honey = 5,
    bluecap = 10,         -- Excellent raw healing mushroom
    batwing = 3,
    cookedbatwing = 8,
    
    -- Jerky (Standard survival healing)
    smallmeat_jerky = 8,
    jerky = 20,

    -- Standard Crock Pot Foods (Mid-tier, uses common ingredients)
    fishtacos = 20,
    trailmix = 30,
    honeyham = 30,
    pierogi = 40,
    jellybean = 120,
}

local POINTS_PER_TOKEN = 30
local MAX_TOKENS = 20

local function ProcessHealingItems(inst)
    if not inst.components.inventory then return end
    if (inst.wilto_heal_tokens or 0) >= MAX_TOKENS then return end

    local inv = inst.components.inventory
    local points_gained_this_tick = 0
    
    for k, v in pairs(inv.itemslots) do
        if v and HEALING_VALUES[v.prefab] then
            local item_value = HEALING_VALUES[v.prefab]
            
            while v and v:IsValid() and (inst.wilto_heal_tokens or 0) < MAX_TOKENS do
                points_gained_this_tick = points_gained_this_tick + item_value
                inst.wilto_heal_points = (inst.wilto_heal_points or 0) + item_value
                
                while inst.wilto_heal_points >= POINTS_PER_TOKEN do
                    inst.wilto_heal_points = inst.wilto_heal_points - POINTS_PER_TOKEN
                    inst.wilto_heal_tokens = (inst.wilto_heal_tokens or 0) + 1
                end
                
                if v.components.stackable and v.components.stackable:IsStack() then
                    local single_item = v.components.stackable:Get()
                    single_item:Remove()
                else
                    inv:RemoveItem(v)
                    v:Remove()
                    break 
                end
            end
        end
        
        if (inst.wilto_heal_tokens or 0) >= MAX_TOKENS then
            inst.wilto_heal_points = 0 
            break
        end
    end

    if points_gained_this_tick > 0 and inst.components.talker then
        inst.components.talker:Say(GetRandomItem(speech.HEAL_GATHER))
    end
end

-- =========================================================
-- COMBAT INTELLIGENCE & TARGETING
-- =========================================================

local function ShouldFleeForSurvival(inst)
    if not inst.components.health or inst.components.health:IsDead() then return false end
    
    local hp_percent = inst.components.health:GetPercent()
    local has_armor = false
    
    if inst.components.inventory then
        local body = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
        local head = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if (body and body.components.armor) or (head and head.components.armor) then
            has_armor = true
        end
    end

    -- Panic thresholds: 15% with armor, 30% without armor
    if (has_armor and hp_percent <= 0.15) or (not has_armor and hp_percent <= 0.30) then
        local current_time = GetTime()
        
        -- Apply a 15-second cooldown to prevent dialogue spam
        if inst._last_flee_talk == nil or (current_time - inst._last_flee_talk) > 15 then
            inst._last_flee_talk = current_time
            
            if inst.components.talker and speech ~= nil and speech.COMBAT_FLEE ~= nil then
                inst.components.talker:Say(GetRandomItem(speech.COMBAT_FLEE))
            end
        end
        return true
    end
    
    return false
end

-- Evaluates if the target has any active invincibility frames or magic shields
local function IsTargetVulnerable(target)
    if target == nil or not target:IsValid() then return false end
    
    -- 1. General Invincibility (Works for Klaus, Deerclops spawn, etc.)
    if target.components.health ~= nil and target.components.health:IsInvincible() then
        return false
    end
    
    -- 2. Ancient Fuelweaver (stalker_atrium) specific bypass
    if target.prefab == "stalker_atrium" then
        if target.hasshield or target.shield ~= nil then return false end
        
        if target.components.health ~= nil and target.components.health.externalabsorptmodifiers ~= nil then
            if target.components.health.externalabsorptmodifiers:Get() >= 1 then
                return false
            end
        end
        
        local x, y, z = target.Transform:GetWorldPosition()
        local hands = TheSim:FindEntities(x, y, z, 30, {"stalkerminion"}, {"INLIMBO"})
        if #hands > 0 then return false end
    end
    
    return true
end

local function wiltoretargetfn(inst)
    if inst.sg and inst.sg:HasStateTag("dancing") then return nil end
    if inst.wilto_toggles ~= nil and inst.wilto_toggles.fight == false then return nil end
    
    local leader = inst.components.follower and inst.components.follower:GetLeader()
    if not leader then return nil end

    local target = leader.components.combat and leader.components.combat.target
    
    if target ~= nil and target ~= leader and not target:HasTag("player") 
       and inst.components.combat:CanTarget(target) 
       and IsTargetVulnerable(target) then
        return target
    end

    return nil
end

local function wiltokeeptargetfn(inst, target)
    if inst.wilto_toggles ~= nil and inst.wilto_toggles.fight == false then return false end
    if ShouldFleeForSurvival(inst) then return false end
    
    return inst.components.combat:CanTarget(target) 
       and not (inst.sg and inst.sg:HasStateTag("dancing"))
       and IsTargetVulnerable(target)
end

-- =========================================================
-- SMART EQUIPMENT SYSTEM
-- Evaluates and equips the best weapons and armor automatically.
-- =========================================================

-- Calculates a numeric score for an item to determine if it's an upgrade.
-- Modders can tweak these values to prioritize specific types of gear.
local function GetItemScore(item)
    if not item or not item:IsValid() then return 0 end
    
    -- Evaluate Weapons
    if item.components.weapon ~= nil then
        local dmg = item.components.weapon.damage or 0
        -- Some modded weapons use functions instead of static numbers for damage.
        -- We assign a default estimate to prevent math errors.
        if type(dmg) == "function" then dmg = 15 end 
        
        -- Critical variable: Tool penalty. 
        -- Subtracting 10 from tools ensures Wilto prefers real weapons (like a Spear) 
        -- over tools (like an Axe), even if they do similar damage.
        if item.components.tool ~= nil then dmg = dmg - 10 end 
        return dmg
    end
    
    -- Evaluate Armor
    if item.components.armor ~= nil then
        -- Armor score is based on damage absorption percentage (e.g., 0.8 * 100 = 80 score)
        return (item.components.armor.absorb_percent or 0) * 100
    end
    
    return 0
end

local function EquipBestGear(inst)
    local inv = inst.components.inventory
    if not inv then return end

    local current_weapon = inv:GetEquippedItem(EQUIPSLOTS.HANDS)
    local current_armor = inv:GetEquippedItem(EQUIPSLOTS.BODY)
    local current_helmet = inv:GetEquippedItem(EQUIPSLOTS.HEAD)

    local best_weapon = current_weapon
    local best_armor = current_armor
    local best_helmet = current_helmet

    -- Check if Wilto is currently fighting
    local in_combat = inst.components.combat ~= nil and inst.components.combat.target ~= nil

    for k, item in pairs(inv.itemslots) do
        if item and item:IsValid() and item.components.equippable ~= nil then
            local slot = item.components.equippable.equipslot
            local score = GetItemScore(item)

            if slot == EQUIPSLOTS.BODY then
                if score > GetItemScore(best_armor) then best_armor = item end
            elseif slot == EQUIPSLOTS.HEAD then
                if score > GetItemScore(best_helmet) then best_helmet = item end
            elseif slot == EQUIPSLOTS.HANDS then
                -- Only aggressively swap weapons if actively in combat.
                -- If peaceful, only equip if hands are completely empty.
                if in_combat then
                    if score > GetItemScore(best_weapon) then best_weapon = item end
                else
                    if current_weapon == nil and score > GetItemScore(best_weapon) then
                        best_weapon = item
                    end
                end
            end
        end
    end

    -- Apply the best gear found
    if best_weapon and best_weapon ~= current_weapon then inv:Equip(best_weapon) end
    if best_armor and best_armor ~= current_armor then inv:Equip(best_armor) end
    if best_helmet and best_helmet ~= current_helmet then inv:Equip(best_helmet) end
end

-- =========================================================
-- OCEAN RESCUE SYSTEM
-- Prevents the companion from permanently dying if they fall off a boat.
-- Extracted to file-level to save memory per instance.
-- =========================================================

local function OnWashAshore(inst)
    if inst._ocean_rescue_task ~= nil then
        inst._ocean_rescue_task:Cancel()
        inst._ocean_rescue_task = nil
    end

    inst:RemoveTag("INLIMBO")
    inst.entity:Show()
    inst.Physics:SetActive(true)

    if inst.brain ~= nil then inst.brain:Start() end
    
    -- 'washashore' is a native StateGraph state used by the base game
    if inst.sg ~= nil then inst.sg:GoToState("washashore") end
end

local function RescueFromOcean(inst)
    if inst.components.health and inst.components.health:IsDead() then return end

    -- Temporarily make invincible to prevent dying from random ocean damage during animation
    if inst.components.health then inst.components.health:SetInvincible(true) end

    if inst.components.locomotor then inst.components.locomotor:Stop() end
    if inst.brain then inst.brain:Stop() end
    inst:ClearBufferedAction()

    -- Play sinking animation if the StateGraph supports it
    if inst.sg then
        if inst.sg:HasState("sink") then
            inst.sg:GoToState("sink")
        else
            inst.sg:GoToState("hit")
        end
    end

    local x, y, z = inst.Transform:GetWorldPosition()
    local splash = SpawnPrefab("splash_ocean")
    if splash then splash.Transform:SetPosition(x, y, z) end

    inst:DoTaskInTime(1, function()
        if inst.components.health then
            inst.components.health:SetInvincible(false)
            
            -- Critical variable: Penalty damage for drowning. 
            -- Change -20 to adjust how punishing falling off a boat is.
            inst.components.health:DoDelta(WILTO_STATS.DROWN_DAMAGE, false, "drowning")
        end

        if inst.components.health:IsDead() then return end

        -- Move entity to Limbo so it cannot be attacked or interact while "drowning"
        inst:AddTag("INLIMBO")
        inst.entity:Hide()
        inst.Physics:SetActive(false)

        local leader = inst.components.follower and inst.components.follower:GetLeader()

        if inst._ocean_rescue_task ~= nil then
            inst._ocean_rescue_task:Cancel()
        end

        -- Periodically check if the leader is on safe ground to teleport Wilto
        inst._ocean_rescue_task = inst:DoPeriodicTask(0.5, function()
            if leader ~= nil and leader:IsValid() and leader:IsOnValidGround() then
                local lx, ly, lz = leader.Transform:GetWorldPosition()
                inst.Transform:SetPosition(lx, ly, lz)
                OnWashAshore(inst)
            end
        end)
    end)
end

-- =========================================================
-- EVENT HANDLERS (Extracted to save memory per instance)
-- =========================================================

local function OnLeaderDespawn(inst)
    if inst.components.health and not inst.components.health:IsDead() then
        if inst.components.talker then 
            inst.components.talker:Say(GetRandomItem(speech.LEADER_DESPAWN)) 
        end
        inst.components.health:Kill()
    end
end

local function OnGotNewItem(inst, data)
    if data.item ~= nil and data.item.components.equippable ~= nil then
        inst:DoTaskInTime(0, function()
            -- Ensure item still exists and belongs to Wilto
            if not (data.item:IsValid() and data.item.components.inventoryitem and data.item.components.inventoryitem.owner == inst) then
                return
            end
            
            -- Reject items that cannot go in containers (e.g. active traps)
            if data.item.components.inventoryitem.cangoincontainer == false then
                inst.components.inventory:DropItem(data.item, true, true)
                return
            end

            EquipBestGear(inst)
            inst.SoundEmitter:PlaySound("dontstarve/characters/wilson/equip_item")
        end)
    end
end

local function OnGearBroke(inst)
    inst:DoTaskInTime(0.2, EquipBestGear)
end

-- =========================================================
-- WEAPON BREAK DETECTOR (Combat specific)
-- =========================================================
local function OnAttackOther(inst, data)
    if inst.components.inventory ~= nil then
        local current_weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        -- If the currently equipped weapon is gone (broken or consumed), try to equip the next best weapon immediately.
        if current_weapon == nil then
            if EquipBestGear ~= nil then
                EquipBestGear(inst)
            end
        end
    end
end

local function OnNewTarget(inst, data)
    if inst.wilto_toggles ~= nil and inst.wilto_toggles.fight == false then
        inst:DoTaskInTime(0, function() 
            if inst.components.combat then inst.components.combat:DropTarget() end 
        end)
        return
    end
    -- Equip weapons immediately when acquiring a target
    if data.target ~= nil then EquipBestGear(inst) end
end

local function OnWiltoDeath(inst)
    if inst.components.inventory ~= nil then
        inst.components.inventory:DropEverything(true)
    end
    
    -- Penalize leader sanity on death
    local leader = inst.components.follower:GetLeader()
    if leader ~= nil and leader.components.sanity ~= nil then
        local current_sanity = leader.components.sanity.current
        leader.components.sanity:DoDelta(-(current_sanity * 0.5))
        
        if leader.components.talker ~= nil then
            leader.components.talker:Say(GetRandomItem(speech.LEADER_DIED))
        end
    end
end

local function OnStartFollowing(inst, data)
    if inst._on_leader_despawn ~= nil and inst._old_leader ~= nil then
        inst:RemoveEventCallback("ms_playerreroll", inst._on_leader_despawn, inst._old_leader)
        inst:RemoveEventCallback("ms_playerdespawn", inst._on_leader_despawn, inst._old_leader)
        inst._on_leader_despawn = nil
    end
    
    if data.leader ~= nil then
        inst._old_leader = data.leader
        inst._on_leader_despawn = function() OnLeaderDespawn(inst) end
        inst:ListenForEvent("ms_playerreroll", inst._on_leader_despawn, data.leader)
        inst:ListenForEvent("ms_playerdespawn", inst._on_leader_despawn, data.leader)
    end
end

local function OnCustomSink(inst)
    if inst.components.health and inst.components.health:IsDead() then return end

    inst.components.health:DoDelta(WILTO_STATS.SINK_DAMAGE, false, "drowning")
    if inst.components.health:IsDead() then return end

    inst:AddTag("INLIMBO")
    inst.entity:Hide()
    inst.Physics:SetActive(false)
    
    if inst.components.locomotor then inst.components.locomotor:Stop() end
    if inst.brain then inst.brain:Stop() end
    inst:ClearBufferedAction()

    local leader = inst.components.follower and inst.components.follower:GetLeader()

    if inst._ocean_rescue_task ~= nil then inst._ocean_rescue_task:Cancel() end

    inst._ocean_rescue_task = inst:DoPeriodicTask(0.5, function()
        if leader ~= nil and leader:IsValid() and leader:IsOnValidGround() then
            local lx, ly, lz = leader.Transform:GetWorldPosition()
            inst.Transform:SetPosition(lx, ly, lz)
            OnWashAshore(inst) -- Assumes OnWashAshore is defined above this block
        end
    end)
end

-- =========================================================
-- AMBIENT & POINT OF INTEREST SYSTEM
-- =========================================================

-- Dictionary of specific prefabs that define a "Special Zone"
local SPECIAL_ZONES = {
    {
        key = "AMBIENT_CRABKING",
        check = function(prefab) return prefab == "crabking" or prefab == "crabking_spawner" end
    },
    {
        key = "AMBIENT_BEEQUEEN",
        check = function(prefab) return prefab == "beequeenhivegrown" or prefab == "beequeen" end
    },
    {
        key = "AMBIENT_TOADSTOOL",
        check = function(prefab) return prefab == "toadstool_cap" end
    },
    {
        key = "AMBIENT_KLAUS_SACK",
        check = function(prefab) return prefab == "klaus_sack" end
    },
    {
        key = "AMBIENT_RUINS",
        check = function(prefab) return prefab == "ancient_altar" or prefab == "ancient_altar_broken" end
    },
    {
        key = "AMBIENT_ANCIENT_GATEWAY",
        check = function(prefab) return prefab == "atrium_gateway" or prefab == "ancient_gateway" end
    },
    {
        key = "AMBIENT_LUNAR_ISLAND",
        check = function(prefab) return prefab == "moon_device" or prefab == "moon_altar" or prefab == "moon_fissure" or prefab == "hotspring" end
    },
    {
        key = "AMBIENT_LUNAR_RUINS",
        check = function(prefab) return prefab == "archive_resonator_base" or prefab == "sentrybomb" end
    },
    {
        key = "AMBIENT_LUNAR_RIFT",
        check = function(prefab) return prefab == "lunarrift_portal" or prefab == "lunarrift_crystal_big" end
    },
    {
        key = "AMBIENT_SHADOW_RIFT",
        check = function(prefab) return prefab == "shadowrift_portal" or prefab == "shadowrift_crystal_big" end
    },
    {
        key = "AMBIENT_OASIS",
        check = function(prefab) return prefab == "oasis_lake" end
    },
    {
        key = "AMBIENT_MONKEY_ISLAND",
        check = function(prefab) return prefab == "monkeyqueen" or prefab == "monkey_hut" end
    },
    {
        key = "AMBIENT_WATERLOGGED",
        check = function(prefab) return prefab == "watertree_pillar" or prefab == "watertree_root" end
    },
    {
        key = "AMBIENT_HERMIT",
        check = function(prefab) return prefab == "hermitcrab" or prefab == "hermithouse" end
    }
}

local function OnAmbientTick(inst)
    if inst.sg:HasStateTag("busy") or inst.components.combat:HasTarget() then return end

    if math.random() < 0.3 and inst.components.talker then
        local special_key = nil
        
        -- Let the C++ engine find the specific prefabs, it is much faster
        for _, zone in ipairs(SPECIAL_ZONES) do
            local found_ent = FindEntity(inst, 30, function(ent) 
                return zone.check(ent.prefab) 
            end)
            
            if found_ent ~= nil then
                special_key = zone.key
                break
            end
        end
        
        -- Decide what to say based on what was found
        if special_key ~= nil and speech[special_key] ~= nil then
            inst.components.talker:Say(GetRandomItem(speech[special_key]))
        else
            inst.components.talker:Say(GetRandomItem(speech.AMBIENT))
        end
    end
end

-- =========================================================
-- CORE PREFAB INITIALIZATION
-- =========================================================

local function wiltofn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
    inst.net_heal_tokens = net_smallbyte(inst.GUID, "wilto.heal_tokens")
    inst.net_heal_points = net_smallbyte(inst.GUID, "wilto.heal_points")

    MakeCharacterPhysics(inst, 50, 0.5)
    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBuild("wilto") 
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:AddOverrideBuild("player_emotes")    
    inst.AnimState:AddOverrideBuild("player_emotesxl")  
    inst.AnimState:AddOverrideBuild("emote_laugh")

    inst.AnimState:Hide("ARM_carry")
    inst.AnimState:Hide("HAT")
    inst.AnimState:Hide("HAIR_HAT")

    inst:AddTag("character")
    inst:AddTag("trader") 
    inst:AddTag("alltrader") 
    inst:AddTag("wilto_companion") 
    inst:AddTag("companion") 
    inst:AddTag("NOBLOCK") 
    
    -- Base Memory Setup
    inst.wilto_toggles = { pickup = true, chop = true, mine = true, dig = true, fight = true, give = true, harvest = true }
    inst.wilto_heal_points = 0
    inst.wilto_heal_tokens = 0

    inst.OnSave = function(inst, data)
        if inst.wilto_toggles ~= nil then data.wilto_toggles = inst.wilto_toggles end
        data.wilto_heal_points = inst.wilto_heal_points
        data.wilto_heal_tokens = inst.wilto_heal_tokens
    end

    inst.OnLoad = function(inst, data)
        if data ~= nil then 
            if data.wilto_toggles ~= nil then inst.wilto_toggles = data.wilto_toggles end
            inst.wilto_heal_points = data.wilto_heal_points or 0
            inst.wilto_heal_tokens = data.wilto_heal_tokens or 0
        end
    end

    -- Healing item processor
    inst:DoPeriodicTask(3, ProcessHealingItems)
    
    inst:AddComponent("talker")
    inst.components.talker.fontsize = 35
    inst.components.talker.font = TALKINGFONT 
    inst.components.talker.offset = Vector3(0, -400, 0)
    inst.components.talker:MakeChatter() 
    
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("locomotor")
    inst.components.locomotor.runspeed = WILTO_STATS.RUN_SPEED
    inst.components.locomotor.walkspeed = WILTO_STATS.WALK_SPEED
    inst.components.locomotor:SetAllowPlatformHopping(true)

    inst:AddComponent("embarker")
    inst.components.embarker.embark_speed = inst.components.locomotor.runspeed
    inst.components.embarker.antigravity = true 

    inst:AddComponent("drownable")

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(WILTO_STATS.MAX_HEALTH)
    inst.components.health:StartRegen(WILTO_STATS.REGEN_AMOUNT, WILTO_STATS.REGEN_PERIOD)
        
    MakeMediumBurnableCharacter(inst, "torso")
    MakeMediumFreezableCharacter(inst, "torso")
    inst.components.freezable:SetResistance(2) 
    inst.components.freezable:SetDefaultWearOffTime(1) 

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(WILTO_STATS.BASE_DAMAGE)
    inst.components.combat:SetAttackPeriod(WILTO_STATS.ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(1, wiltoretargetfn)
    inst.components.combat:SetKeepTargetFunction(wiltokeeptargetfn)
    inst.ShouldFleeForSurvival = ShouldFleeForSurvival

    inst:AddComponent("follower")
    inst.components.follower:KeepLeaderOnAttacked()
    inst.components.follower.keepdeadleader = true

    inst:AddComponent("inventory")
    inst.components.inventory.maxslots = 35

    -- Trader Component Setup
    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true 
    inst.components.trader.deleteitemonaccept = false

    -- ============================================================================
    -- COMBAT INTERCEPTORS (Dodge Mechanics & Armor Management)
    -- ============================================================================

    -- 1. RECEIVED DAMAGE HANDLER (Evasion, Stunlock Prevention & Health)
    local old_GetAttacked = inst.components.combat.GetAttacked
    inst.components.combat.GetAttacked = function(self, attacker, damage, weapon, stimuli, spdamage)
        local time_now = GetTime()

        -- Stunlock prevention tracking
        if inst.sg:HasStateTag("hit") or inst.sg:HasStateTag("busy") then
            inst._stunlock_hits = (inst._stunlock_hits or 0) + 1
        else
            inst._stunlock_hits = 0
        end

        -- Force dodge if getting stunlocked
        if inst._stunlock_hits >= 2 then
            inst._stunlock_hits = 0
            inst.sg:GoToState("perfect_dodge", attacker)
            return true 
        end

        -- 25% chance to randomly dodge if not busy, with a 2-second cooldown
        if not inst.sg:HasStateTag("busy") and 
        (inst._last_dodge_time == nil or (time_now - inst._last_dodge_time > 2)) then
            if math.random() < 0.20 then
                inst._last_dodge_time = time_now
                inst.sg:GoToState("perfect_dodge", attacker)
                return true 
            end
        end
        
        -- Pass the FULL damage to the original function (no artificial reduction)
        -- This ensures armors can accurately calculate their absorption
        return old_GetAttacked(self, attacker, damage, weapon, stimuli, spdamage)
    end

    -- 2. ARMOR DURABILITY SAVER (50% Slower Degradation)
    local old_ApplyDamage = inst.components.inventory.ApplyDamage
    inst.components.inventory.ApplyDamage = function(self, damage, attacker, weapon)
        local armors = {}
        local old_TakeDamage = {}
        
        -- Scan equipped armors
        for slot, item in pairs(self.equipslots) do
            if item ~= nil and item.components.armor ~= nil then
                table.insert(armors, item)
                
                -- Store native TakeDamage function
                old_TakeDamage[item] = item.components.armor.TakeDamage
                
                -- Temporarily override the degradation
                item.components.armor.TakeDamage = function(armor_self, damage_amount)
                    -- Multiplier 0.5: Armor loses only half durability
                    return old_TakeDamage[item](armor_self, damage_amount * 0.5)
                end
            end
        end
        
        -- Execute native damage calculation using our overridden durability loss
        local leftover_damage = old_ApplyDamage(self, damage, attacker, weapon)
        
        -- Instantly restore items to their native C++ state
        for _, item in ipairs(armors) do
            if item ~= nil and item.components.armor ~= nil then
                item.components.armor.TakeDamage = old_TakeDamage[item]
            end
        end
        
        return leftover_damage
    end
    
    inst.components.trader:SetAcceptTest(function(inst, item, giver)
        if item.components.inventoryitem and item.components.inventoryitem.cangoincontainer == false then
            return false
        end
        if inst.components.inventory ~= nil then
            if not inst.components.inventory:IsFull() then return true end
            if item.components.stackable ~= nil then
                local has_stack_room = inst.components.inventory:FindItem(function(v)
                    return v.prefab == item.prefab and not v.components.stackable:IsFull()
                end)
                if has_stack_room ~= nil then return true end
            end
            return false
        end
        return true
    end)

    inst.components.trader.onrefuse = function(inst, giver, item)
        if inst.components.talker then
            inst.components.talker:Say(GetRandomItem(speech.INVENTORY_FULL))
        end
    end

    inst.components.trader.onaccept = function(inst, giver, item)
        if inst.components.talker then
            inst.components.talker:Say(GetRandomItem(speech.ITEM_RECEIVED))
        end
    end

    inst:AddComponent("inspectable")
    
    inst:AddComponent("named")
    inst.components.named.possiblenames = { "Wilto" } 

    inst._ignored_items = {}
    setmetatable(inst._ignored_items, {__mode = "k"})

    -- =========================================================
    -- EVENT LISTENERS (Clean & Optimized)
    -- =========================================================
    inst:ListenForEvent("on_fall_in_ocean", RescueFromOcean)
    inst:ListenForEvent("wilto_custom_sink", OnCustomSink)
    inst:ListenForEvent("newcombattarget", OnNewTarget)
    inst:ListenForEvent("gotnewitem", OnGotNewItem)
    inst:ListenForEvent("armorbroke", OnGearBroke)
    --inst:ListenForEvent("weaponbroke", OnGearBroke)
    inst:ListenForEvent("onattackother", OnAttackOther)
    inst:ListenForEvent("death", OnWiltoDeath)
    inst:ListenForEvent("startfollowing", OnStartFollowing)

    -- Ambient chatter tick
    inst:DoPeriodicTask(20 + math.random() * 20, OnAmbientTick)

    inst:SetBrain(brain)
    inst:SetStateGraph("SGwiltolionwilto")

    return inst
end

-- =========================================================
-- BUILDER & REFUND DYNAMICS (Server-Safe)
-- =========================================================
local function onwiltobuilt(inst, builder)
    
    local has_wilto = false
    if builder.components.petleash ~= nil then
        local pets = builder.components.petleash:GetPets()
        if pets ~= nil then
            for pet, _ in pairs(pets) do
                if pet.prefab == "wiltolion_wilto" then
                    has_wilto = true
                    break
                end
            end
        end
    end

    if has_wilto then
        if builder.components.talker then
            builder.components.talker:Say("He is already here with me.")
        end
        
        local recipe = GetValidRecipe("wiltolion_wilto_builder")
        
        if recipe ~= nil and builder.components.inventory ~= nil then
            for i, v in ipairs(recipe.ingredients) do
                if v.amount > 0 and type(v.type) == "string" then
                    local item = SpawnPrefab(v.type)
                    if item ~= nil then
                        if item.components.stackable ~= nil then
                            item.components.stackable:SetStackSize(v.amount)
                            builder.components.inventory:GiveItem(item, nil, builder:GetPosition())
                        else
                            builder.components.inventory:GiveItem(item, nil, builder:GetPosition())
                            if v.amount > 1 then
                                for k = 2, v.amount do
                                    local extra_item = SpawnPrefab(v.type)
                                    if extra_item ~= nil then
                                        builder.components.inventory:GiveItem(extra_item, nil, builder:GetPosition())
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        
        inst:Remove()
        return
    end

    local theta = math.random() * 2 * PI
    local pt = builder:GetPosition()
    local offset = FindWalkableOffset(pt, theta, 3, 12, true, true)
    
    if offset ~= nil then
        pt.x = pt.x + offset.x
        pt.z = pt.z + offset.z
    end

    if builder.components.petleash ~= nil then
        local npc = builder.components.petleash:SpawnPetAt(pt.x, 0, pt.z, "wiltolion_wilto")
        
        if npc then
            local fx1 = SpawnPrefab("halloween_firepuff_1")
            fx1.Transform:SetPosition(pt.x, 0, pt.z)
            fx1.Transform:SetScale(2, 2, 2)
            
            local fx2 = SpawnPrefab("halloween_firepuff_3")
            fx2.Transform:SetPosition(pt.x, 0.5, pt.z)
            fx2.Transform:SetScale(1.8, 1.8, 1.8)
            
            npc.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
            npc.components.follower:SetLeader(builder)
        end
    end
    
    inst:Remove()
end

local function wiltobuilderfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst:AddTag("CLASSIFIED")
    inst.persists = false
    inst:DoTaskInTime(0, inst.Remove)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.OnBuiltFn = onwiltobuilt
    return inst
end

return Prefab("wiltolion_wilto_builder", wiltobuilderfn), 
       Prefab("wiltolion_wilto", wiltofn, assets, prefabs)