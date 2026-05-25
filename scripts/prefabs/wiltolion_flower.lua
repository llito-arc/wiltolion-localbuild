local assets =
{
    Asset("ANIM", "anim/wiltolion_flower.zip"),
}

local prefabs =
{
    "halloween_firepuff_1",
}

local names = {"f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10", "f11"}

local function setflowertype(inst, name)
    if inst.animname == nil or (name ~= nil and inst.animname ~= name) then
        inst.animname = name or names[math.random(#names)]
        inst.AnimState:PlayAnimation(inst.animname)
    end
end

-- Timer callback for the 1 real-life hour lifespan
local function ontimerdone(inst, data)
    if data ~= nil and data.name == "lifetime" then
        local fx = SpawnPrefab("halloween_firepuff_1")
        if fx ~= nil then
            fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end
        inst:Remove()
    end
end

local function onpickedfn(inst, picker)
    if picker ~= nil and picker.components.health ~= nil and not picker.components.health:IsDead() then
        if not picker:HasTag("wiltolion") then
            -- Punish non-owners with damage
            picker.components.health:DoDelta(-3, false, inst.prefab)
        else
            -- Small micro-heal reward for Wiltolion picking their own magical flowers
            picker.components.health:DoDelta(1, false, inst.prefab)
        end
    end

    -- Spawn the requested FX
    local fx = SpawnPrefab("halloween_firepuff_1")
    if fx ~= nil then
        fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    end

    -- Pickable component with 'remove_when_picked = true' handles the inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddLight() -- 1. Initialize the Light Entity
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("wiltolion_flower")
    inst.AnimState:SetBuild("wiltolion_flower")
    inst.AnimState:SetRayTestOnBB(true)
    
    -- High LightOverride to glow in the dark without emitting physics light
    inst.AnimState:SetLightOverride(0.85)

    -- ========================================================
    -- LIGHT CONFIGURATION (Tiny Aura)
    -- ========================================================
    -- Falloff: How smooth the edge of the light is (0 is sharp, 1 is smooth)
    inst.Light:SetFalloff(0.7)
    -- Intensity: How bright the core is
    inst.Light:SetIntensity(0.5)
    -- Radius: Extremely small so it just illuminates the tile it sits on
    inst.Light:SetRadius(0.8)
    -- Colour: Warm golden/orange hue (RGB values out of 255)
    inst.Light:SetColour(250/255, 180/255, 50/255)
    inst.Light:Enable(true)

    inst:AddTag("flower")
    inst:AddTag("cattoy")

    inst:SetDeploySmartRadius(DEPLOYSPACING_RADIUS[DEPLOYSPACING.LESS] / 2)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    -- Sanity Aura Setup (3 sanity per minute = 3 / 60)
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = 3 / 60

    -- ========================================================
    -- MICRO-HEATER (Extra thematic feature)
    -- ========================================================
    -- Provides a tiny amount of warmth. A field of these could save a freezing player.
    inst:AddComponent("heater")
    inst.components.heater.heat = 15

    -- Timer Setup (1800 seconds = 30 minutes)
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", ontimerdone)

    -- Pickable Setup
    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    -- nil item prevents it from giving petals; 0 reset time means it never regrows
    inst.components.pickable:SetUp(nil, 0) 
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.remove_when_picked = true
    inst.components.pickable.quickpick = true

    if not POPULATING then
        setflowertype(inst)
        -- Start the lifetime timer immediately when created (Fixed to 1800 for 30 minutes)
        inst.components.timer:StartTimer("lifetime", 1800)
    end

    -- Built-in persistence for animations and timers
    inst.OnSave = function(inst, data)
        data.anim = inst.animname
    end

    inst.OnLoad = function(inst, data)
        setflowertype(inst, data ~= nil and data.anim or nil)
    end

    return inst
end

return Prefab("wiltolion_flower", fn, assets, prefabs)