local assets =
{
    Asset("ANIM", "anim/book_maxwell.zip"),  -- The original skeleton (works perfectly)
    Asset("ANIM", "anim/wilto_journal.zip"), -- Loads the ground animation
}

local IDLE_SOUND_VOLUME = 0.5

--------------------------------------------------------------------------
-- FLOATING SOUNDS AND ANIMATIONS SYSTEM (Kept intact)
--------------------------------------------------------------------------
local function tryplaysound(inst, id, sound)
    inst._soundtasks[id] = nil
    if inst.AnimState:IsCurrentAnimation("proximity_pst") then inst.SoundEmitter:PlaySound(sound) end
end

local function trykillsound(inst, id, sound)
    inst._soundtasks[id] = nil
    if inst.AnimState:IsCurrentAnimation("proximity_pst") then inst.SoundEmitter:KillSound(sound) end
end

local function queueplaysound(inst, delay, id, sound)
    if inst._soundtasks[id] ~= nil then inst._soundtasks[id]:Cancel() end
    inst._soundtasks[id] = inst:DoTaskInTime(delay, tryplaysound, id, sound)
end

local function queuekillsound(inst, delay, id, sound)
    if inst._soundtasks[id] ~= nil then inst._soundtasks[id]:Cancel() end
    inst._soundtasks[id] = inst:DoTaskInTime(delay, trykillsound, id, sound)
end

-- Modify close and drop sounds
-- Modify close and drop sounds
local function tryqueueclosingsounds(inst, onanimover)
    inst._soundtasks.animover = nil
    if inst.AnimState:IsCurrentAnimation("proximity_pst") then
        inst:RemoveEventCallback("animover", onanimover)
        
        -- Soft page turn sound
        queueplaysound(inst, 4 * FRAMES, "close", "dontstarve/characters/actions/page_turn")
        queuekillsound(inst, 5 * FRAMES, "killidle", "idlesound")
        -- Crystal/magic sound when hitting ground
        queueplaysound(inst, 14 * FRAMES, "drop", "dontstarve/common/gem_drop")
    end
end

local function onanimover(inst)
    if inst._soundtasks.animover ~= nil then inst._soundtasks.animover:Cancel() end
    inst._soundtasks.animover = inst:DoTaskInTime(FRAMES, tryqueueclosingsounds, onanimover)
end

local function stopclosingsounds(inst)
    inst:RemoveEventCallback("animover", onanimover)
    for k, v in pairs(inst._soundtasks) do
        v:Cancel()
        inst._soundtasks[k] = nil
    end
end

local function startclosingsounds(inst)
    stopclosingsounds(inst)
    inst:ListenForEvent("animover", onanimover)
    onanimover(inst)
end

-- Modify "Idle" buzz (When floating)
-- Modify "Idle" buzz (When floating)
local function onturnon(inst)
    if inst.isfloating then return end
    inst.isfloating = true
    if inst._activetask ~= nil then return end
    
    stopclosingsounds(inst)
    
    if inst.AnimState:IsCurrentAnimation("proximity_loop") then
        local t = inst.AnimState:GetCurrentAnimationTime()
        inst.AnimState:PlayAnimation("proximity_loop", true)
        inst.AnimState:SetTime(t)
    else
        inst.AnimState:PlayAnimation("proximity_pre")
        inst.AnimState:PushAnimation("proximity_loop", true)
    end
    
    if not inst.SoundEmitter:PlayingSound("idlesound") then
        -- Calm lunar buzz of the Celestial Orb
        inst.SoundEmitter:PlaySound("dontstarve/common/together/celestial_orb/active_LP", "idlesound")
        inst.SoundEmitter:SetVolume("idlesound", IDLE_SOUND_VOLUME)
    end
end

local function onturnoff(inst, instant)
    if instant then
        inst.AnimState:PlayAnimation("idle")
        inst.SoundEmitter:KillSound("idlesound")
        stopclosingsounds(inst)
        inst.isfloating = nil
        if inst._activetask ~= nil then
            inst._activetask:Cancel()
            inst._activetask = nil
        end
        return
    elseif not inst.isfloating then
        return
    end
    
    inst.isfloating = nil
    if inst._activetask ~= nil then return end
    
    inst.AnimState:PushAnimation("proximity_pst")
    inst.AnimState:PushAnimation("idle", false)
    startclosingsounds(inst)
end

local function IsPlayerInRange(inst, range)
    local x, y, z = inst.Transform:GetWorldPosition()
    local closestdsq = math.huge
    range = range * range
    for i, v in ipairs(AllPlayers) do
        if v:HasTag("wiltolion") and not (v.components.health:IsDead() or v:HasTag("playerghost")) then
            local dsq = v:GetDistanceSqToPoint(x, y, z)
            if dsq < range then
                return true
            elseif dsq < closestdsq then
                closestdsq = dsq
            end
        end
    end
    return false, closestdsq
end

local function UpdateFloatNear(inst, farfn)
    local isnear, closestdsq = IsPlayerInRange(inst, inst.isfloating and 3 or 2)
    if isnear then
        onturnon(inst)
    else
        onturnoff(inst)
        if closestdsq >= 100 then
            inst._floattask:Cancel()
            inst._floattask = inst:DoPeriodicTask(1, farfn)
        end
    end
end

local function UpdateFloatFar(inst)
    if IsPlayerInRange(inst, 8) then
        inst._floattask:Cancel()
        inst._floattask = inst:DoPeriodicTask(.1, UpdateFloatNear, .5, UpdateFloatFar)
    end
end

local function OnEntitySleep(inst)
    if inst._floattask ~= nil then
        inst._floattask:Cancel()
        inst._floattask = nil
    end
    onturnoff(inst, true)
end

local function OnEntityWake(inst)
    if inst._floattask == nil and not (inst.components.inventoryitem:IsHeld() or inst:IsAsleep()) then
        inst._floattask = inst:DoPeriodicTask(.1, UpdateFloatNear, 0, UpdateFloatFar)
    end
end

local function topocket(inst) OnEntitySleep(inst) end
local function toground(inst) OnEntityWake(inst) end

--------------------------------------------------------------------------
-- BOOK LOGIC (WHEN READING IT)
--------------------------------------------------------------------------
local function OnReadJournal(inst, reader)
    if reader.components.health:IsDead() or reader:HasTag("playerghost") then
        return false
    end

    -- 1. Add p_harvest here
    local p_up, p_chop, p_mine, p_dig, p_fight, p_give, p_harvest = true, true, true, true, true, true, true
    local tokens, points = 0, 0 

    if reader.components.petleash ~= nil then
        local pets = reader.components.petleash:GetPets()
        if pets ~= nil then
            for pet, _ in pairs(pets) do
                if pet.prefab == "wiltolion_wilto" then
                    if pet.wilto_toggles ~= nil then
                        p_up = pet.wilto_toggles.pickup ~= false
                        p_chop = pet.wilto_toggles.chop ~= false
                        p_mine = pet.wilto_toggles.mine ~= false
                        p_dig = pet.wilto_toggles.dig ~= false
                        p_fight = pet.wilto_toggles.fight ~= false
                        p_give = pet.wilto_toggles.give ~= false
                        p_harvest = pet.wilto_toggles.harvest ~= false -- 2. Read the memory
                    end
                    tokens = pet.wilto_heal_tokens or 0
                    points = math.floor(pet.wilto_heal_points or 0)
                    break
                end
            end
        end
    end

    -- 3. Add the seventh number to the string
    local state_str = (p_up and "1" or "0") .. (p_chop and "1" or "0") .. (p_mine and "1" or "0") .. (p_dig and "1" or "0") .. (p_fight and "1" or "0") .. (p_give and "1" or "0") .. (p_harvest and "1" or "0")
    state_str = state_str .. "_" .. tostring(tokens) .. "_" .. tostring(points)

    if reader.userid then
        SendModRPCToClient(GetClientModRPC("Wiltolion", "OpenJournalUI"), reader.userid, state_str)
    end

    return true
end

--------------------------------------------------------------------------
-- PREFAB CONSTRUCTOR
--------------------------------------------------------------------------
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("book_maxwell")
    inst.AnimState:SetBuild("wilto_journal")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("book")
    inst:AddTag("luckyitem")
    inst:AddTag("wilto_journal")
    inst:AddTag("nonpotatable")
    MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "wilto_journal"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/wilto_journal.xml"

    -- Add the base component for all books
    inst:AddComponent("book")
    inst.components.book.onread = OnReadJournal

    MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)

    inst:AddComponent("luckitem")
    inst.components.luckitem:SetLuck(function(inst, owner)
        -- You can change this number.
        -- TUNING.HORSESHOE_LUCK base is usually a small value.
        -- Set it to 1, 2 or 5 depending on how broken you want the RNG.
        return 2
    end)
    -- ==========================================
    -- Add the base component for all books

    inst:AddComponent("hauntable")
    inst.components.hauntable.cooldown = TUNING.HAUNT_COOLDOWN_SMALL

    inst._activetask = nil
    inst._soundtasks = {}
    inst:ListenForEvent("onputininventory", topocket)
    inst:ListenForEvent("ondropped", toground)
    inst.OnEntitySleep = OnEntitySleep
    inst.OnEntityWake = OnEntityWake
    

    return inst
end

return Prefab("wilto_journal", fn, assets)