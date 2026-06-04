local assets = {
    Asset("ANIM", "anim/wilto_journal_fx.zip"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst:AddTag("FX")

    -- Names based on your SCML changes
    inst.AnimState:SetBank("wilto_journal_fx")
    inst.AnimState:SetBuild("wilto_journal_fx")
    inst.AnimState:PlayAnimation("peruse")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    -- When animation ends, it deletes itself
    inst:ListenForEvent("animover", inst.Remove)

    return inst
end

return Prefab("wilto_journal_fx", fn, assets)