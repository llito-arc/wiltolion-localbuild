require("stategraphs/commonstates")

local actionhandlers =
{
    -- Removed ACTIONS.EAT and ACTIONS.INVESTIGATE as the companion doesn't need them
    ActionHandler(ACTIONS.GOHOME, "idle"), 
}

local events =
{
    CommonHandlers.OnHop(),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    CommonHandlers.OnElectrocute(),
    CommonHandlers.OnSink(),
    CommonHandlers.OnFallInVoid(),
    CommonHandlers.OnDeath(),

    -- Custom event triggered by the prefab's tick system
    EventHandler("play_subtle_heal", function(inst)
        if not inst.components.health:IsDead() and not inst.sg:HasStateTag("busy") then
            inst.sg:GoToState("subtle_heal")
        end
    end),

    EventHandler("attacked", function(inst, data)
        if inst.components.health and not inst.components.health:IsDead() then
            if CommonHandlers.TryElectrocuteOnAttacked(inst, data) then
                return
            elseif not inst.sg:HasStateTag("electrocute") then
                -- Simplified logic: stunlock on hit
                if not inst.sg:HasStateTag("shield") then
                    inst.sg:GoToState("hit_stunlock")
                end
            end
        end
    end),

    EventHandler("locomote", function(inst)
        if not inst.sg:HasStateTag("busy") then
            local is_moving = inst.sg:HasStateTag("moving")
            local wants_to_move = inst.components.locomotor:WantsToMoveForward()
            if not inst.sg:HasStateTag("attack") and is_moving ~= wants_to_move then
                if wants_to_move then
                    inst.sg:GoToState("premoving")
                else
                    inst.sg:GoToState("idle", "walk_pst")
                end
            end
        end
    end),

    EventHandler("trapped", function(inst)
        if not inst.sg:HasStateTag("busy") then
            inst.sg:GoToState("trapped")
        end
    end),
}

local function SoundPath(inst, event)
    if inst.SoundPath then
        return inst:SoundPath(event)
    end
    -- Fallback route using native spider sounds
    return "dontstarve/creatures/spider/" .. event 
end

local states =
{
    State{
        name = "death",
        tags = { "busy" },

        onenter = function(inst)
            inst.SoundEmitter:PlaySound(SoundPath(inst, "die"))
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()

            RemovePhysicsColliders(inst)
            if inst.components.lootdropper then
                inst.components.lootdropper:DropLoot(inst:GetPosition())
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("corpse")
                end
            end),
        },
    },

    State{
        name = "subtle_heal",
        tags = {"busy"},

        onenter = function(inst)
            inst.Physics:Stop()
            -- Reusing eat animation for healing visually
            inst.AnimState:PlayAnimation("eat") 
        end,

        events =
        {
            EventHandler("animover", function(inst) 
                inst.sg:GoToState("idle") 
            end),
        },
    },

    State{
        name = "premoving",
        tags = {"moving", "canrotate"},

        onenter = function(inst)
            inst.components.locomotor:WalkForward()
            inst.AnimState:PlayAnimation("walk_pre")
        end,

        timeline=
        {
            TimeEvent(3*FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "walk_spider")) end),
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("moving") end),
        },
    },

    State{
        name = "moving",
        tags = {"moving", "canrotate"},

        onenter = function(inst)
            inst.components.locomotor:RunForward()
            inst.AnimState:PushAnimation("walk_loop")
        end,

        timeline=
        {
            TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "walk_spider")) end),
            TimeEvent(3*FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "walk_spider")) end),
            TimeEvent(7*FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "walk_spider")) end),
            TimeEvent(12*FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "walk_spider")) end),
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("moving") end),
        },
    },

    State{
        name = "idle",
        tags = {"idle", "canrotate"},

        ontimeout = function(inst)
            inst.sg:GoToState("idle")
        end,

        onenter = function(inst, start_anim)
            inst.Physics:Stop()
            local animname = "idle"
            if math.random() < 0.3 then
                inst.sg:SetTimeout(math.random()*2 + 2)
            end

            if inst:IsLightGreaterThan(1.0) and not inst.bedazzled and not (inst.components.follower and inst.components.follower:GetLeader()) then
                inst.AnimState:PlayAnimation("cower" )
                inst.AnimState:PushAnimation("cower_loop", true)
            elseif start_anim then
                inst.AnimState:PlayAnimation(start_anim)
                inst.AnimState:PushAnimation("idle", true)
            else
                inst.AnimState:PlayAnimation("idle", true)
            end
        end,
    },

    State{
        name = "born",
        tags = {"busy"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("taunt")
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "hit",

        onenter = function(inst)
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

    State{
        name = "hit_stunlock",
        tags = {"busy"},

        onenter = function(inst)
            inst.SoundEmitter:PlaySound(SoundPath(inst, "hit_response"))
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

    State{
        name = "trapped",
        tags = { "busy", "trapped", "noelectrocute" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst:ClearBufferedAction()
            inst.AnimState:PlayAnimation("cower")
            inst.AnimState:PushAnimation("cower_loop", true)
            inst.sg:SetTimeout(1)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("idle")
        end,
    },
}

CommonStates.AddSleepStates(states,
{
    starttimeline = {
        TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "fallAsleep")) end ),
    },
    sleeptimeline =
    {
        TimeEvent(35*FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "sleeping")) end ),
    },
    waketimeline = {
        TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound(SoundPath(inst, "wakeUp")) end ),
    },
})

CommonStates.AddFrozenStates(states)
CommonStates.AddElectrocuteStates(states)
CommonStates.AddHopStates(states, true, { pre = "boat_jump_pre", loop = "boat_jump", pst = "boat_jump_pst"})
CommonStates.AddSinkAndWashAshoreStates(states)
CommonStates.AddVoidFallStates(states)
CommonStates.AddCorpseStates(states, nil, nil, "spidercorpse")

-- The standard Klei API passes the default initial state as the 4th argument in the return.
return StateGraph("wiltolion_thingy", states, events, "idle", actionhandlers)