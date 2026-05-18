require "behaviours/wander"
require "behaviours/faceentity"
require "behaviours/chaseandattack"
require "behaviours/panic"
require "behaviours/follow"
require "behaviours/attackwall"
require "behaviours/standstill"
require "behaviours/leash"
require "behaviours/runaway"
require "behaviours/doaction"

local BrainCommon = require("brains/braincommon")

local WiltolionWiltoBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local MIN_FOLLOW_DIST = 0
local TARGET_FOLLOW_DIST = 6
local MAX_FOLLOW_DIST = 8

local START_FACE_DIST = 4
local KEEP_FACE_DIST = 8

local KEEP_DANCING_DIST = 2
local AVOID_EXPLOSIVE_DIST = 5

local DIG_TAGS = { "stump", "grave", "farm_debris" }
local TOWORK_CANT_TAGS = { "fire", "smolder", "event_trigger", "waxedplant", "INLIMBO", "NOCLICK", "carnivalgame_part", "structure", "wiltolion_pylon" }
local ANY_TOWORK_ACTIONS = {ACTIONS.CHOP, ACTIONS.MINE, ACTIONS.DIG}
local ANY_TOWORK_MUSTONE_TAGS = {"CHOP_workable", "MINE_workable", "DIG_workable"}

local function GetLeader(inst)
    return inst.components.follower and inst.components.follower:GetLeader()
end

local function GetLeaderPos(inst)
    local leader = GetLeader(inst)
    return leader ~= nil and leader:GetPosition() or nil
end

local function GetFaceLeaderFn(inst)
    local target = GetLeader(inst)
    return target ~= nil and target.entity:IsVisible() and inst:IsNear(target, START_FACE_DIST) and target or nil
end

local function KeepFaceLeaderFn(inst, target)
    return target.entity:IsVisible() and inst:IsNear(target, KEEP_FACE_DIST)
end

-- =========================================================
-- RUTINAS DE TRABAJO (Talar, Minar, Cavar)
-- =========================================================

local function PickValidActionFrom(target, inst) 
    if target.components.workable == nil then return nil, nil end
    local desiredact = target.components.workable:GetWorkAction()
    
    if inst.wilto_toggles ~= nil then
        if desiredact == ACTIONS.CHOP and inst.wilto_toggles.chop == false then return nil, nil end
        if desiredact == ACTIONS.MINE and inst.wilto_toggles.mine == false then return nil, nil end
        if desiredact == ACTIONS.DIG and inst.wilto_toggles.dig == false then return nil, nil end
    end

    for _, act in ipairs(ANY_TOWORK_ACTIONS) do
        if desiredact == act then
            local current_tool = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if current_tool ~= nil and current_tool.components.tool ~= nil and current_tool.components.tool:CanDoAction(act) then
                return act, current_tool
            end
            for k, item in pairs(inst.components.inventory.itemslots) do
                if item and item.components.tool and item.components.tool:CanDoAction(act) then
                    inst.components.inventory:Equip(item)
                    return act, item
                end
            end
        end
    end
    return nil, nil
end

local function FilterAnyWorkableTargets(targets, inst)
    local toggles = inst.wilto_toggles or {}
    
    for _, sometarget in ipairs(targets) do
        -- Blindaje anticolisiones (Evita que mire árboles cayendo)
        if sometarget ~= nil and sometarget:IsValid() and sometarget.components.workable ~= nil and sometarget.components.workable:CanBeWorked() then
            
            if sometarget.components.burnable == nil or (not sometarget.components.burnable:IsBurning() and not sometarget.components.burnable:IsSmoldering()) then
                
                -- LÓGICA DE TALADO
                if sometarget:HasTag("CHOP_workable") and toggles.chop ~= false then
                    if sometarget:HasTag("tree") and not sometarget:HasTag("stump") then
                        
                        -- === EL FILTRO EXACTO ===
                        if sometarget.components.growable ~= nil and sometarget.components.growable.stage ~= nil then
                            -- Usamos '==' para que SOLO tale los de nivel 3
                            if sometarget.components.growable.stage == 3 then
                                return sometarget
                            end
                        elseif sometarget:HasTag("burnt") then
                            return sometarget
                        end
                        
                    end

                -- LÓGICA DE CAVAR
                elseif sometarget:HasTag("DIG_workable") and toggles.dig ~= false then
                    for _, tag in ipairs(DIG_TAGS) do
                        if sometarget:HasTag(tag) then
                            return sometarget
                        end
                    end

                -- LÓGICA DE MINAR
                elseif toggles.mine ~= false then
                    return sometarget
                end
            end
        end
    end
    return nil
end

-- =========================================================
-- WORK ROUTINES - PERFORMANCE FIX FOR THE "BLIND ROOMBA"
-- =========================================================
local function FindAnyEntityToWorkActionsOn(inst)
    if inst.sg:HasStateTag("busy") then return nil end
    local leader = GetLeader(inst)
    if leader == nil then return nil end

    -- PERFORMANCE FIX: Throttle the massive 25-radius double scan!
    local t = GetTime()
    if inst._next_work_scan ~= nil and t < inst._next_work_scan then
        return nil
    end
    -- If nothing is found, wait 3.0 seconds before punishing the CPU again
    inst._next_work_scan = t + 3.0

    local x, y, z = inst.Transform:GetWorldPosition()
    
    -- 1. Scan 25 units around Wilto
    local target = FilterAnyWorkableTargets(TheSim:FindEntities(x, y, z, 25, nil, TOWORK_CANT_TAGS, ANY_TOWORK_MUSTONE_TAGS), inst)
    
    -- 2. Scan 25 units around Leader
    if target == nil then
        local lx, ly, lz = leader.Transform:GetWorldPosition()
        target = FilterAnyWorkableTargets(TheSim:FindEntities(lx, ly, lz, 25, nil, TOWORK_CANT_TAGS, ANY_TOWORK_MUSTONE_TAGS), inst)
    end
    
    local action, tool = nil, nil
    if target ~= nil then
        action, tool = PickValidActionFrom(target, inst)
    end
    
    if action ~= nil then
        -- Clear the timer so he can continue working fluidly without delays
        inst._next_work_scan = nil
        return BufferedAction(inst, target, action, tool)
    end
    
    return nil
end

-- =========================================================
-- RECOLECCIÓN EXCLUSIVA DE RECURSOS (MADERA, PIEDRA, ETC)
-- =========================================================
local function IsLeaderInCombat(leader)
    local leader_combat = leader.components.combat
    if leader_combat == nil then return false end
    local timeout_time = GetTime() - 6
    local attack_time = math.max(leader_combat.laststartattacktime or 0, leader_combat.lastdoattacktime or 0)
    if attack_time > timeout_time then return true end
    if leader_combat:GetLastAttackedTime() > timeout_time then return true end
    return false
end

-- =========================================================
-- AUTO-SORTING SYSTEM - FULLY OPTIMIZED (THROTTLED)
-- =========================================================
local function FindChestToStoreItem(inst)
    if inst.sg:HasStateTag("busy") then return nil end
    
    if inst.wilto_toggles ~= nil and (inst.wilto_toggles.pickup == false or inst.wilto_toggles.give == false) then
        return nil
    end

    local inv = inst.components.inventory
    if inv == nil or inv.itemslots == nil or next(inv.itemslots) == nil then
        return nil
    end

    -- PERFORMANCE FIX: Throttle the heavy spatial scan.
    -- If we recently scanned and failed, wait 2.5 seconds before scanning again.
    local t = GetTime()
    if inst._next_sort_scan ~= nil and t < inst._next_sort_scan then
        return nil
    end
    -- Update the timer for the next allowed scan
    inst._next_sort_scan = t + 2.5

    local x, y, z = inst.Transform:GetWorldPosition()
    local containers = TheSim:FindEntities(x, y, z, 20, { "_container" }, { "INLIMBO", "NOCLICK" })
    
    if #containers == 0 then return nil end 

    for k, item in pairs(inv.itemslots) do
        if item ~= nil and not item:HasTag("irreplaceable") then
            
            for _, container_ent in ipairs(containers) do
                local cont = container_ent.components.container
                local inv_item = container_ent.components.inventoryitem
                local is_held = inv_item ~= nil and inv_item.owner ~= nil
                
                if cont ~= nil and not is_held and cont:IsOpen() == false then
                    
                    if cont:Has(item.prefab, 1) then
                        local can_store = false
                        
                        if not cont:IsFull() then
                            can_store = true
                        elseif item.components.stackable ~= nil then
                            for i, v in pairs(cont.slots) do
                                if v.prefab == item.prefab and v.components.stackable ~= nil and not v.components.stackable:IsFull() then
                                    can_store = true
                                    break
                                end
                            end
                        end
                        
                        if can_store then
                            -- Clear the timer so Wilto can immediately look for the next chest
                            inst._next_sort_scan = nil
                            
                            local action = BufferedAction(inst, container_ent, ACTIONS.STORE, item)
                            action.distance = 1.5
                            return action
                        end
                    end
                end
            end
        end
    end
    
    return nil
end

-- =========================================================
-- RESOURCE GATHERING (Original logic + Anti-stuck Blacklist)
-- =========================================================
local function FindResourceToPickup(inst)
    if inst.sg:HasStateTag("busy") then return nil end
    
    if inst.wilto_toggles ~= nil and inst.wilto_toggles.pickup == false then 
        return nil 
    end

    local t = GetTime()
    if inst._next_pickup_scan ~= nil and t < inst._next_pickup_scan then
        return nil
    end
    inst._next_pickup_scan = t + 1.0

    local leader = GetLeader(inst)
    if not leader then return nil end

    if inst.components.inventory and inst.components.inventory:IsFull() then
        return nil
    end

    local x, y, z = inst.Transform:GetWorldPosition()
    
    -- Engine-level tag filtering (faster than checking inside the Lua loop)
    local NO_TAGS = { 
        "INLIMBO", "NOCLICK", "catchable", "fire", 
        "irreplaceable", "nosteal", "heavy", "backpack" 
    }
    
    local ents = TheSim:FindEntities(x, y, z, 15, { "_inventoryitem" }, NO_TAGS)

    -- Ensure blacklist table exists
    if inst._blacklisted_items == nil then 
        inst._blacklisted_items = {} 
    end

    -- Get the leader's ignore list
    local ignorethese = leader._brain_pickup_ignorethese or {}

    for i, item in ipairs(ents) do
        local is_blacklisted = false
        if inst._blacklisted_items[item] ~= nil then
            if t < inst._blacklisted_items[item] then
                is_blacklisted = true
            else
                inst._blacklisted_items[item] = nil -- Remove expired item
            end
        end
        
        if item:IsValid() and 
           not is_blacklisted and 
           not ignorethese[item] and -- Respect leader's ignored items
           item.components.inventoryitem and 
           item.components.inventoryitem.canbepickedup and 
           not item.components.inventoryitem:IsHeld() and
           item.components.container == nil and -- Strictly avoid picking up anything with a container
           item:IsOnValidGround() and
           not item:HasTag("trap") and 
           item:GetDistanceSqToInst(leader) < 400 then
            
            inst._next_pickup_scan = nil 
            return BufferedAction(inst, item, ACTIONS.PICKUP)
        end
    end

    return nil
end

-- 2. FUNCIÓN AYUDANTE: Comprueba inteligentemente si el jugador puede recibir este objeto
local function CanLeaderAcceptItem(leader, item)
    local inv = leader.components.inventory
    if not inv then return false end
    
    -- 1. Si hay espacio vacío en tu inventario principal, siempre puede dártelo.
    if not inv:IsFull() then return true end
    
    -- 2. Revisamos si llevas una mochila puesta y si esa mochila tiene espacio vacío.
    local body_item = inv:GetEquippedItem(EQUIPSLOTS.BODY)
    if body_item ~= nil and body_item.components.container ~= nil and not body_item.components.container:IsFull() then
        return true
    end
    
    -- 3. Si NO hay huecos vacíos, comprobamos si el objeto se puede apilar (stackear) 
    -- en un montón que ya tengas empezado y que no esté lleno.
    if item.components.stackable ~= nil then
        
        -- Buscar hueco en tu inventario principal
        for k, v in pairs(inv.itemslots) do
            if v.prefab == item.prefab and v.components.stackable ~= nil and not v.components.stackable:IsFull() then
                return true -- ¡Encontró un stack incompleto!
            end
        end
        
        -- Buscar hueco en tu mochila (si tienes una)
        if body_item ~= nil and body_item.components.container ~= nil then
            for k, v in pairs(body_item.components.container.slots) do
                if v.prefab == item.prefab and v.components.stackable ~= nil and not v.components.stackable:IsFull() then
                    return true -- ¡Encontró un stack incompleto en la mochila!
                end
            end
        end
        
    end
    
    -- Si no hay casillas vacías ni stacks incompletos de este objeto, no te lo da.
    return false
end

-- 3. LA FUNCIÓN DE DAR (Actualizada para usar el nuevo escáner)
local function GiveResourcesToLeader(inst)
    if inst.sg:HasStateTag("busy") then return nil end
    -- NUEVO: Comprueba el botón
    if inst.wilto_toggles ~= nil and not inst.wilto_toggles.give then return nil end
    local leader = GetLeader(inst)
    if not leader or IsLeaderInCombat(leader) or leader:HasTag("playerghost") then return nil end
    if not inst:IsNear(leader, 10) then return nil end
    
    for k, item in pairs(inst.components.inventory.itemslots) do
        if item and item.components.equippable == nil then
            
            -- Ahora usamos nuestra función inteligente para evaluar objeto por objeto
            if CanLeaderAcceptItem(leader, item) then
                return BufferedAction(inst, leader, ACTIONS.GIVEALLTOPLAYER, item)
            end
            
        end
    end
    return nil
end

-- =========================================================
-- COMPORTAMIENTOS VARIOS
-- =========================================================
local function DanceParty(inst) inst:PushEvent("dance") end
local function ShouldDanceParty(inst)
    local leader = GetLeader(inst)
    return leader ~= nil and leader.sg:HasStateTag("dancing")
end

local function ShouldAvoidExplosive(target)
    return target.components.explosive == nil or target.components.burnable == nil or target.components.burnable:IsBurning()
end

-- Decide de qué cosas debe huir si está en modo supervivencia
local function IsDanger(target, inst)
    -- Si NO está en pánico, no huye de nadie
    if not (inst.ShouldFleeForSurvival and inst:ShouldFleeForSurvival()) then 
        return false 
    end
    
    -- ESCUDO ALIADO: Si es un jugador o un compañero, no huye NUNCA.
    if target:HasTag("player") or target:HasTag("companion") then 
        return false 
    end
    
    -- Si está en pánico y no es un aliado, huye de monstruos o de cosas que le estén pegando a él
    return target:HasTag("monster") or (target.components.combat and target.components.combat.target == inst)
end

local function ShouldWatchMinigame(inst)
    local leader = GetLeader(inst)
    if leader ~= nil and leader.components.minigame_participator ~= nil then
        if inst.components.combat.target == nil or inst.components.combat.target.components.minigame_participator ~= nil then return true end
    end
    return false
end

local function WatchingMinigame(inst)
    local leader = GetLeader(inst)
    return (leader ~= nil and leader.components.minigame_participator ~= nil) and leader.components.minigame_participator:GetMinigame() or nil
end

-- =========================================================
-- RECOLECCIÓN DE PLANTAS (Hierba, Palitos, Bayas, etc.)
-- =========================================================
local PICK_CANT_TAGS = { "INLIMBO", "NOCLICK", "fire", "smolder", "catchable", "thorny", "flower", "crop","berrybush","crop" }

local function FindPlantToPick(inst)
    if inst.sg:HasStateTag("busy") then return nil end
    
    -- Control mediante tu interfaz (Adventure Journal)
    if inst.wilto_toggles ~= nil and inst.wilto_toggles.harvest == false then return nil end

    -- Para evitar que llene el suelo de objetos si no tiene espacio, limitamos su inventario
    local inv = inst.components.inventory
    if inv ~= nil and inv:IsFull() then return nil end

    local leader = GetLeader(inst)
    if not leader then return nil end

    local px, py, pz = leader.Transform:GetWorldPosition()
    
    -- Buscamos en un radio de 15 metros alrededor del líder
    local ents = TheSim:FindEntities(px, py, pz, 15, nil, PICK_CANT_TAGS)

    for _, target in ipairs(ents) do
        -- Comprobación a prueba de fallos y validación de componentes nativos
        if target ~= nil and target:IsValid() and target.components.pickable ~= nil and target.components.pickable:CanBePicked() and target.components.pickable.caninteractwith then
            return BufferedAction(inst, target, ACTIONS.PICK)
        end
    end

    return nil
end

local function GetHealTarget(inst)
    if inst._last_heal_time ~= nil and (GetTime() - inst._last_heal_time) < 15 then
        return nil
    end

    if not inst.wilto_heal_tokens or inst.wilto_heal_tokens < 1 then
        if inst._recently_healed then
            inst._last_heal_time = GetTime()
            inst._recently_healed = false
        end
        return nil 
    end
    
    local x, y, z = inst.Transform:GetWorldPosition()
    local targets = TheSim:FindEntities(x, y, z, 15, { "_health" }, { "INLIMBO", "playerghost", "hostile" }, { "player", "companion", "character" })
    
    local best_target = nil
    local lowest_hp = 0.75 

    -- Lista negra de prefabs a los que NUNCA curar
    local BLACKLIST = {
        ["wiltolion_buddy"] = true,
        ["wone"] = true, -- Aquí pones el prefab de tu personaje de mod especial
        -- Puedes añadir más aquí en el futuro
    }

    for _, target in ipairs(targets) do
        -- 1. Verifica la lista negra
        -- 2. Verifica que tenga vida y no esté muerto
        -- 3. [LA MAGIA] Verifica que NO sea invencible (esto arregla el Sun Torus)
        -- 4. Que no sea un fantasma
        if not BLACKLIST[target.prefab] 
           and target.components.health 
           and not target.components.health:IsDead() 
           and not target.components.health:IsInvincible() 
           and not target:HasTag("playerghost") then
           
            local hp = target.components.health:GetPercent()
            if hp < lowest_hp then
                lowest_hp = hp
                best_target = target
            end
        end
    end
    
    if best_target == nil and inst._recently_healed then
        inst._last_heal_time = GetTime()
        inst._recently_healed = false
    end
    
    return best_target
end

local function CreateWanderer(self, maxdist)
    return Wander(self.inst, function() return GetLeaderPos(self.inst) end, maxdist, nil, nil, nil, nil, { should_run = false, wander_dist = 4 })
end

-- =========================================================
-- SISTEMA DE KITE OFICIAL DE KLEi (Clon WX-78)
-- =========================================================
local function GetLeaderAction(inst)
    local target
    local act = inst:GetBufferedAction() or inst.sg.statemem.action
    if act then
        target = act.target
        act = act.action
    elseif inst.components.playercontroller then
        act, target = inst.components.playercontroller:GetRemoteInteraction()
    end
    return act, target
end

local function IsLeaderAttacking(inst)
    local leader = GetLeader(inst)
    if leader ~= nil then
        local leaderact, leadertarget = GetLeaderAction(leader)
        if leaderact == ACTIONS.ATTACK then return true end
        if leader.components.combat.target ~= nil then return true end
    end
end

local function IsLeaderMoving(inst)
    local leader = GetLeader(inst)
    if leader ~= nil then
        return leader.components.locomotor ~= nil and leader.components.locomotor:WantsToMoveForward()
    end
end

local function GetRunAwayTarget(inst)
    local target = inst.components.combat.target or Ents[inst.components.combat.lasttargetGUID]
    if target ~= nil and not target:HasTag("dead") then
        return target
    end
end

local DROP_TARGET_KITE_DIST_SQ = 14 * 14
local function LeaderInRangeOfTarget(inst)
    local leader = GetLeader(inst)
    local target = GetRunAwayTarget(inst)
    if leader ~= nil and target ~= nil then
        if leader:GetDistanceSqToInst(target) > DROP_TARGET_KITE_DIST_SQ then
            inst.components.combat:SetTarget(nil)
            return false
        end
    end
    return true
end

local RUNAWAY_PARAM = { getfn = GetRunAwayTarget }
local MAX_KITE_DIST = 10
local TOLERANCE_DIST = .5

local function GetRunDist(inst, hunter)
    local attack_range = inst.components.combat:GetAttackRange()
    local leader = GetLeader(inst)
    if leader ~= nil then
        local dist = math.max(attack_range, math.min(math.sqrt(leader:GetDistanceSqToInst(hunter)), MAX_KITE_DIST))
        if inst._lastdist == nil or (math.abs(inst._lastdist - dist) >= TOLERANCE_DIST) then
            inst._lastdist = dist
            inst._lastruntime = GetTime()
            return dist
        else
            return inst._lastdist
        end
    end
    return 1 
end

local RUN_AFTER_KITE_DELAY = 1

-- =========================================================
-- ADVANCED CHEAT KITING (Frame-Perfect & Cooldown Math)
-- =========================================================
local function ShouldCheatKite(inst)
    local target = inst.components.combat.target
    if target == nil or not target:IsValid() or target.components.health == nil or target.components.health:IsDead() then
        return false
    end

    local t_combat = target.components.combat
    if t_combat == nil then
        return false
    end

    -- 1. EXPLOIT INCAPACITATION: Never dodge if the enemy cannot fight back
    if target.components.sleeper and target.components.sleeper:IsAsleep() then return false end
    if target.components.freezable and target.components.freezable:IsFrozen() then return false end
    if target.sg and target.sg:HasStateTag("stunned") then return false end

    -- 2. GET REAL TIME RANGES
    -- Use the enemy's attack range plus their physics radius to get the true hit edge
    local t_range = t_combat:GetAttackRange() + (target:GetPhysicsRadius(0) or 0) + 0.5
    local dist_sq = inst:GetDistanceSqToInst(target)

    -- If we are already out of the enemy's attack range, stop kiting and go attack!
    if dist_sq > (t_range * t_range) then
        return false
    end

    -- 3. ANIMATION CHECK: Is the enemy actively swinging right now?
    -- "abouttoattack" is used in DST for pre-hit frames, "attack" for the swing
    if target.sg and (target.sg:HasStateTag("attack") or target.sg:HasStateTag("abouttoattack")) then
        return true
    end

    -- 4. COOLDOWN MATH (The core cheat)
    -- Natively, DST combat components use lastdoattacktime or laststartattacktime
    local last_attack = t_combat.laststartattacktime or t_combat.lastdoattacktime or 0
    local attack_period = t_combat.min_attack_period or 2
    local time_since_attack = GetTime() - last_attack
    local time_to_next_attack = attack_period - time_since_attack

    -- Wilto needs roughly 0.6 seconds to safely perform his own attack animation
    -- If the enemy will be ready to strike in less than this time, back off
    local WILTO_ATTACK_WINDUP = 0.6

    if time_to_next_attack <= WILTO_ATTACK_WINDUP then
        return true
    end

    -- If we survived all checks, it means we have a safe time window to strike
    return false
end

-- =========================================================
-- MAIN BRAIN STARTUP
-- =========================================================
function WiltolionWiltoBrain:OnStart()
    
    -- =====================================================
    -- 1. LOCAL EVENT NODES & SETUP
    -- =====================================================
    local watch_game = WhileNode( function() return ShouldWatchMinigame(self.inst) end, "Watching Game",
        PriorityNode({ 
            Follow(self.inst, WatchingMinigame, 0, 0, 0), 
            RunAway(self.inst, "minigame_participator", 5, 7), 
            FaceEntity(self.inst, WatchingMinigame, WatchingMinigame) 
        }, 0.25))
    
    local dance_party = WhileNode(function() return ShouldDanceParty(self.inst) end, "Dance Party",
        PriorityNode({ 
            Leash(self.inst, GetLeaderPos, KEEP_DANCING_DIST, KEEP_DANCING_DIST), 
            ActionNode(function() DanceParty(self.inst) end) 
        }, 0.25))

    local avoid_explosions = RunAway(self.inst, { fn = ShouldAvoidExplosive, tags = { "explosive" }, notags = { "INLIMBO" } }, AVOID_EXPLOSIVE_DIST, AVOID_EXPLOSIVE_DIST)

    local leader = GetLeader(self.inst)
    local ignorethese = leader ~= nil and leader._brain_pickup_ignorethese or {}
    if leader ~= nil then leader._brain_pickup_ignorethese = ignorethese end

    -- =====================================================
    -- 2. BEHAVIOR TREE ROOT (EVALUATED TOP TO BOTTOM)
    -- =====================================================
    local root = PriorityNode({
        
        -- [ SECTION 1: EMERGENCIES & PANIC ] ------------------
        -- Highest priority: Survive immediate threats
        avoid_explosions,
        WhileNode(function() return self.inst.components.burnable and self.inst.components.burnable:IsBurning() end, "OnFire", Panic(self.inst)),
        RunAway(self.inst, { fn = IsDanger, tags = {"_combat", "_health"}, notags = {"INLIMBO", "player"} }, 10, 15),

        -- [ SECTION 2: SPECIAL EVENTS ] -----------------------
        dance_party,
        watch_game,

        -- [ SECTION 3: HEALING & SUPPORT ] --------------------
        WhileNode(function() 
            self.inst.wilto_target_to_heal = GetHealTarget(self.inst)
            return self.inst.wilto_target_to_heal ~= nil 
        end, "Needs Healing",
            PriorityNode({
                WhileNode(function() return self.inst:IsNear(self.inst.wilto_target_to_heal, 2.5) end, "Do Heal",
                    ActionNode(function()
                        if not self.inst.sg:HasStateTag("busy") then
                            self.inst:PushEvent("do_heal_leader", { target = self.inst.wilto_target_to_heal })
                        end
                    end)),
                Follow(self.inst, function() return self.inst.wilto_target_to_heal end, 0, 1, 2)
            }, 0.25)
        ),

        -- [ SECTION 4: COMBAT & TACTICS ] ---------------------
        -- 4.1 Force drop aggro if leader is too far away
        WhileNode(function()
            local current_leader = GetLeader(self.inst)
            local target = self.inst.components.combat.target
            return target ~= nil and current_leader ~= nil and self.inst:GetDistanceSqToInst(current_leader) > 225
        end, "Retreat From Combat",
            PriorityNode({
                FailIfSuccessDecorator(ActionNode(function() 
                    self.inst.components.combat:DropTarget() 
                end)),
                Follow(self.inst, GetLeader, 0, 3, 5)
            }, 0.25)
        ),
        
        -- 4.2 Combat maneuvers
        WhileNode(function() return ShouldCheatKite(self.inst) end, "Cheat Kiting",
            RunAway(self.inst, function(guy) 
                return guy == self.inst.components.combat.target 
            end, 3, 4) 
        ),
        ChaseAndAttack(self.inst),

        -- [ SECTION 5: WORK & RESOURCE GATHERING ] ------------
        WhileNode(function() return not self.inst.sg:HasStateTag("recoil") end, "Busy State Guard",
            PriorityNode({
                -- 5.1 Continue current tool action (Chop, Mine, Dig)
                WhileNode(function() self.keepworking = false return true end, "Keep Working",
                    DoAction(self.inst, function()
                        local act = FindAnyEntityToWorkActionsOn(self.inst)
                        if act then
                            if self.inst.sg:HasStateTag("pre"..string.lower(act.action.id)) then 
                                self.keepworking = true 
                            else 
                                return act 
                            end
                        end
                    end)),
                FailIfSuccessDecorator(ConditionWaitNode(function() return not self.keepworking end, "Repeating action")),

                -- 5.2 Harvest and Pickup Actions
                DoAction(self.inst, FindPlantToPick, "Harvest Plants", true),
                DoAction(self.inst, FindResourceToPickup, "Pickup Resources", true),
            }, 0.25)),

        -- [ SECTION 6: INVENTORY MANAGEMENT ] -----------------
        DoAction(self.inst, FindChestToStoreItem, "Store Items", true),
        DoAction(self.inst, GiveResourcesToLeader, "Give Resources", true),

        -- [ SECTION 7: FOLLOW & IDLE ] ------------------------
        -- Lowest priority: If there's nothing else to do, just hang around the leader
        SequenceNode{
            ConditionWaitNode(function()
                return self.inst._lastruntime == nil or (GetTime() - self.inst._lastruntime > RUN_AFTER_KITE_DELAY)
            end, "Wait after kiting"),
            Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST, true),
        },
        FaceEntity(self.inst, GetFaceLeaderFn, KeepFaceLeaderFn),
        CreateWanderer(self, 6),

    }, 0.25)

    -- Initialize the Behavior Tree
    self.bt = BT(self.inst, root)

    -- =====================================================
    -- 3. ANTI-STUCK WATCHDOG TASK (Runs alongside the brain)
    -- =====================================================
    self.inst:DoPeriodicTask(1, function(inst)
        local current_action = inst:GetBufferedAction()
        
        -- Check if Wilto is trying to interact with an object (Pickup, Chop, Mine)
        if current_action ~= nil and current_action.target ~= nil and 
           (current_action.action == ACTIONS.PICKUP or current_action.action == ACTIONS.CHOP or current_action.action == ACTIONS.MINE) then
            
            local current_pos = inst:GetPosition()
            
            -- If Wilto has moved less than 0.5 units in 1 second, he is physically stuck
            if inst._last_watchdog_pos ~= nil and inst._last_watchdog_pos:DistSq(current_pos) < 0.25 then
                inst._watchdog_stuck_ticks = (inst._watchdog_stuck_ticks or 0) + 1
                
                if inst._watchdog_stuck_ticks >= 3 then -- Stuck for 3 seconds
                    -- 1. Blacklist the unreachable target for 60 seconds
                    if inst._blacklisted_items == nil then
                        inst._blacklisted_items = {}
                    end
                    inst._blacklisted_items[current_action.target] = GetTime() + 60
                    
                    -- 2. Force drop the action and stop physical movement
                    inst:ClearBufferedAction()
                    inst.components.locomotor:Stop()
                    
                    -- 3. Reset the behavior tree to evaluate new priorities
                    if self.bt ~= nil then
                        self.bt:Reset()
                    end
                    
                    -- Reset watchdog trackers
                    inst._watchdog_stuck_ticks = 0
                    inst._last_watchdog_pos = nil
                end
            else
                -- Entity is moving fine towards the target
                inst._watchdog_stuck_ticks = 0
                inst._last_watchdog_pos = current_pos
            end
        else
            -- No active interaction action, reset watchdog
            inst._watchdog_stuck_ticks = 0
            inst._last_watchdog_pos = nil
        end
    end)
end

return WiltolionWiltoBrain