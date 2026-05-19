local GLOBAL = GLOBAL
local json = GLOBAL.require("json")

GLOBAL.STRINGS.CHARACTERS.GENERIC.ACTIONFAIL.TRAVEL_PYLON = {
    NOT_LEARNED = "I don't know how to use this network yet.",
    NO_ENERGY = "It needs more solar energy...",
}
GLOBAL.STRINGS.CHARACTERS.WILTOLION = GLOBAL.STRINGS.CHARACTERS.WILTOLION or { ACTIONFAIL = {} }
GLOBAL.STRINGS.CHARACTERS.WILTOLION.ACTIONFAIL.TRAVEL_PYLON = GLOBAL.STRINGS.CHARACTERS.GENERIC.ACTIONFAIL.TRAVEL_PYLON

-- ==========================================
-- CLIENT-SERVER COMMUNICATION FOR UI
-- ==========================================
AddClientModRPCHandler("Wiltolion", "OpenJournalUI", function(state_str)
    if GLOBAL.ThePlayer and GLOBAL.ThePlayer.HUD then
        local parts = {}
        for chunk in GLOBAL.string.gmatch(state_str, "([^_]+)") do
            GLOBAL.table.insert(parts, chunk)
        end
        
        local toggles = parts[1] or "1111111" 
        local tokens = GLOBAL.tonumber(parts[2]) or 0
        local points = GLOBAL.tonumber(parts[3]) or 0

        local p_up = GLOBAL.string.sub(toggles, 1, 1) == "1"
        local p_chop = GLOBAL.string.sub(toggles, 2, 2) == "1"
        local p_mine = GLOBAL.string.sub(toggles, 3, 3) == "1"
        local p_dig = GLOBAL.string.sub(toggles, 4, 4) == "1"
        local p_fight = GLOBAL.string.sub(toggles, 5, 5) == "1"
        local p_give = GLOBAL.string.sub(toggles, 6, 6) == "1"
        local p_harvest = GLOBAL.string.sub(toggles, 7, 7) == "1" 
        
        -- Correct UI approach: Triggering via HUD
        GLOBAL.ThePlayer.HUD:OpenWiltoJournalScreen(p_up, p_chop, p_mine, p_dig, p_fight, p_give, p_harvest, tokens, points)
    end
end)

local function GetPlayerWilto(player)
    if player.components.petleash ~= nil then
        local pets = player.components.petleash:GetPets()
        if pets ~= nil then
            for pet, _ in pairs(pets) do
                if pet.prefab == "wiltolion_wilto" then return pet end
            end
        end
    end
    return nil
end

AddModRPCHandler("Wiltolion", "ToggleWiltoAction", function(player, action_name, is_enabled_num)
    local is_enabled = (is_enabled_num == 1) 
    local wilto = GetPlayerWilto(player)
    
    if wilto ~= nil then
        if wilto.wilto_toggles == nil then wilto.wilto_toggles = {} end
        wilto.wilto_toggles[action_name] = is_enabled
        
        if action_name == "fight" and not is_enabled and wilto.components.combat then
            wilto.components.combat:DropTarget()
        end
    end
end)

AddModRPCHandler("Wiltolion", "WiltoDropEverything", function(player)
    local wilto = GetPlayerWilto(player)
    if wilto ~= nil then
        if wilto.wilto_toggles == nil then wilto.wilto_toggles = {} end
        wilto.wilto_toggles["pickup"] = false
        
        if wilto.components.inventory ~= nil then
            wilto.components.inventory:DropEverything(false, false)
        end
        if wilto.components.talker ~= nil then
            wilto.components.talker:Say("Take whatever you want...")
        end
    end
end)

AddModRPCHandler("Wiltolion", "CallWilto", function(player)
    if not player or player:HasTag("playerghost") then return end
    local wilto = GetPlayerWilto(player)

    if not wilto then
        if player.components.talker then player.components.talker:Say("He is not in this world...") end
        return
    end

    if player.components.inventory:Has("wiltolion_sundrop", 3) then
        player.components.inventory:ConsumeByName("wiltolion_sundrop", 3)
        
        local pt = player:GetPosition()
        local offset = GLOBAL.FindWalkableOffset(pt, math.random() * 2 * GLOBAL.PI, 2.5, 8, true, true)
        if offset ~= nil then
            pt.x = pt.x + offset.x
            pt.z = pt.z + offset.z
        end

        local fx_old = GLOBAL.SpawnPrefab("halloween_firepuff_1")
        fx_old.Transform:SetPosition(wilto.Transform:GetWorldPosition())

        wilto.Physics:Teleport(pt.x, 0, pt.z)

        local fx_new = GLOBAL.SpawnPrefab("halloween_firepuff_3")
        fx_new.Transform:SetPosition(pt.x, 0.5, pt.z)
        wilto.SoundEmitter:PlaySound("dontstarve/common/staff_blink")
        
        if player.components.talker then player.components.talker:Say("To my side, Wilto!") end
    else
        if player.components.talker then player.components.talker:Say("I need some energy to call him!") end
    end
end)

-- ==========================================
-- CELESTIAL PYLON NETWORK (FAST TRAVEL)
-- ==========================================

local function IsPylonNetworkActive()
    for _, player in ipairs(GLOBAL.AllPlayers) do
        if player:HasTag("wiltolion_constel_3") then
            return true
        end
    end
    return false
end

local TRAVEL_PYLON = AddAction("TRAVEL_PYLON", "Travel", function(act)
    local pylon = act.target
    local traveler = act.doer
    
    if not IsPylonNetworkActive() then
        return false, "NOT_LEARNED" 
    end

    if pylon and traveler and pylon.components.container then
        if pylon.components.container:Has("wiltolion_sundrop", 5) then
            local pylon_data = {}
            if GLOBAL.TheWorld.wiltolion_pylons then
                for p, _ in pairs(GLOBAL.TheWorld.wiltolion_pylons) do
                    if p:IsValid() then 
                        local x, y, z = p.Transform:GetWorldPosition()
                        GLOBAL.table.insert(pylon_data, {x = x, z = z, id = p.GUID})
                    end
                end
            end
            local json_pylon_data = json.encode(pylon_data)
            if traveler.userid then
                SendModRPCToClient(GLOBAL.CLIENT_MOD_RPC["Wiltolion"]["OpenPylonMap"], traveler.userid, pylon, json_pylon_data)
            end
            return true
        else
            return false, "NO_ENERGY"
        end
    end
    return false
end)
TRAVEL_PYLON.distance = 20 
TRAVEL_PYLON.priority = 10

-- ==========================================
-- PYLON INTERFACE COMPONENT
-- ==========================================
AddComponentAction("SCENE", "container", function(inst, doer, actions, right)
    if right and inst.prefab == "wiltolion_pylon" then
        if IsPylonNetworkActive() then
            table.insert(actions, GLOBAL.ACTIONS.TRAVEL_PYLON)
        end
    end
end)

AddClientModRPCHandler("Wiltolion", "OpenPylonMap", function(pylon_inst, json_data)
    if GLOBAL.ThePlayer and GLOBAL.ThePlayer.HUD then
        local pylon_data = json.decode(json_data)
        local PylonMapScreen = require("screens/wiltolion_pylonmap")
        GLOBAL.TheFrontEnd:PushScreen(PylonMapScreen(GLOBAL.ThePlayer, pylon_inst, pylon_data))
    end
end)

AddModRPCHandler("Wiltolion", "TravelToPylon", function(player, origin_pylon, dest_x, dest_z)
    if origin_pylon and origin_pylon:IsValid() and origin_pylon.components.container then
        if origin_pylon.components.container:Has("wiltolion_sundrop", 5) then
            origin_pylon.components.container:ConsumeByName("wiltolion_sundrop", 5)
            if player.sg then
                player.sg:GoToState("wiltolion_pylon_travel", {x = dest_x, z = dest_z})
            end
        else
            if player.components.talker then
                player.components.talker:Say("The energy is depleted!")
            end
        end
    end
end)

-- ===========================================================================
-- SUNDROP RECHARGE SYSTEM (SOLAR EMPOWERMENT)
-- ===========================================================================

-- 1. CONFIGURATION TABLE
local SUNDROP_TARGETS = {
    yellowamulet    = { type = "fueled", amount = 0.10 }, -- Magiluminescence (50%)
    nightstick      = { type = "fueled", amount = 0.05 }, -- Morning Star (50%)
    minerhat        = { type = "fueled", amount = 0.10 }, -- Miner Hat (50%)
    lantern         = { type = "fueled", amount = 0.15 }, -- Lantern (50%)
    mushroom_light  = { type = "spore_container" },       -- Mushroom Light
    mushroom_light2 = { type = "spore_container" },       -- Glowcap
}

-- 2. ACTION DEFINITION
local RECHARGE_SOLAR = AddAction("RECHARGE_SOLAR", "Sundrop fuel", function(act)
    local target = act.target
    local sundrop = act.invobject
    local doer = act.doer
    
    if doer == nil or not doer:HasTag("wiltolion_solar_5") then 
        return false 
    end
    
    if target == nil or sundrop == nil then 
        return false 
    end
    
    local data = SUNDROP_TARGETS[target.prefab]
    if data == nil then 
        return false 
    end
    
    local success = false

    -- [CASE A]: FUELED ITEMS
    if data.type == "fueled" and target.components.fueled ~= nil then
        if target.components.fueled:GetPercent() < 1 then
            local fuel_to_add = target.components.fueled.maxfuel * data.amount
            target.components.fueled:DoDelta(fuel_to_add)
            success = true
        end
        
    -- [CASE B]: SPORE CONTAINERS (MUSHROOM LIGHTS)
    elseif data.type == "spore_container" and target.components.container ~= nil then
        if target.components.container:IsEmpty() then
            local bulb = GLOBAL.SpawnPrefab("lightbulb")
            if bulb ~= nil then
                target.components.container:GiveItem(bulb)
                success = true
            end
        else
            for k, item in pairs(target.components.container.slots) do
                if item and item.components.perishable ~= nil and item.components.perishable:GetPercent() < 1 then
                    item.components.perishable:SetPercent(1)
                    success = true
                end
            end
        end
    end
    
    -- 3. COMPLETE ACTION
    if success then
        if doer.SoundEmitter ~= nil then
            doer.SoundEmitter:PlaySound("dontstarve/common/minerhatAddFuel")
        end
        
        if sundrop.components.stackable ~= nil then
            sundrop.components.stackable:Get():Remove()
        else
            sundrop:Remove()
        end
        return true
    end
    
    return false
end)
RECHARGE_SOLAR.priority = 10 

-- 4. ACTION HANDLER (Client/Server prediction fix)
AddComponentAction("USEITEM", "inventoryitem", function(inst, doer, target, actions, right)
    if right and inst.prefab == "wiltolion_sundrop" then
        
        local data = SUNDROP_TARGETS[target.prefab]
        
        if doer:HasTag("wiltolion_solar_5") and data ~= nil then
            local valid_target = false
            
            if GLOBAL.TheWorld.ismastersim then
                -- SERVER SIDE: Strict validation using absolute component values.
                if data.type == "fueled" and target.components.fueled ~= nil then
                    valid_target = target.components.fueled:GetPercent() < 1
                elseif data.type == "spore_container" and target.components.container ~= nil then
                    valid_target = true
                end
            else
                -- CLIENT SIDE: Permissive prediction.
                -- Clients lack exact replica fuel values for inventory items. 
                -- We allow the interaction prompt to appear and let the server handle validation.
                valid_target = true
            end
            
            if valid_target then
                table.insert(actions, GLOBAL.ACTIONS.RECHARGE_SOLAR)
            end
        end
    end
end)

-- ==========================================
-- STATEGRAPHS (ANIMATIONS)
-- ==========================================

-- JOURNAL READ (SERVER)
AddStategraphState("wilson", GLOBAL.State({
    name = "wilto_journal_read",
    tags = { "doing", "busy" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:AddOverrideBuild("wilto_journal_fx")
        inst.AnimState:PlayAnimation("action_uniqueitem_pre")
        inst.AnimState:PushAnimation("peruse", false)
        inst.sg.statemem.action = inst.bufferedaction
        inst:PerformBufferedAction()
    end,
    timeline = {
        GLOBAL.TimeEvent(25 * GLOBAL.FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/use_book") end),
        GLOBAL.TimeEvent(68 * GLOBAL.FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/characters/actions/page_turn") end),
    },
    events = {
        GLOBAL.EventHandler("animqueueover", function(inst) 
            if inst.AnimState:AnimDone() then inst.sg:GoToState("idle") end
        end),
    },
    onexit = function(inst) inst.AnimState:ClearOverrideBuild("wilto_journal_fx") end,
}))

-- JOURNAL READ (CLIENT)
AddStategraphState("wilson_client", GLOBAL.State({
    name = "wilto_journal_read",
    tags = { "doing", "busy" },
    server_states = { "wilto_journal_read" }, 

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:AddOverrideBuild("wilto_journal_fx")
        inst.AnimState:PlayAnimation("action_uniqueitem_pre")
        inst.AnimState:PushAnimation("peruse", false)
        inst:PerformPreviewBufferedAction()
        inst.sg:SetTimeout(4) 
        inst.sg.statemem.action = inst.bufferedaction
    end,
    onupdate = function(inst)
        if inst:HasTag("doing") then
            if inst.entity:FlattenMovementPrediction() then inst.sg:GoToState("idle", "noanim") end
        elseif inst.bufferedaction == nil then
            inst.sg:GoToState("idle")
        end
    end,
    ontimeout = function(inst)
        inst:ClearBufferedAction()
        inst.sg:GoToState("idle")
    end,
    onexit = function(inst)
        if inst.bufferedaction == inst.sg.statemem.action then inst:ClearBufferedAction() end
    end,
}))

-- PYLON TRAVEL (SERVER)
AddStategraphState("wilson", GLOBAL.State({
    name = "wiltolion_pylon_travel",
    tags = { "busy", "pausepredict", "nomorph", "nodangle", "noattack" },

    onenter = function(inst, dest_coords)
        inst.components.locomotor:Stop()
        inst.sg.statemem.dest = dest_coords
        inst.AnimState:SetAddColour(1, 1, 1, 1)
        inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        
        inst.SoundEmitter:PlaySound("dontstarve/common/staff_star_create")
        inst.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")

        inst.sg.statemem.time_elapsed = 0
        local DURATION = 5 * GLOBAL.FRAMES 
        
        inst.sg.statemem.task = inst:DoPeriodicTask(0, function()
            inst.sg.statemem.time_elapsed = inst.sg.statemem.time_elapsed + GLOBAL.FRAMES
            local percent = math.min(1, inst.sg.statemem.time_elapsed / DURATION)
            local ease = percent * percent * percent * percent
            local stretch = 1 + (12 * ease) 
            local width = math.max(0.01, 1 - (0.99 * ease))
            inst.Transform:SetScale(width, stretch, width)
        end)
    end,

    timeline = {
        GLOBAL.TimeEvent(5 * GLOBAL.FRAMES, function(inst)
            if inst.sg.statemem.task then inst.sg.statemem.task:Cancel() inst.sg.statemem.task = nil end
            inst:Hide()
            
            local dest = inst.sg.statemem.dest
            if dest then
                local pt = GLOBAL.Vector3(dest.x, 0, dest.z)
                local offset = GLOBAL.FindWalkableOffset(pt, math.random() * 2 * GLOBAL.PI, 2.5, 8, true, true)
                local final_x = dest.x + (offset ~= nil and offset.x or 0)
                local final_z = dest.z + (offset ~= nil and offset.z or 0)

                inst.Physics:Teleport(final_x, 0, final_z)
                inst:SnapCamera()
                inst.sg.statemem.arrival_pos = {x = final_x, z = final_z}
            end
        end),
        GLOBAL.TimeEvent(12 * GLOBAL.FRAMES, function(inst)
            inst:Show()
            inst.Transform:SetScale(1, 1, 1)
            inst.AnimState:ClearBloomEffectHandle()
            
            if inst.sg.statemem.arrival_pos then
                local pos = inst.sg.statemem.arrival_pos
                GLOBAL.SpawnPrefab("lightning").Transform:SetPosition(pos.x, 0, pos.z)
                inst.SoundEmitter:PlaySound("dontstarve/common/staff_blink")
            end

            inst.sg.statemem.white_val = 1.0
            inst.sg.statemem.fade_task = inst:DoPeriodicTask(0, function()
                inst.sg.statemem.white_val = math.max(0, inst.sg.statemem.white_val - 0.4) 
                inst.AnimState:SetAddColour(inst.sg.statemem.white_val, inst.sg.statemem.white_val, inst.sg.statemem.white_val, 1)
                if inst.sg.statemem.white_val <= 0 then
                    if inst.sg.statemem.fade_task then inst.sg.statemem.fade_task:Cancel() end
                end
            end)
        end),
        GLOBAL.TimeEvent(18 * GLOBAL.FRAMES, function(inst)
            inst.sg:GoToState("idle")
        end),
    },
    onexit = function(inst)
        if inst.sg.statemem.task then inst.sg.statemem.task:Cancel() end
        if inst.sg.statemem.fade_task then inst.sg.statemem.fade_task:Cancel() end
        inst.AnimState:SetAddColour(0, 0, 0, 0)
        inst.AnimState:ClearBloomEffectHandle()
        inst.Transform:SetScale(1, 1, 1)
        inst:Show()
    end,
}))

-- PYLON TRAVEL (CLIENT)
AddStategraphState("wilson_client", GLOBAL.State({
    name = "wiltolion_pylon_travel",
    tags = { "busy", "pausepredict", "nomorph", "nodangle", "noattack" },
    server_states = { "wiltolion_pylon_travel" }, 

    onenter = function(inst)
        inst.components.locomotor:Stop()
        
        inst.SoundEmitter:PlaySound("dontstarve/common/staff_star_create")
        inst.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")

        inst.AnimState:SetAddColour(1, 1, 1, 1)
        inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

        inst.sg.statemem.time_elapsed = 0
        local DURATION = 5 * GLOBAL.FRAMES 
        
        inst.sg.statemem.task = inst:DoPeriodicTask(0, function()
            inst.sg.statemem.time_elapsed = inst.sg.statemem.time_elapsed + GLOBAL.FRAMES
            local percent = math.min(1, inst.sg.statemem.time_elapsed / DURATION)
            local ease = percent * percent * percent * percent
            local stretch = 1 + (12 * ease) 
            local width = math.max(0.01, 1 - (0.99 * ease))
            inst.Transform:SetScale(width, stretch, width)
        end)
        
        inst.sg:SetTimeout(2)
    end,

    timeline = {
        GLOBAL.TimeEvent(5 * GLOBAL.FRAMES, function(inst)
            if inst.sg.statemem.task then inst.sg.statemem.task:Cancel() inst.sg.statemem.task = nil end
            inst:Hide()
        end),
        GLOBAL.TimeEvent(12 * GLOBAL.FRAMES, function(inst)
            inst:Show()
            inst.Transform:SetScale(1, 1, 1)
            inst.AnimState:ClearBloomEffectHandle()
            
            inst.sg.statemem.white_val = 1.0
            inst.sg.statemem.fade_task = inst:DoPeriodicTask(0, function()
                inst.sg.statemem.white_val = math.max(0, inst.sg.statemem.white_val - 0.4) 
                inst.AnimState:SetAddColour(inst.sg.statemem.white_val, inst.sg.statemem.white_val, inst.sg.statemem.white_val, 1)
                if inst.sg.statemem.white_val <= 0 then
                    if inst.sg.statemem.fade_task then inst.sg.statemem.fade_task:Cancel() end
                end
            end)
        end),
    },
    
    ontimeout = function(inst)
        inst.sg:GoToState("idle")
    end,

    onexit = function(inst)
        if inst.sg.statemem.task then inst.sg.statemem.task:Cancel() end
        if inst.sg.statemem.fade_task then inst.sg.statemem.fade_task:Cancel() end
        inst.AnimState:SetAddColour(0, 0, 0, 0)
        inst.AnimState:ClearBloomEffectHandle()
        inst.Transform:SetScale(1, 1, 1)
        inst:Show()
    end,
}))

-- POST INITS FOR READ ACTIONS
AddStategraphPostInit("wilson", function(sg)
    local old_read = sg.actionhandlers[GLOBAL.ACTIONS.READ]
    if old_read then
        local old_deststate = old_read.deststate
        old_read.deststate = function(inst, action)
            if action.invobject ~= nil and action.invobject:HasTag("wilto_journal") then
                return "wilto_journal_read" 
            end
            if type(old_deststate) == "function" then return old_deststate(inst, action)
            elseif type(old_deststate) == "string" then return old_deststate end
        end
    end
end)

AddStategraphPostInit("wilson_client", function(sg)
    local old_read = sg.actionhandlers[GLOBAL.ACTIONS.READ]
    if old_read then
        local old_deststate = old_read.deststate
        old_read.deststate = function(inst, action)
            if action.invobject ~= nil and action.invobject:HasTag("wilto_journal") then return "wilto_journal_read" end
            if type(old_deststate) == "function" then return old_deststate(inst, action)
            elseif type(old_deststate) == "string" then return old_deststate end
        end
    end
end)

-- ACTION HANDLERS
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.TRAVEL_PYLON, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.TRAVEL_PYLON, "doshortaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.RECHARGE_SOLAR, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.RECHARGE_SOLAR, "doshortaction"))

-- ==========================================
-- LUNAR ALIGNMENT: CALL TO ALTER
-- ==========================================

GLOBAL.STRINGS.CHARACTERS.GENERIC.ACTIONFAIL.ALTER_CALL = {
    NOT_LEARNED = "Call...Who?...",
    NO_HUNGER = "I am too hungry...!",
    NO_POWER = "I'm feeling cold now...", 
    NO_TOKENS = "Alter's taking a nap!...",
}
GLOBAL.STRINGS.CHARACTERS.WILTOLION.ACTIONFAIL.ALTER_CALL = GLOBAL.STRINGS.CHARACTERS.GENERIC.ACTIONFAIL.ALTER_CALL

local ALTER_CALL = AddAction("ALTER_CALL", "Call for help", function(act)
    local doer = act.doer
    local target = act.target

    if not GLOBAL.TheWorld.ismastersim then
        return true
    end

    if not doer:HasTag("wiltolion_lunar_1") then return false, "NOT_LEARNED" end
    if not doer.alter_tokens or doer.alter_tokens <= 0 then return false, "NO_TOKENS" end

    if doer.components.hunger.current < 35 then return false, "NO_HUNGER" end
    if (doer._heat_power or 0) < 25 then return false, "NO_POWER" end

    doer.components.hunger:DoDelta(-35)
    doer.components.sanity:DoDelta(15)
    doer:ConsumeHeatPower(25)
    doer.alter_tokens = doer.alter_tokens - 1
    doer._net_alter_tokens:set(doer.alter_tokens)

    if doer.components.timer and not doer.components.timer:TimerExists("alter_recharge") then
        doer.components.timer:StartTimer("alter_recharge", 180)
    end

    local pulse = GLOBAL.SpawnPrefab("moonpulse_fx")
    if pulse then
        pulse.Transform:SetPosition(doer.Transform:GetWorldPosition())
    end

    local fx_impact = GLOBAL.SpawnPrefab("moon_altar_cosmic_pulse")
    if fx_impact then
        fx_impact.Transform:SetPosition(doer.Transform:GetWorldPosition())
    end

    doer.SoundEmitter:PlaySound("dontstarve/common/staff_star_create")

    local x, y, z = doer.Transform:GetWorldPosition()
    local num_gestalts = 10
    local radius = 3

    for i = 1, num_gestalts do
        doer:DoTaskInTime((i - 1) * 0.15, function()
            local p = GLOBAL.SpawnPrefab("wiltolion_gestalt_projectile")
            if p then
                local angle = (i / num_gestalts) * 2 * GLOBAL.PI
                local px = x + math.cos(angle) * radius
                local pz = z + math.sin(angle) * radius
                p.Transform:SetPosition(px, y, pz)
                p.SoundEmitter:PlaySound("dontstarve/common/together/moonbase/beam_start", nil, 1)

                p._focustarget = target
                if target:IsValid() then
                    p:SetTargetPosition(target:GetPosition())
                end
            end
        end)
    end
    return true
end)
ALTER_CALL.distance = 15 
ALTER_CALL.priority = 10

AddComponentAction("SCENE", "combat", function(inst, doer, actions, right)
    if right and doer:HasTag("wiltolion_lunar_1") then
        local weapon = doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
        local is_staff = weapon ~= nil and weapon:HasTag("castspell")
        
        if not is_staff and doer.replica.combat:CanTarget(inst) then
            table.insert(actions, GLOBAL.ACTIONS.ALTER_CALL)
        end
    end
end)

local alter_call_server = GLOBAL.State({
    name = "wiltolion_alter_call",
    tags = { "doing", "busy", "nodangle" },
    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("channel_pre")
        inst.AnimState:PushAnimation("channel_loop", true)

        local fx = GLOBAL.SpawnPrefab("moon_altar_cosmic_pulse")
        if fx then fx.Transform:SetPosition(inst.Transform:GetWorldPosition()) end

        inst.SoundEmitter:PlaySound("dontstarve/common/staff_star_create")
    end,
    timeline = {
        GLOBAL.TimeEvent(25 * GLOBAL.FRAMES, function(inst)
            inst:PerformBufferedAction()
        end),
        GLOBAL.TimeEvent(35 * GLOBAL.FRAMES, function(inst)
            inst.AnimState:PlayAnimation("channel_pst")
        end),
    },
    events = {
        GLOBAL.EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then inst.sg:GoToState("idle") end
        end),
    },
})

local alter_call_client = GLOBAL.State({
    name = "wiltolion_alter_call",
    tags = { "doing", "busy", "nodangle" },
    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("channel_pre")
        inst.AnimState:PushAnimation("channel_loop", true)
        
        local fx = GLOBAL.SpawnPrefab("moon_altar_cosmic_pulse")
        if fx then fx.Transform:SetPosition(inst.Transform:GetWorldPosition()) end
        inst.SoundEmitter:PlaySound("dontstarve/common/staff_star_create")
        
        inst:PerformPreviewBufferedAction()
    end,
    timeline = {
        GLOBAL.TimeEvent(25 * GLOBAL.FRAMES, function(inst)
            inst:ClearBufferedAction()
        end),
        GLOBAL.TimeEvent(35 * GLOBAL.FRAMES, function(inst)
            inst.AnimState:PlayAnimation("channel_pst")
        end),
    },
    events = {
        GLOBAL.EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then inst.sg:GoToState("idle") end
        end),
    },
})

AddStategraphState("wilson", alter_call_server)
AddStategraphState("wilson_client", alter_call_client)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.ALTER_CALL, "wiltolion_alter_call"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.ALTER_CALL, "wiltolion_alter_call"))

-- ===========================================================================
-- OVERHEAT ANIMATION SUPPRESSION FOR WILTOLION
-- ===========================================================================

-- Intercepts the native idle_hot state directly inside the StateGraph
local function SuppressWiltolionIdleHot(sg)
    -- Store the original game function to not break other characters
    local old_idle_hot_onenter = sg.states["idle_hot"].onenter
    
    sg.states["idle_hot"].onenter = function(inst, pushanim)
        if inst:HasTag("wiltolion") then
            -- Bypass the panting animation completely.
            -- Playing the standard idle loop satisfies the StateGraph event queue
            -- while visually keeping Wiltolion completely calm and majestic.
            inst.AnimState:PlayAnimation("idle_loop", true)
        else
            -- If it's a normal character (like Wilson), run the standard hot animation
            if old_idle_hot_onenter then
                old_idle_hot_onenter(inst, pushanim)
            end
        end
    end
end

-- Apply the injection to both the server and the client predictor
-- This ensures the fix works perfectly across cave shards and high latency
AddStategraphPostInit("wilson", SuppressWiltolionIdleHot)
AddStategraphPostInit("wilson_client", SuppressWiltolionIdleHot)