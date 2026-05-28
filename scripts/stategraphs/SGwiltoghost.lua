require("stategraphs/commonstates")

local events =
{
    CommonHandlers.OnLocomote(true, true),
    EventHandler("death", function(inst)
        inst.sg:GoToState("dissipate")
    end),
}

local states =
{
    State{
        name = "idle",
        tags = { "idle", "canrotate", "canslide" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle", true)
        end,
    },

    State{
        name = "appear",

        onenter = function(inst)
            inst.AnimState:PlayAnimation("appear")
            inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_howl")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "dissipate",
        tags = { "busy", "noattack", "nointerrupt" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("dissipate")
            inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_howl")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst:Remove()
                end
            end)
        },
    },
}

-- The ghost uses the "idle" animation while moving to simulate floating
local function getidleanim() return "idle" end

CommonStates.AddSimpleWalkStates(states, getidleanim)
CommonStates.AddSimpleRunStates(states, getidleanim)

return StateGraph("wiltoghost", states, events, "appear")