require("stategraphs/commonstates")

local function TryRepeatAction(inst, buffaction, right)
	if buffaction ~= nil and
		buffaction:IsValid() and
		buffaction.target ~= nil and
        buffaction.target:IsValid() and -- ¡CÓDIGO A PRUEBA DE FALLOS AQUÍ!
		buffaction.target.components.workable ~= nil and
		buffaction.target.components.workable:CanBeWorked() and
		buffaction.target:IsActionValid(buffaction.action, right)
		then
		local otheraction = inst:GetBufferedAction()
		if otheraction == nil or (
			otheraction.target == buffaction.target and
			otheraction.action == buffaction.action
		) then
			inst.components.locomotor:Stop()
			inst:ClearBufferedAction()
			inst:PushBufferedAction(buffaction)
			return true
		end
	end
	return false
end

local actionhandlers =
{
    ActionHandler(ACTIONS.CHOP,
        function(inst)
            if not inst.sg:HasStateTag("prechop") then
                return inst.sg:HasStateTag("chopping") and "chop" or "chop_start"
            end
        end),
    ActionHandler(ACTIONS.MINE,
        function(inst)
            if not inst.sg:HasStateTag("premine") then
                return inst.sg:HasStateTag("mining") and "mine" or "mine_start"
            end
        end),
    ActionHandler(ACTIONS.DIG,
        function(inst)
            if not inst.sg:HasStateTag("predig") then
                return inst.sg:HasStateTag("digging") and "dig" or "dig_start"
            end
        end),
    ActionHandler(ACTIONS.GIVE, "give"),
    ActionHandler(ACTIONS.GIVEALLTOPLAYER, "give"),
    ActionHandler(ACTIONS.DROP, "give"),
    ActionHandler(ACTIONS.PICKUP, "take"),
    ActionHandler(ACTIONS.CHECKTRAP, "take"),
    ActionHandler(ACTIONS.PICK,
		function(inst, action)
			return action.target ~= nil
				and (action.target.components.pickable ~= nil and (
						(action.target.components.pickable.jostlepick and "doshortaction") or
						(action.target.components.pickable.quickpick and "doshortaction") or
						"dolongaction"
					)) or
					(action.target.components.searchable ~= nil and (
						(action.target.components.searchable.jostlesearch and "doshortaction") or
						(action.target.components.searchable.quicksearch and "doshortaction") or
						"dolongaction"
					))
				or nil
		end),
}

local events =
{
    CommonHandlers.OnLocomote(true, false),
    CommonHandlers.OnDeath(),
    CommonHandlers.OnHop(),
	EventHandler("attacked", function(inst, data)
		if not (inst.components.health:IsDead() or inst.components.health:IsInvincible()) then
			inst.sg:GoToState("hit")
		end
	end),
    EventHandler("do_heal_leader", function(inst, data)
        if not inst.sg:HasStateTag("busy") then
            -- Pasamos el 'data' (que ahora contiene al herido) al estado
            inst.sg:GoToState("heal_leader", data)
        end
    end),
	EventHandler("doattack", function(inst, data)
		if inst.components.health ~= nil and not inst.components.health:IsDead() and not inst.sg:HasStateTag("busy") then
			inst.sg:GoToState("attack", data ~= nil and data.target or nil)
		end
	end),
    EventHandler("dance", function(inst)
        if not inst.sg:HasStateTag("busy") and (inst._brain_dancedata ~= nil or not inst.sg:HasStateTag("dancing")) then
            inst.sg:GoToState("dance")
        end
    end),
}

local states =
{
	State{
		name = "spawn",
		tags = { "busy", "noattack", "temp_invincible" },

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("idle_loop", true)
            
            -- EFECTO MASIVO DE INVOCACIÓN
            local x, y, z = inst.Transform:GetWorldPosition()
            
            local fx1 = SpawnPrefab("halloween_firepuff_1")
            fx1.Transform:SetPosition(x, y, z)
            fx1.Transform:SetScale(2, 2, 2) -- ¡El doble de grande!
            
            local fx2 = SpawnPrefab("halloween_firepuff_3")
            fx2.Transform:SetPosition(x, y + 0.5, z)
            fx2.Transform:SetScale(1.8, 1.8, 1.8)
            
            inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
            
			inst.sg:GoToState("idle")
		end,
	},

    State{
        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst, pushanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_loop", true)
        end,
    },

    State{
        name = "run_start",
        tags = {"moving", "running", "canrotate"},
        onenter = function(inst)
            inst.components.locomotor:RunForward()
            inst.AnimState:PlayAnimation("run_pre")
        end,
        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("run")
                end
            end),
        },
    },

    State{
        name = "heal_leader",
        tags = {"busy", "doing"},
        
        onenter = function(inst, data)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("give")
            inst.AnimState:PushAnimation("give_pst", false)
            
            -- Si viene un target en data lo usamos, si no, intentamos el líder por si acaso
            inst.sg.statemem.target = (data and data.target) or (inst.components.follower and inst.components.follower:GetLeader())
            
            if inst.components.talker and inst.sg.statemem.target then
                -- Wilto ahora saluda a quien va a curar
                local name = inst.sg.statemem.target.name or "friend"
                inst.components.talker:Say("Hold still, " .. name .. "! Let me help you!")
            end
        end,
        
        timeline =
        {
            TimeEvent(14 * FRAMES, function(inst)
                local target = inst.sg.statemem.target
                
                -- ¡AQUÍ ESTÁ LA LÍNEA MODIFICADA CON IsInvincible!
                if target and target:IsValid() and inst:IsNear(target, 8) 
                   and target.components.health 
                   and not target.components.health:IsDead() 
                   and not target.components.health:IsInvincible() then
                    
                    if inst.wilto_heal_tokens and inst.wilto_heal_tokens >= 1 then
                        inst.wilto_heal_tokens = inst.wilto_heal_tokens - 1
                        target.components.health:DoDelta(25)
                        inst._recently_healed = true
                        local fx = SpawnPrefab("spider_heal_target_fx")
                        if fx then
                            fx.Transform:SetPosition(target.Transform:GetWorldPosition())
                        end
                        inst.SoundEmitter:PlaySound("dontstarve/common/plant")
                    end
                end
            end),
        },
        
        events=
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "run",
        tags = {"moving", "running", "canrotate"},
        onenter = function(inst)
            inst.components.locomotor:RunForward()
            if not inst.AnimState:IsCurrentAnimation("run_loop") then
                inst.AnimState:PlayAnimation("run_loop", true)
            end
            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,
        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                PlayFootstep(inst)
            end),
            TimeEvent(15 * FRAMES, function(inst)
                PlayFootstep(inst)
            end),
        },
        ontimeout = function(inst)
			inst.sg.statemem.running = true
            inst.sg:GoToState("run")
        end,
    },

    State{
        name = "run_stop",
        tags = {"canrotate", "idle"},
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("run_pst")
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
        name = "attack",
		tags = {"attack", "abouttoattack", "busy"},
		onenter = function(inst, target)
			inst.components.locomotor:Stop()
            
			-- Revisamos si tiene algo en las manos
			local weapon = inst.components.inventory and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			
			if weapon ~= nil then
				-- Si tiene arma, usa la animación de ataque normal
				inst.AnimState:PlayAnimation("atk_pre")
				inst.AnimState:PushAnimation("atk", false)
			else
				-- Si está desarmado, usa la animación de puñetazo
				inst.AnimState:PlayAnimation("punch")
			end

			if inst.components.talker and math.random() < 0.3 then
                local lines = {"P-please don’t come closer...","I… I have to do this...!","I guess… I’ll try to win...!"}
                inst.components.talker:Say(lines[math.random(#lines)])
            end
			inst.components.combat:StartAttack()
			if target == nil then
				target = inst.components.combat.target
			end
			if target ~= nil and target:IsValid() then
				inst.sg.statemem.target = target
				inst:ForceFacePoint(target.Transform:GetWorldPosition())
			end
        end,
        timeline =
        {
			TimeEvent(8*FRAMES, function(inst)
				inst.sg:RemoveStateTag("abouttoattack")
				local target = inst.sg.statemem.target
				inst.sg.statemem.recoilstate = "attack_recoil"
				inst.components.combat:DoAttack(target) 
			end),
            TimeEvent(12*FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(13*FRAMES, function(inst)
                inst.sg:RemoveStateTag("attack")
            end),
        },
        events =
        {
			EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
		onexit = function(inst)
			if inst.sg:HasStateTag("abouttoattack") then
				inst.components.combat:CancelAttack()
			end
		end,
    },

    State{
        name = "death",
        tags = {"busy"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("death")
        end,

        -- Hemos borrado el 'timeline' que daba error

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    if inst.components.inventory ~= nil then
                        inst.components.inventory:DropEverything(true)
                    end
                    
                    -- EFECTO MASIVO AL DESAPARECER
                    local x, y, z = inst.Transform:GetWorldPosition()
                    
                    local fx1 = SpawnPrefab("halloween_firepuff_1")
                    fx1.Transform:SetPosition(x, y, z)
                    fx1.Transform:SetScale(2.5, 2.5, 2.5)
                    
                    local fx2 = SpawnPrefab("halloween_firepuff_2")
                    fx2.Transform:SetPosition(x, y + 1, z)
                    fx2.Transform:SetScale(2, 2, 2)
                    
                    inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
                    
                    -- Hemos borrado las funciones raras aquí también
                    inst:Remove()
                end
            end),
        },
    },

    State{
        name = "take",
        tags = {"busy"},
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("pickup")
            inst.AnimState:PushAnimation("pickup_pst", false)
        end,
        timeline =
        {
            TimeEvent(6 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },
        events=
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle") 
                end
            end),
        },
    },

    State{
        name = "give",
        tags = {"busy"},
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("give")
            inst.AnimState:PushAnimation("give_pst", false)
        end,
        timeline =
        {
            TimeEvent(14 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },
        events=
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "hit",
        tags = {"busy"},
        onenter = function(inst)
			if inst.components.talker and math.random() < 0.3 then
                local lines = {"Ow...!", "That... really hurts...!", "Ah... damn it...!"}
                inst.components.talker:Say(lines[math.random(#lines)])
            end
            inst:ClearBufferedAction()
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()
        end,
        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
        timeline =
        {
            TimeEvent(3*FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
        },
    },

    State{
        name = "chop_start",
        tags = {"prechop", "working"},
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("chop_pre")
        end,
        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("chop")
                end
            end),
        },
    },

    State{
        name = "chop",
        tags = {"prechop", "chopping", "working"},
        onenter = function(inst)
			inst.sg.statemem.action = inst:GetBufferedAction()
            inst.AnimState:PlayAnimation("chop_loop")
        end,
        timeline =
        {
            TimeEvent(2 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
			TimeEvent(14 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("prechop")
				TryRepeatAction(inst, inst.sg.statemem.action)
            end),
            TimeEvent(16*FRAMES, function(inst)
                inst.sg:RemoveStateTag("chopping")
            end),
        },
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
        name = "mine_start",
        tags = {"premine", "working"},
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("pickaxe_pre")
        end,
        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("mine")
                end
            end),
        },
    },

    State{
        name = "mine",
        tags = {"premine", "mining", "working"},
        onenter = function(inst)
			inst.sg.statemem.action = inst:GetBufferedAction()
            inst.AnimState:PlayAnimation("pickaxe_loop")
        end,
        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
				if inst.sg.statemem.action ~= nil then
					PlayMiningFX(inst, inst.sg.statemem.action.target)
					inst.sg.statemem.recoilstate = "mine_recoil"
                    inst:PerformBufferedAction()
                end
            end),
            TimeEvent(14 * FRAMES, function(inst)
				inst.sg:RemoveStateTag("premine")
				TryRepeatAction(inst, inst.sg.statemem.action)
            end),
        },
        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.AnimState:PlayAnimation("pickaxe_pst")
                    inst.sg:GoToState("idle", true)
                end
            end),
        },
    },

    State{
        name = "dig_start",
        tags = {"predig", "working"},
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("shovel_pre")
        end,
        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("dig")
                end
            end),
        },
    },

    State{
        name = "dig",
        tags = {"predig", "digging", "working"},
        onenter = function(inst)
			inst.sg.statemem.action = inst:GetBufferedAction()
            inst.AnimState:PlayAnimation("shovel_loop")
        end,
        timeline =
        {
            TimeEvent(15 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
            TimeEvent(35 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("predig")
				TryRepeatAction(inst, inst.sg.statemem.action, true)
            end),
        },
        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.AnimState:PlayAnimation("shovel_pst")
                    inst.sg:GoToState("idle", true)
                end
            end),
        },
    },

    State{
        name = "dance",
        tags = {"idle", "dancing"},
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()
            local ignoreplay = inst.AnimState:IsCurrentAnimation("run_pst")
            if inst._brain_dancedata and #inst._brain_dancedata > 0 then
                for _, data in ipairs(inst._brain_dancedata) do
                    if data.play and not ignoreplay then
                        inst.AnimState:PlayAnimation(data.anim, data.loop)
                    else
                        inst.AnimState:PushAnimation(data.anim, data.loop)
                    end
                end
            else
                if ignoreplay then
                    inst.AnimState:PushAnimation("emoteXL_pre_dance0")
                else
                    inst.AnimState:PlayAnimation("emoteXL_pre_dance0")
                end
                inst.AnimState:PushAnimation("emoteXL_loop_dance0", true)
            end
            inst._brain_dancedata = nil
        end,
    },

    State{
        name = "dolongaction",
        tags = { "doing", "busy", "nodangle" },
        onenter = function(inst, timeout)
            if timeout == nil then timeout = 1
            elseif timeout > 1 then inst.sg:AddStateTag("slowaction") end
            inst.sg:SetTimeout(timeout)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("build_pre")
            inst.AnimState:PushAnimation("build_loop", true)
            if inst.bufferedaction ~= nil then
                inst.sg.statemem.action = inst.bufferedaction
                if inst.bufferedaction.target ~= nil and inst.bufferedaction.target:IsValid() then
					inst.bufferedaction.target:PushEvent("startlongaction", inst)
                end
            end
        end,
        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
        },
        ontimeout = function(inst)
            inst.AnimState:PlayAnimation("build_pst")
            inst:PerformBufferedAction()
        end,
        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
        onexit = function(inst)
            if inst.bufferedaction == inst.sg.statemem.action then
                inst:ClearBufferedAction()
            end
        end,
    },

    State{
        name = "doshortaction",
        tags = { "doing", "busy" },
        onenter = function(inst)
            inst.components.locomotor:Stop()
			inst.AnimState:PlayAnimation("pickup")
			inst.AnimState:PushAnimation("pickup_pst", false)
            inst.sg.statemem.action = inst.bufferedaction
            inst.sg:SetTimeout(10 * FRAMES)
        end,
        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(6 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },
        ontimeout = function(inst)
            inst.sg:GoToState("idle", true)
        end,
        onexit = function(inst)
            if inst.bufferedaction == inst.sg.statemem.action then
                inst:ClearBufferedAction()
            end
        end,
    },

	State{
		name = "item_out_chop",
		onenter = function(inst) inst.sg:GoToState("item_out", "chop") end,
	},
	State{
		name = "item_out_mine",
		onenter = function(inst) inst.sg:GoToState("item_out", "mine") end,
	},
	State{
		name = "item_out_dig",
		onenter = function(inst) inst.sg:GoToState("item_out", "dig") end,
	},
	State{
		name = "item_out",
		tags = { "working" },
		onenter = function(inst, action)
			inst.components.locomotor:StopMoving()
			inst.AnimState:PlayAnimation("item_out")
			if action ~= nil then
				inst.sg:AddStateTag("pre"..action)
				inst.sg.statemem.action = action
				inst.sg:SetTimeout(9 * FRAMES)
			else
				inst.sg:RemoveStateTag("working")
				inst.sg:AddStateTag("idle")
			end
		end,
		ontimeout = function(inst)
			inst.sg:GoToState(inst.sg.statemem.action.."_start")
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
    
    -- Los estados de recoil (retroceso) son útiles visualmente para golpes normales
	State{
		name = "mine_recoil",
		tags = { "busy", "recoil" },
		onenter = function(inst, data)
			inst.components.locomotor:Stop()
			inst:ClearBufferedAction()
			inst.AnimState:PlayAnimation("pickaxe_recoil")
			if data ~= nil and data.target ~= nil and data.target:IsValid() then
                local pos = data.target:GetPosition()
                if data.target.recoil_effect_offset then
                    pos = pos + data.target.recoil_effect_offset
                end
				SpawnPrefab("impact").Transform:SetPosition(pos:Get())
			end
			inst.Physics:SetMotorVelOverride(-6, 0, 0)
		end,
		onupdate = function(inst)
			if inst.sg.statemem.speed ~= nil then
				inst.Physics:SetMotorVelOverride(inst.sg.statemem.speed, 0, 0)
				inst.sg.statemem.speed = inst.sg.statemem.speed * 0.75
			end
		end,
		timeline =
		{
			FrameEvent(4, function(inst) inst.sg.statemem.speed = -3 end),
			FrameEvent(17, function(inst)
				inst.sg.statemem.speed = nil
				inst.Physics:ClearMotorVelOverride()
				inst.Physics:Stop()
			end),
			FrameEvent(23, function(inst) inst.sg:RemoveStateTag("busy") end),
			FrameEvent(30, function(inst) inst.sg:GoToState("idle", true) end),
		},
		events =
		{
			EventHandler("animover", function(inst)
				if inst.AnimState:AnimDone() then
					inst.sg:GoToState("idle")
				end
			end),
		},
		onexit = function(inst)
			inst.Physics:ClearMotorVelOverride()
			inst.Physics:Stop()
		end,
	},

	State{
		name = "attack_recoil",
		tags = { "busy", "recoil" },
		onenter = function(inst, data)
			inst.components.locomotor:Stop()
			inst:ClearBufferedAction()
			inst.AnimState:PlayAnimation("atk_recoil")
			if data ~= nil and data.target ~= nil and data.target:IsValid() then
                local pos = data.target:GetPosition()
                if data.target.recoil_effect_offset then
                    pos = pos + data.target.recoil_effect_offset
                end
				SpawnPrefab("impact").Transform:SetPosition(pos:Get())
			end
			inst.Physics:SetMotorVelOverride(-6, 0, 0)
		end,
		onupdate = function(inst)
			if inst.sg.statemem.speed ~= nil then
				inst.Physics:SetMotorVelOverride(inst.sg.statemem.speed, 0, 0)
				inst.sg.statemem.speed = inst.sg.statemem.speed * 0.75
			end
		end,
		timeline =
		{
			FrameEvent(4, function(inst) inst.sg.statemem.speed = -3 end),
			FrameEvent(17, function(inst)
				inst.sg.statemem.speed = nil
				inst.Physics:ClearMotorVelOverride()
				inst.Physics:Stop()
			end),
			FrameEvent(23, function(inst) inst.sg:RemoveStateTag("busy") end),
			FrameEvent(30, function(inst) inst.sg:GoToState("idle", true) end),
		},
		events =
		{
			EventHandler("animover", function(inst)
				if inst.AnimState:AnimDone() then
					inst.sg:GoToState("idle")
				end
			end),
		},
		onexit = function(inst)
			inst.Physics:ClearMotorVelOverride()
			inst.Physics:Stop()
		end,
	},
}

CommonStates.AddHopStates(states, true, { pre = "boat_jump_pre", loop = "boat_jump_loop", pst = "boat_jump_pst" })

return StateGraph("wiltolionwilto", states, events, "spawn", actionhandlers)