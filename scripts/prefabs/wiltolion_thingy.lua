local assets =
{
    Asset("ANIM", "anim/ds_spider_cannon.zip"),
    Asset("ANIM", "anim/wiltolion_thingy.zip"),
    Asset("ANIM", "anim/ds_spider_parasite_death.zip"),
    Asset("SOUND", "sound/spider.fsb"),
}

local prefabs =
{
    "spider_heal_target_fx",
}

local brain = require("brains/wiltolionthingybrain")

-- ==========================================================
-- AI AND BASIC BEHAVIOR
-- ==========================================================
local function NormalRetarget(inst)
    local leader = inst.components.follower:GetLeader()
    return FindEntity(inst, 8, function(guy)
        -- Added strict validity check for external target safety
        return guy ~= nil 
            and guy:IsValid() 
            and guy ~= leader 
            and inst.components.combat:CanTarget(guy)
            and not (guy.components.follower and guy.components.follower:GetLeader() == leader)
    end, { "_combat", "_health" }, { "INLIMBO", "companion", "player" })
end

local function keeptargetfn(inst, target)
   return target ~= nil
        and target:IsValid()
        and target.components.combat ~= nil
        and target.components.health ~= nil
        and not target.components.health:IsDead()
        and not (inst.components.follower ~= nil and
                (inst.components.follower:GetLeader() == target or inst.components.follower:IsLeaderSame(target)))
end

-- ==========================================================
-- AURA SYSTEM (BUFFS)
-- ==========================================================
local function RemoveBuff(target)
    if not target or not target:IsValid() then 
        return 
    end
    
    target:RemoveTag("wiltolion_buffed")

    if target.components.combat then
        if target.components.combat.externaldamagemultipliers then
            target.components.combat.externaldamagemultipliers:RemoveModifier(target, "wiltolion_spider_buff")
        end
        if target.components.combat.externaldamagetakenmultipliers then
            target.components.combat.externaldamagetakenmultipliers:RemoveModifier(target, "wiltolion_spider_buff")
        end
    end

    if target.components.locomotor then
        target.components.locomotor:RemoveExternalSpeedMultiplier(target, "wiltolion_spider_buff")
    end
    
    if target.spider_buff_task ~= nil then
        target.spider_buff_task:Cancel()
        target.spider_buff_task = nil
    end
end

local function ApplyBuff(inst, target)
    if not target or not target:IsValid() or target:HasTag("wiltolion_buffed") then
        return
    end
    if target:HasTag("playerghost") or target:HasTag("INLIMBO") or target:HasTag("structure") or target:HasTag("wall") then
        return
    end
    if not target.components.health or target.components.health:IsDead() or not target.components.combat then
        return
    end

    target:AddTag("wiltolion_buffed")

    local target_fx = SpawnPrefab("spider_heal_target_fx")
    if target_fx then
        target_fx.Transform:SetPosition(target.Transform:GetWorldPosition())
        target_fx.Transform:SetScale(1.2, 1.2, 1.2)
    end

    if target.components.combat.externaldamagemultipliers then
        target.components.combat.externaldamagemultipliers:SetModifier(target, 1.15, "wiltolion_spider_buff")
    end
    
    if target.components.combat.externaldamagetakenmultipliers then
        local current_mult = target.components.combat.externaldamagetakenmultipliers:Get()
        local defense_modifier = 0.85
        
        if current_mult >= 1.0 and not target:HasTag("player") then
            defense_modifier = 0.70 
        end
        
        target.components.combat.externaldamagetakenmultipliers:SetModifier(target, defense_modifier, "wiltolion_spider_buff")
    end

    if target.components.locomotor then
        target.components.locomotor:SetExternalSpeedMultiplier(target, "wiltolion_spider_buff", 1.15)
    end
    
    target:ListenForEvent("death", RemoveBuff)
    target:ListenForEvent("onremove", RemoveBuff)
    
    target.spider_buff_task = target:DoTaskInTime(120, function(t)
        t:RemoveEventCallback("death", RemoveBuff)
        t:RemoveEventCallback("onremove", RemoveBuff)
        RemoveBuff(t)
    end)
end

-- ==========================================================
-- DUAL TICKS (BUFF AND HEAL)
-- ==========================================================
local function OnBuffTick(inst)
    local px, py, pz = inst.Transform:GetWorldPosition()
    local allies = TheSim:FindEntities(px, py, pz, 24, { "_health" }, { "INLIMBO", "playerghost", "hostile" }, { "player", "companion", "wiltolion_buddy", "wiltolion_wilto" })
    
    for _, ally in ipairs(allies) do
        if ally:IsValid() and ally.components.health and not ally.components.health:IsDead() then
            ApplyBuff(inst, ally)
        end
    end
end

local function OnHealTick(inst)
    local current_time = GetTime()

    -- 1. Safely clean expired blacklist entries
    if inst.heal_blacklist then
        for guid, expire_time in pairs(inst.heal_blacklist) do
            if current_time >= expire_time then
                inst.heal_blacklist[guid] = nil
                if inst.heal_amounts then
                    inst.heal_amounts[guid] = nil
                end
            end
        end
    end

    -- 2. Execute healing trigger logic
    local target = inst.target_to_heal
    
    if target and target:IsValid() and not target:HasTag("playerghost") then
        if target.components.health and not target.components.health:IsDead() then
            -- Trigger jump when inside the safe Brain radius (14 units)
            if inst:IsNear(target, 14) then
                local hp_pct = target.components.health:GetPercent()
                
                if hp_pct < 0.55 then
                    inst:PushEvent("do_aoe_heal_jump")
                    inst.target_to_heal = nil 
                else
                    inst.heal_blacklist = inst.heal_blacklist or {}
                    inst.heal_blacklist[target.GUID] = current_time + 30
                    inst.target_to_heal = nil
                end
            end
        else
            inst.target_to_heal = nil
        end
    else
        inst.target_to_heal = nil
    end
end

-- ==========================================================
-- PREFAB CONSTRUCTOR
-- ==========================================================
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 10, .5)

    inst.DynamicShadow:SetSize(1.5, .5)
    inst.Transform:SetFourFaced()

    inst.entity:AddLight()

    inst.Light:SetRadius(1.5)      
    inst.Light:SetFalloff(1)     
    inst.Light:SetIntensity(0.4)   

    inst.Light:SetColour(255/255, 230/255, 150/255) 

    inst.Light:Enable(true)

    inst:AddTag("companion")   
    inst:AddTag("NOBLOCK")      
    inst:AddTag("cavedweller")
    inst:AddTag("scarytoprey")
    inst:AddTag("smallcreature")
    inst:AddTag("noaurahit")

    inst.AnimState:SetBank("spider")
    inst.AnimState:SetBuild("wiltolion_thingy")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.heal_blacklist = {}
    inst.heal_amounts = {}
    inst.target_to_heal = nil
    
    -- Store tasks within the inst to manage them later
    inst.buff_task = inst:DoPeriodicTask(20, OnBuffTick)
    inst.heal_task = inst:DoPeriodicTask(2, OnHealTick)

    -- Define a generic cleanup function to prevent memory leaks
    local function OnRemoveThingy(spider)
        if spider.buff_task ~= nil then
            spider.buff_task:Cancel()
            spider.buff_task = nil
        end
        if spider.heal_task ~= nil then
            spider.heal_task:Cancel()
            spider.heal_task = nil
        end
    end

    -- Trigger cleanup when the spider dies or is despawned
    inst:ListenForEvent("death", OnRemoveThingy)
    inst:ListenForEvent("onremove", OnRemoveThingy)

    inst.AnimState:SetLightOverride(0.85)

    inst:DoPeriodicTask(4, function(spider)
        if spider.AnimState then
            spider.AnimState:SetLightOverride(0.85)
        end
    end)

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 7
    inst.components.locomotor.runspeed = 10
    inst.components.locomotor:SetAllowPlatformHopping(true)

    inst:SetStateGraph("SGwiltolionthingy")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.SPIDER_HEALER_HEALTH or 400)

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "body"
    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_HEALER_DAMAGE or 20)
    inst.components.combat:SetAttackPeriod(TUNING.SPIDER_ATTACK_PERIOD or 2)
    inst.components.combat:SetRetargetFunction(1, NormalRetarget)
    inst.components.combat:SetKeepTargetFunction(keeptargetfn)

    inst:AddComponent("follower")
    inst.components.follower.keepleaderonplayerdeath = true
    inst.components.follower.keepdeadleader = true 
    inst.components.follower:KeepLeaderOnAttacked()

    inst:AddComponent("inspectable")
    inst:AddComponent("knownlocations")
    inst:AddComponent("embarker")
    inst:AddComponent("drownable")

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater:SetStrongStomach(true)
    inst.components.eater:SetCanEatRawMeat(true)
    
    MakeMediumFreezableCharacter(inst, "body")
    MakeHauntablePanic(inst)

    inst:SetBrain(brain)
    inst.incineratesound = "dontstarve/creatures/spider/die"

    -- ==========================================================
    -- SUMMONING AND LIMIT SYSTEM
    -- ==========================================================
    inst:ListenForEvent("onbuilt", function(spider, data)
        local builder = data and data.builder
        if builder and builder.components.petleash then
            local pets = builder.components.petleash:GetPets()
            
            local oldest_thingy = nil
            local min_spawn_time = math.huge
            local thingy_count = 0
            
            for pet_inst, _ in pairs(pets) do
                if pet_inst.prefab == "wiltolion_thingy" then
                    thingy_count = thingy_count + 1
                    
                    local spawn_time = pet_inst.thingy_spawn_time or 0
                    if spawn_time < min_spawn_time then
                        oldest_thingy = pet_inst
                        min_spawn_time = spawn_time
                    end
                end
            end
            
            if thingy_count >= 2 and oldest_thingy ~= nil then
                oldest_thingy.SoundEmitter:PlaySound("dontstarve/common/fireOut")
                builder.components.petleash:DespawnPet(oldest_thingy)
            end

            local x, y, z = spider.Transform:GetWorldPosition()
            local real_thingy = builder.components.petleash:SpawnPetAt(x, y, z, "wiltolion_thingy")
            
            if real_thingy then
                real_thingy.thingy_spawn_time = GetTime()
                if real_thingy.sg then
                    real_thingy.sg:GoToState("born")
                end
            end
            
            spider:Hide() 
            spider:DoTaskInTime(0, spider.Remove) 
        end
    end)

    return inst
end

return Prefab("wiltolion_thingy", fn, assets, prefabs)