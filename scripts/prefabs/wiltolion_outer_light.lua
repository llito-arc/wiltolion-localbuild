-- scripts/prefabs/wiltolion_outer_light.lua

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    
    -- KLEI ENGINE FIX: Adding an empty AnimState prevents the C++ renderer 
    -- from culling the light component on the client's screen.
    inst.entity:AddAnimState() 
    
    inst.entity:AddNetwork()
    inst.entity:AddLight()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    inst:AddTag("NOBLOCK")

    inst.Light:Enable(false)
    inst.Light:SetFalloff(0.95)

    -- Force the entity to always stay awake and relevant in the network graph
    inst.entity:SetCanSleep(false)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false 

    return inst
end

return Prefab("wiltolion_outer_light", fn)