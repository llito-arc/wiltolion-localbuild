local assets = {
    Asset("ANIM", "anim/wiltolion_torus.zip"),
    Asset("IMAGE", "images/inventoryimages/wiltolion_torus.tex"),
    Asset("XML", "images/inventoryimages/wiltolion_torus.xml"),
}

-- [[ FOOD AFFINITY ]]
local food_affinities = {
    ["dragonpie"] = 1.15, 
}

-- [[ SECTION: FORCEFIELD LOGIC ]]
local FORCEFIELD_DURATION = 15
local FORCEFIELD_COOLDOWN = 120
local HITS_REQUIRED = 4
local HIT_WINDOW = 1.5

-- Notifica al gestor del jugador (en el modmain) para que actualice el bloom
local function NotifyOwnerVisuals(inst, is_glowing)
    if inst.components.inventoryitem then
        -- GetGrandOwner asegura que encontremos al jugador incluso si el Torus está dentro de una mochila equipada
        local owner = inst.components.inventoryitem:GetGrandOwner()
        if owner and owner:HasTag("player") then
            owner:PushEvent("wiltolion_torus_statechange", { is_glowing = is_glowing })
        end
    end
end

-- Apagar el escudo de fuerza
local function TurnOffForceField(inst, owner_override)
    local owner = owner_override or inst._forcefield_owner or (inst.components.inventoryitem and inst.components.inventoryitem.owner)
    
    if inst._fx ~= nil then
        inst._fx:kill_fx()
        inst._fx = nil
    end
    
    if owner and owner:IsValid() then
        if owner.components.health then
            owner.components.health:SetInvincible(false)
        end
        if owner.components.inventory and inst._original_applydamage ~= nil then
            if owner.components.inventory.ApplyDamage == inst._torus_applydamage then
                owner.components.inventory.ApplyDamage = inst._original_applydamage
            end
        end
    end
    
    inst._forcefield_owner = nil
    inst._original_applydamage = nil
    inst._torus_applydamage = nil
    
    if inst._forcefield_task ~= nil then
        inst._forcefield_task:Cancel()
        inst._forcefield_task = nil
    end
end

-- Encender el escudo de fuerza
local function TurnOnForceField(inst, owner)
    inst._on_cooldown = true
    inst._hit_count = 0
    
    -- El Torus se apaga por el esfuerzo (Avisamos al jugador)
    NotifyOwnerVisuals(inst, false)
    
    inst._forcefield_owner = owner 
    
    if inst._fx ~= nil then
        inst._fx:kill_fx()
    end
    inst._fx = SpawnPrefab("forcefieldfx")
    inst._fx.entity:SetParent(owner.entity)
    inst._fx.Transform:SetPosition(0, 0.2, 0)
    inst._fx.AnimState:SetMultColour(0.6, 0.6, 0.6, 0.9) 
    inst._fx.AnimState:SetAddColour(0.8, 0.8, 0.4, 0) 
    
    if owner.components.health then
        owner.components.health:SetInvincible(true)
    end
    
    if owner.components.inventory and inst._original_applydamage == nil then
        inst._original_applydamage = owner.components.inventory.ApplyDamage
        inst._torus_applydamage = function(self, damage, attacker, weapon)
            if inst._fx ~= nil then return damage end
            return inst._original_applydamage(self, damage, attacker, weapon)
        end
        owner.components.inventory.ApplyDamage = inst._torus_applydamage
    end
    
    inst._forcefield_task = inst:DoTaskInTime(FORCEFIELD_DURATION, TurnOffForceField)
    
    -- Iniciar cuenta regresiva para que vuelva a brillar
    inst:DoTaskInTime(FORCEFIELD_COOLDOWN, function(i) 
        i._on_cooldown = false 
        -- Cooldown termina (Avisamos al jugador para que el bloom regrese)
        NotifyOwnerVisuals(i, true)
    end)
end

local function OnAttacked(inst, owner, data)
    if inst._on_cooldown or inst._fx ~= nil then return end
    
    local current_time = GetTime()
    if current_time - (inst._hit_window_start or 0) > HIT_WINDOW then
        inst._hit_count = 1
        inst._hit_window_start = current_time
    else
        inst._hit_count = (inst._hit_count or 0) + 1
    end
    
    if inst._hit_count >= HITS_REQUIRED then
        TurnOnForceField(inst, owner)
    end
end

local function UpdateSpeed(inst, owner)
    if not owner or not owner:IsValid() then return end
    local mult = 1.0 
    if TheWorld.state.isday then
        mult = 1.15
    elseif TheWorld.state.isnight then
        mult = 0.90 
    end
    if owner.components.locomotor then
        owner.components.locomotor:SetExternalSpeedMultiplier(inst, "wiltolion_torus_speed", mult)
    end
end

local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_hat", "wiltolion_torus", "swap_hat")
    owner.AnimState:Show("HAT")
    owner.AnimState:Hide("HAIR_HAT")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
    
    if owner:HasTag("player") then
        owner.AnimState:Show("HEAD")
        owner.AnimState:Hide("HEAD_HAT")
    end

    -- El LightOverride funciona nativamente sin desincronizar redes, podemos dejarlo.
    owner.AnimState:SetSymbolLightOverride("swap_hat", 1)

    UpdateSpeed(inst, owner)
    inst:WatchWorldState("isday", function() UpdateSpeed(inst, owner) end)
    inst:WatchWorldState("isnight", function() UpdateSpeed(inst, owner) end)
    
    inst._onattacked = function(owner_inst, data) OnAttacked(inst, owner_inst, data) end
    inst:ListenForEvent("attacked", inst._onattacked, owner)

    -- Le decimos al jugador que hemos sido equipados y si debemos brillar o no
    NotifyOwnerVisuals(inst, not inst._on_cooldown)
end

local function OnUnequip(inst, owner)
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAIR_HAT")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
    
    if owner:HasTag("player") then
        owner.AnimState:Show("HEAD")
        owner.AnimState:Hide("HEAD_HAT")
    end

    owner.AnimState:SetSymbolLightOverride("swap_hat", 0)

    if owner.components.locomotor then
        owner.components.locomotor:RemoveExternalSpeedMultiplier(inst, "wiltolion_torus_speed")
    end
    inst:StopWatchingWorldState("isday")
    inst:StopWatchingWorldState("isnight")
    
    if inst._onattacked ~= nil then
        inst:RemoveEventCallback("attacked", inst._onattacked, owner)
        inst._onattacked = nil
    end
    TurnOffForceField(inst, owner)
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("wiltolion_torus")
    inst.AnimState:SetBuild("wiltolion_torus")
    inst.AnimState:PlayAnimation("ground")
    
    -- El objeto en el suelo brilla nativamente (Klei maneja esto sin problemas)
    inst.AnimState:SetLightOverride(1)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    
    inst:AddTag("hat")
    inst:AddTag("wiltolion_torus")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    -- Variables del Servidor
    inst._hit_count = 0
    inst._hit_window_start = 0
    inst._on_cooldown = false
    inst._fx = nil
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "wiltolion_torus"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/wiltolion_torus.xml"
    
    inst:AddComponent("armor")
    inst.components.armor:InitIndestructible(0.20)
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    
    inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(30)
    
    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALL)
    
    inst:AddComponent("tradable")
    inst:AddComponent("inspectable")
    
    MakeHauntableLaunch(inst)
    
    return inst
end

return Prefab("wiltolion_torus", fn, assets)