local assets =
{
    Asset("ANIM", "anim/flowers.zip"),
}

local prefabs =
{
    "petals",
}

-- Standard DST flower animation names
local names = {"f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10"}

local function setflowertype(inst, name)
    if inst.animname == nil or (name ~= nil and inst.animname ~= name) then
        inst.animname = name or names[math.random(#names)]
        inst.AnimState:PlayAnimation(inst.animname)
    end
end

local function onsave(inst, data)
    data.anim = inst.animname
end

local function onload(inst, data)
    setflowertype(inst, data ~= nil and data.anim or nil)
end

local function onpickedfn(inst, picker)
    local pos = inst:GetPosition()

    if picker ~= nil and picker.components.sanity ~= nil and not picker:HasTag("plantkin") then
        picker.components.sanity:DoDelta(TUNING.SANITY_TINY)
    end

    -- Pushes the event for world reactions (like Woodie's treeguard spawning or general logging)
    TheWorld:PushEvent("plantkilled", { doer = picker, pos = pos })
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("flowers")
    inst.AnimState:SetBuild("flowers")
    inst.AnimState:SetRayTestOnBB(true)

    -- Required tags for butterflyspawner and world interactions
    inst:AddTag("flower")
    inst:AddTag("cattoy")

    -- Aligns with standard deploy spacing
    inst:SetDeploySmartRadius(DEPLOYSPACING_RADIUS[DEPLOYSPACING.LESS] / 2)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable:SetUp("petals", 10)
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.remove_when_picked = true
    inst.components.pickable.quickpick = true
    inst.components.pickable.wildfirestarter = true

    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)

    if not POPULATING then
        setflowertype(inst)
    end

    -- Save/Load hooks for persistence
    inst.OnSave = onsave
    inst.OnLoad = onload

    return inst
end

return Prefab("wiltolion_flower", fn, assets, prefabs)