require "prefabutil"

-- ==============================================================================
-- ASSETS & PREFABS
-- ==============================================================================
local guard_assets =
{
    Asset("ANIM", "anim/brightmare_gestalt_evolved.zip"),
}
local guard_prefabs =
{
    "gestalt_guard_head",
}

-- ==============================================================================
-- GESTALT CORE MECHANICS & PHYSICS (From Klei's Native Code)
-- ==============================================================================
local function SetTargetPosition(inst, target_pos)
    inst._target_pos = target_pos
end

local function Client_CalcSanityForTransparency(inst, observer)
    local sanity = observer and observer.replica.sanity
    if sanity then
        local x = math.max(0, sanity:GetPercentWithPenalty() - TUNING.GESTALT_MIN_SANITY_TO_SPAWN) / (1 - TUNING.GESTALT_MIN_SANITY_TO_SPAWN)
        return math.min(0.4*x*x*x + 0.3, 0.75)
    else
        return 0.3
    end
end

local function SetHeadAlpha(inst, alpha)
    if inst.blobhead ~= nil and inst.blobhead:IsValid() then
        inst.blobhead.AnimState:OverrideMultColour(1, 1, 1, alpha)
    end
end

local function stop_motion(inst)
    if inst._attack_task ~= nil then
        inst._attack_task:Cancel()
        inst._attack_task = nil
    end

    inst.AnimState:PlayAnimation("mutate")
    if inst._force_end_position_callback then
        inst.Physics:SetMotorVelOverride(0, 0, 0)
        if inst.Transform then
            inst.Transform:SetPosition(inst._target_pos:Get()) 
        else
            inst.Physics:Teleport(inst._target_pos:Get())
        end
        inst:_force_end_position_callback()
    else
        inst.Physics:SetMotorVelOverride(2, 0, 0)
    end
end

local function attack_behaviour(inst, target)
    if inst.components.combat ~= nil then
        if inst.components.combat:CanTarget(target) then
            
            -- MULTIPLICADOR ANTI-SOMBRAS: Si el objetivo es una sombra, doble daño.
            local is_shadow = target:HasTag("shadow") or target:HasTag("shadowcreature") or target:HasTag("shadowchesspiece") or target:HasTag("nightmarecreature")
            local mult = is_shadow and 2.0 or 1.0
            
            inst.components.combat:SetDefaultDamage(50 * mult)

            -- Este trigger aplica tanto el daño base como el planar
            inst.components.combat:DoAttack(target)
            return true
        else
            return false
        end
    elseif target.components.combat and not target.components.combat:CanBeAttacked() then
        return false
    else
        target:PushEvent("attacked", {attacker = inst, damage = 0})
        return true
    end
end

local function try_attack(inst)
    local target = inst:find_attack_victim()
    if target ~= nil then
        if attack_behaviour(inst, target) then
            if inst._stop_task ~= nil then
                inst._stop_task:Cancel()
                inst._stop_task = nil
            end
            stop_motion(inst)
        end
    end
end

local function start_motion(inst)
    inst.Physics:SetMotorVelOverride(inst.attack_speed * (inst.attack_speed_mod or 1), 0, 0)
    if not inst._no_combat_gestalt then
        inst._attack_task = inst:DoPeriodicTask(2*FRAMES, try_attack)
    end
end

local FLY_START_TIME = 15 * FRAMES
local FLY_END_TIME = 60 * FRAMES
local TIME_TO_FLY = FLY_END_TIME - FLY_START_TIME - FRAMES

-- 3. Modificamos la función 'on_anim_over' para que el Gestalt
-- ajuste su rotación y busque al enemigo con más precisión.
local function on_anim_over(inst)
    if inst.AnimState:IsCurrentAnimation("emerge") then
        if inst._target_pos ~= nil then
            inst:ForceFacePoint(inst._target_pos:Get())
        elseif inst._focustarget and inst._focustarget:IsValid() then
            -- If we have a live target, face it directly
            inst:ForceFacePoint(inst._focustarget.Transform:GetWorldPosition())
        else
            inst.Transform:SetRotation(math.random() * 360)
        end
        inst.AnimState:PlayAnimation("attack")

        inst:DoTaskInTime(FLY_START_TIME, start_motion)
        
        -- The stop_task now allows for a much longer flight
        inst._stop_task = inst:DoTaskInTime(FLY_END_TIME, stop_motion)

    elseif inst.AnimState:IsCurrentAnimation("mutate") then
        inst:Remove()
    end
end

local function on_entity_sleep(inst)
    if not POPULATING then
        inst._esleep_remove_task = inst:DoTaskInTime(3, inst.Remove)
    end
end

local function on_entity_wake(inst)
    if inst._esleep_remove_task ~= nil then
        inst._esleep_remove_task:Cancel()
        inst._esleep_remove_task = nil
    end
end

-- ==============================================================================
-- WILTOLION GESTALT PROJECTILE SETUP
-- ==============================================================================
local HATGUARD_COMBAT_MUSHAVE_TAGS = { "_combat", "_health" }
local HATGUARD_COMBAT_CANTHAVE_TAGS = { "INLIMBO", "structure", "wall", "companion" }

-- Targeting logic
local function hatguard_find_attack_victim(inst)
    local hitrange = 2
    if inst._focustarget then
        return inst._focustarget:IsValid() and inst:GetDistanceSqToInst(inst._focustarget) < hitrange * hitrange and inst._focustarget or nil
    end

    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, hitrange, HATGUARD_COMBAT_MUSHAVE_TAGS, HATGUARD_COMBAT_CANTHAVE_TAGS)
    for _, target in ipairs(ents) do
        if (target.components.health ~= nil and not target.components.health:IsDead())
            and (target.components.combat ~= nil and not inst.components.combat:TargetHasFriendlyLeader(target) and inst.components.combat:CanTarget(target)) then
            return target
        end
    end
end

local HATGUARD_SCALE = 0.8
local function hatguard_common_postinit(inst)
    inst.Transform:SetScale(HATGUARD_SCALE, HATGUARD_SCALE, HATGUARD_SCALE)

    if not TheNet:IsDedicated() then
        if inst.blobhead ~= nil then
            inst.blobhead.Transform:SetScale(HATGUARD_SCALE, HATGUARD_SCALE, HATGUARD_SCALE)
        end
    end
end

local GUARD_HEADDATA =
{
    name = "gestalt_guard_head",
    followsymbol = "head_fx_big",
}
local GUARD_TAGS = { "brightmare_guard", "crazy", "extinguisher" }
local SPIKE_LAYER = {"angry"}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()
    
    local phys = inst.entity:AddPhysics()
    phys:SetMass(1)
    phys:SetFriction(0)
    phys:SetDamping(5)
    phys:SetCollisionGroup(COLLISION.FLYERS)
    phys:SetCollisionMask(COLLISION.GROUND)
    phys:SetCapsule(0.5, 1)

    inst:AddTag("brightmare")
    inst:AddTag("NOBLOCK")
    inst:AddTag("NOCLICK")
    inst:AddTag("lunar_aligned")

    for _, tag in ipairs(GUARD_TAGS) do
        inst:AddTag(tag)
    end

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBuild("brightmare_gestalt_evolved")
    inst.AnimState:SetBank("brightmare_gestalt_evolved")
    inst.AnimState:PlayAnimation("emerge")
    inst.AnimState:Hide("mouseover")

    local colour_mult = TUNING.GESTALT_COMBAT_TRANSPERENCY
    inst.AnimState:SetMultColour(1, 1, 1, colour_mult)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:Hide("angry") -- Hide the angry spikes

    if not TheNet:IsDedicated() then
        inst.blobhead = SpawnPrefab(GUARD_HEADDATA.name)
        inst.blobhead.entity:SetParent(inst.entity) 
        inst.blobhead.Follower:FollowSymbol(inst.GUID, GUARD_HEADDATA.followsymbol, 0, 0, 0)
        inst.blobhead.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        inst.highlightchildren = { inst.blobhead }

        inst:AddComponent("transparentonsanity")
        inst.components.transparentonsanity.most_alpha = .8
        inst.components.transparentonsanity.osc_amp = .05
        inst.components.transparentonsanity.osc_speed = 5.25 + math.random() * 0.5
        inst.components.transparentonsanity.calc_percent_fn = Client_CalcSanityForTransparency
        inst.components.transparentonsanity.onalphachangedfn = SetHeadAlpha
        inst.components.transparentonsanity:ForceUpdate()
    end

    hatguard_common_postinit(inst)

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    inst.SetTargetPosition = SetTargetPosition
    inst.scrapbook_hide = SPIKE_LAYER
    inst.attack_speed = TUNING.ALTERGUARDIAN_PROJECTILE_SPEED / HATGUARD_SCALE
    inst.find_attack_victim = hatguard_find_attack_victim

    -- ADD COMBAT COMPONENT AND SET EXACTLY 50 DAMAGE
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(55)
    inst.components.combat:SetRange(TUNING.GESTALTGUARD_ATTACK_RANGE)
    inst:AddComponent("planardamage")
    inst.components.planardamage:SetBaseDamage(20)

    inst:AddComponent("follower")
    inst.components.follower:KeepLeaderOnAttacked()
    inst.components.follower.keepdeadleader = true
    inst.components.follower.keepleaderduringminigame = true

    inst:ListenForEvent("animover", on_anim_over)
    inst.OnEntitySleep = on_entity_sleep
    inst.OnEntityWake = on_entity_wake

    return inst
end

return Prefab("wiltolion_gestalt_projectile", fn, guard_assets, guard_prefabs)