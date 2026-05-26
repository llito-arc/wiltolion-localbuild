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
local HITS_REQUIRED = 3
local HIT_WINDOW = 2.0

-- Notify the player's client to handle visual blooms
local function NotifyOwnerVisuals(inst, is_glowing)
    if inst.components.inventoryitem then
        local owner = inst.components.inventoryitem:GetGrandOwner()
        if owner and owner:HasTag("player") then
            owner:PushEvent("wiltolion_torus_statechange", { is_glowing = is_glowing })
        end
    end
end

-- Safely turns off the forcefield, removing FX and restoring original mechanics
local function TurnOffForceField(inst, owner_override)
    local owner = owner_override or inst._forcefield_owner or (inst.components.inventoryitem and inst.components.inventoryitem.owner)
    
    inst._forcefield_active = false

    if owner and owner:IsValid() then
        owner:RemoveTag("forcefield")
        
        if owner.components.inventory and inst._original_applydamage ~= nil then
            owner.components.inventory.ApplyDamage = inst._original_applydamage
            inst._original_applydamage = nil
        end
    end

    if inst._fx ~= nil then
        if inst._fx:IsValid() then
            inst._fx:kill_fx()
        end
        inst._fx = nil
    end
    
    inst._forcefield_owner = nil
    
    if inst._forcefield_task ~= nil then
        inst._forcefield_task:Cancel()
        inst._forcefield_task = nil
    end
end

-- Triggers the forcefield, preventing stun, armor degradation, and health loss
local function TurnOnForceField(inst, owner)
    inst._on_cooldown = true
    inst._forcefield_active = true
    inst._forcefield_owner = owner 
    
    owner:AddTag("forcefield")
    NotifyOwnerVisuals(inst, false)
    
    if inst._fx ~= nil then
        inst._fx:kill_fx()
    end
    inst._fx = SpawnPrefab("forcefieldfx")
    inst._fx.entity:SetParent(owner.entity)
    inst._fx.Transform:SetPosition(0, 0.2, 0)
    inst._fx.AnimState:SetMultColour(0.6, 0.6, 0.6, 0.9) 
    inst._fx.AnimState:SetAddColour(0.8, 0.8, 0.4, 0) 
    
    if owner.components.inventory and inst._original_applydamage == nil then
        inst._original_applydamage = owner.components.inventory.ApplyDamage
        owner.components.inventory.ApplyDamage = function(inv_self, damage, attacker, weapon)
            if inst._forcefield_active then
                return 0 
            end
            return inst._original_applydamage(inv_self, damage, attacker, weapon)
        end
    end
    
    inst._forcefield_task = inst:DoTaskInTime(FORCEFIELD_DURATION, TurnOffForceField, owner)
    
    inst._cooldown_task = inst:DoTaskInTime(FORCEFIELD_COOLDOWN, function(i) 
        i._on_cooldown = false 
        NotifyOwnerVisuals(i, true)
    end)
end

-- Rolling Window Hit Tracker
local function OnAttacked(inst, owner, data)
    if inst._on_cooldown or inst._forcefield_active then return end
    
    if inst._recent_hits == nil then
        inst._recent_hits = {}
    end
    
    local current_time = GetTime()
    table.insert(inst._recent_hits, current_time)
    
    for i = #inst._recent_hits, 1, -1 do
        if current_time - inst._recent_hits[i] > HIT_WINDOW then
            table.remove(inst._recent_hits, i)
        end
    end
    
    if #inst._recent_hits >= HITS_REQUIRED then
        inst._recent_hits = {} 
        TurnOnForceField(inst, owner)
    end
end

-- Handles movement speed changes based on the day cycle
local function UpdateSpeed(inst, owner)
    if not owner or not owner:IsValid() then return end
    local mult = 1.0 
    if TheWorld.state.isday then
        mult = 1.15
    elseif TheWorld.state.isnight then
        mult = 0.95
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

    owner.AnimState:SetSymbolLightOverride("swap_hat", 1)

    UpdateSpeed(inst, owner)
    inst:WatchWorldState("isday", function() UpdateSpeed(inst, owner) end)
    inst:WatchWorldState("isnight", function() UpdateSpeed(inst, owner) end)
    
    inst._onattacked = function(owner_inst, data) OnAttacked(inst, owner_inst, data) end
    inst:ListenForEvent("attacked", inst._onattacked, owner)

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
    inst._recent_hits = {}
end

-- ========================================================
-- NETWORK SYNC LOGIC
-- ========================================================
-- This function runs on BOTH client and server when the net_bool changes
local function OnIsCraftedDirty(inst)
    if inst._is_crafted_net:value() then
        -- It is crafted (Gifted). Remove restrictive tags.
        inst:RemoveTag("nodeconstruct")
        inst:RemoveTag("wiltolion_bound_item")
    else
        -- It is spawned/default (Bound). Add restrictive tags.
        inst:AddTag("nodeconstruct")
        inst:AddTag("wiltolion_bound_item")
    end
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
    
    inst.AnimState:SetLightOverride(1)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    
    inst:AddTag("hat")
    inst:AddTag("wiltolion_torus")

    -- Define the network variable to sync the crafted state
    inst._is_crafted_net = net_bool(inst.GUID, "wiltolion_torus._is_crafted", "iscrafteddirty")
    
    -- Listen for changes to the network variable
    inst:ListenForEvent("iscrafteddirty", OnIsCraftedDirty)
    
    -- Initialize to Bound (false) by default on creation
    inst._is_crafted_net:set_local(false)
    OnIsCraftedDirty(inst)

    -- This will now evaluate accurately on clients because tags are synced
    inst.displaynamefn = function(i)
        if i:HasTag("wiltolion_bound_item") then
            return "Bound Torus" 
        else
            return "Gifted Torus" 
        end
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    -- Server-side variables
    inst._is_crafted = false
    inst._recent_hits = {}
    inst._on_cooldown = false
    inst._forcefield_active = false
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
    
    -- Default restriction
    inst.components.equippable.restrictedtag = "wiltolion"

    -- Server-side crafted event
    inst:ListenForEvent("onbuilt", function(i, data)
        i._is_crafted = true
        i._is_crafted_net:set(true) -- Triggers OnIsCraftedDirty globally
        i.components.equippable.restrictedtag = nil 
    end)

    -- Save state
    local onsave_base = inst.OnSave
    inst.OnSave = function(i, data)
        if onsave_base ~= nil then
            onsave_base(i, data)
        end
        data.is_crafted = i._is_crafted
    end

    -- Load state
    local onload_base = inst.OnLoad
    inst.OnLoad = function(i, data)
        if onload_base ~= nil then
            onload_base(i, data)
        end
        if data ~= nil and data.is_crafted then
            i._is_crafted = true
            i._is_crafted_net:set(true) -- Sychronize with clients on load
            i.components.equippable.restrictedtag = nil
        end
    end
    
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