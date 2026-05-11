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
        -- Never target the leader or anyone the leader is protecting
        return guy ~= leader 
            and inst.components.combat:CanTarget(guy)
            and not (guy.components.follower and guy.components.follower:GetLeader() == leader)
    end, { "_combat", "_health" }, { "INLIMBO", "companion", "player" })
end

local function keeptargetfn(inst, target)
   return target ~= nil
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
    
    target.spider_buff_task = nil
end

local function ApplyBuff(inst, target)
    -- Visual effects
    local target_fx = SpawnPrefab("spider_heal_target_fx")
    if target_fx then
        target_fx.Transform:SetPosition(target.Transform:GetWorldPosition())
        target_fx.Transform:SetScale(1.2, 1.2, 1.2)
    end

    local spider_fx = SpawnPrefab("spider_heal_target_fx")
    if spider_fx then
        spider_fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        spider_fx.Transform:SetScale(1.2, 1.2, 1.2)
    end

    -- Stat buffs
    if target.components.combat then
        if target.components.combat.externaldamagemultipliers then
            target.components.combat.externaldamagemultipliers:SetModifier(target, 1.15, "wiltolion_spider_buff")
        end
        if target.components.combat.externaldamagetakenmultipliers then
            target.components.combat.externaldamagetakenmultipliers:SetModifier(target, 0.85, "wiltolion_spider_buff")
        end
    end

    if target.components.locomotor then
        target.components.locomotor:SetExternalSpeedMultiplier(target, "wiltolion_spider_buff", 1.15)
    end

    -- Task management to remove buffs
    if target.spider_buff_task ~= nil then
        target.spider_buff_task:Cancel()
    end
    
    target.spider_buff_task = target:DoTaskInTime(11, RemoveBuff)
end

-- ==========================================================
-- DUAL TICKS (BUFF AND HEAL SEPARATED)
-- ==========================================================
local function OnBuffTick(inst)
    local px, py, pz = inst.Transform:GetWorldPosition()
    local allies = TheSim:FindEntities(px, py, pz, 24, nil, { "INLIMBO", "playerghost", "hostile" }, { "player", "companion", "wiltolion_buddy", "wiltolion_wilto" })
    
    for _, ally in ipairs(allies) do
        if ally:IsValid() and ally.components.health and not ally.components.health:IsDead() then
            ApplyBuff(inst, ally)
        end
    end
end

local function OnHealTick(inst)
    local current_time = GetTime()

    -- Clean the blacklist
    if inst.heal_blacklist then
        for guid, expire_time in pairs(inst.heal_blacklist) do
            if current_time >= expire_time then
                inst.heal_blacklist[guid] = nil
            end
        end
    end

    -- Active healing logic based on brain target
    local target = inst.target_to_heal
    if target and target:IsValid() then
        if target.components.health and not target.components.health:IsDead() and not target:HasTag("playerghost") then
            if inst:IsNear(target, 4) then
                local hp_pct = target.components.health:GetPercent()
                
                if hp_pct < 0.45 then
                    target.components.health:DoDelta(5, false, inst.prefab)
                    
                    local fx = SpawnPrefab("spider_heal_target_fx")
                    if fx then 
                        fx.Transform:SetPosition(target.Transform:GetWorldPosition())
                        fx.Transform:SetScale(1, 1, 1)
                    end
                    
                    inst:PushEvent("play_subtle_heal")
                    inst.SoundEmitter:PlaySound("webber1/creatures/spider_cannonfodder/heal_fartcloud")
                    
                    if target.components.health:GetPercent() >= 0.45 then
                        inst.heal_blacklist[target.GUID] = current_time + 90
                        inst.target_to_heal = nil
                    end
                else
                    inst.heal_blacklist[target.GUID] = current_time + 90
                    inst.target_to_heal = nil
                end
            end
        else
            -- Clear target if invalid state
            inst.target_to_heal = nil
        end
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

    -- Optimized tags for pet
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

    -- Passive healing variables
    inst.heal_blacklist = {}
    inst.target_to_heal = nil
    
    inst:DoPeriodicTask(10, OnBuffTick)
    inst:DoPeriodicTask(2, OnHealTick)

    inst.AnimState:SetLightOverride(0.85)
    inst:DoPeriodicTask(4, function(spider)
        if spider.AnimState then
            spider.AnimState:SetLightOverride(0.85)
        end
    end)

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.SPIDER_WALK_SPEED
    inst.components.locomotor.runspeed = TUNING.SPIDER_RUN_SPEED
    inst.components.locomotor:SetAllowPlatformHopping(true)

    inst:SetStateGraph("SGwiltolionthingy")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.SPIDER_HEALER_HEALTH)

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "body"
    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_HEALER_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.SPIDER_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(1, NormalRetarget)
    inst.components.combat:SetKeepTargetFunction(keeptargetfn)

    inst:AddComponent("follower")
    inst.components.follower.keepleaderonplayerdeath = true
    -- FIX: Native flag required to keep following a ghost player
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

    MakeMediumBurnableCharacter(inst, "body")
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