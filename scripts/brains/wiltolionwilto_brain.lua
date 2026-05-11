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

local function FindAnyEntityToWorkActionsOn(inst)
    if inst.sg:HasStateTag("busy") then return nil end
    local leader = GetLeader(inst)
    if leader == nil then return nil end

    -- EL FIX DEL "ROOMBA CIEGO"
    -- En lugar de usar la variable oculta de Maxwell, forzamos un escaneo enorme (25 unidades)
    local x, y, z = inst.Transform:GetWorldPosition()
    
    -- 1. Busca árboles en un radio brutal de 25 metros alrededor del propio Wilto
    local target = FilterAnyWorkableTargets(TheSim:FindEntities(x, y, z, 25, nil, TOWORK_CANT_TAGS, ANY_TOWORK_MUSTONE_TAGS), inst)
    
    -- 2. Si su zona está limpia, echa un vistazo alrededor tuyo (del Líder) por si acaso
    if target == nil then
        local lx, ly, lz = leader.Transform:GetWorldPosition()
        target = FilterAnyWorkableTargets(TheSim:FindEntities(lx, ly, lz, 25, nil, TOWORK_CANT_TAGS, ANY_TOWORK_MUSTONE_TAGS), inst)
    end
    
    local action, tool = nil, nil
    if target ~= nil then
        action, tool = PickValidActionFrom(target, inst)
    end
    
    return action ~= nil and BufferedAction(inst, target, action, tool) or nil
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

FindResourceToPickup = function(inst)
    if inst.sg:HasStateTag("busy") then return nil end
    -- NUEVO: Comprueba el botón
    if inst.wilto_toggles ~= nil and not inst.wilto_toggles.pickup then return nil end

    local item_count = 0
    for k, v in pairs(inst.components.inventory.itemslots) do 
        item_count = item_count + 1 
    end
    -- Ahora dejará de recoger basura solo cuando llegue a 40 stacks
    if item_count >= 25 then return nil end
    
    local leader = GetLeader(inst)
    if not leader then return nil end
    
    local leader_pos = leader:GetPosition()
    local ents = TheSim:FindEntities(leader_pos.x, leader_pos.y, leader_pos.z, 15, { "_inventoryitem" }, { "INLIMBO", "NOCLICK", "catchable", "fire", "irreplaceable", "nosteal", "heavy" })
    
    local ignorethese = leader._brain_pickup_ignorethese
    
    for _, item in ipairs(ents) do
        if item.components.inventoryitem and item.components.inventoryitem.canbepickedup then
            
            -- ¡BARRERA ESPECÍFICA ANTI-MOCHILAS AQUÍ TAMBIÉN!
            if not item:HasTag("backpack") and item.components.container == nil then
            
                if not (item.components.inventoryitem.CanBePickedUpBy and not item.components.inventoryitem:CanBePickedUpBy(inst)) then
                    if item.components.equippable == nil and not (ignorethese and ignorethese[item]) then
                        return BufferedAction(inst, item, ACTIONS.PICKUP)
                    end
                end
                
            end
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
local PICK_CANT_TAGS = { "INLIMBO", "NOCLICK", "fire", "smolder", "catchable", "thorny", "flower", "crop" }

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
-- CEREBRO PRINCIPAL
-- =========================================================
function WiltolionWiltoBrain:OnStart()
    local watch_game = WhileNode( function() return ShouldWatchMinigame(self.inst) end, "Watching Game",
        PriorityNode({ Follow(self.inst, WatchingMinigame, 0, 0, 0), RunAway(self.inst, "minigame_participator", 5, 7), FaceEntity(self.inst, WatchingMinigame, WatchingMinigame) }, 0.25))
    
    local dance_party = WhileNode(function() return ShouldDanceParty(self.inst) end, "Dance Party",
        PriorityNode({ Leash(self.inst, GetLeaderPos, KEEP_DANCING_DIST, KEEP_DANCING_DIST), ActionNode(function() DanceParty(self.inst) end) }, 0.25))

    local avoid_explosions = RunAway(self.inst, { fn = ShouldAvoidExplosive, tags = { "explosive" }, notags = { "INLIMBO" } }, AVOID_EXPLOSIVE_DIST, AVOID_EXPLOSIVE_DIST)

    local leader = GetLeader(self.inst)
    local ignorethese = leader ~= nil and leader._brain_pickup_ignorethese or {}
    if leader ~= nil then leader._brain_pickup_ignorethese = ignorethese end

    local root = PriorityNode({
        dance_party,
        watch_game,
        avoid_explosions,
        WhileNode(function() 
            -- Guardamos el objetivo actual en una variable temporal del objeto
            self.inst.wilto_target_to_heal = GetHealTarget(self.inst)
            return self.inst.wilto_target_to_heal ~= nil 
        end, "Needs Healing",
            PriorityNode({
                -- Si está cerca del herido, lanza la animación pasando el objetivo
                WhileNode(function() return self.inst:IsNear(self.inst.wilto_target_to_heal, 2.5) end, "Do Heal",
                    ActionNode(function()
                        if not self.inst.sg:HasStateTag("busy") then
                            -- IMPORTANTE: Pasamos el target en el evento
                            self.inst:PushEvent("do_heal_leader", { target = self.inst.wilto_target_to_heal })
                        end
                    end)),
                -- Wilto ahora sigue al herido, no solo al líder
                Follow(self.inst, function() return self.inst.wilto_target_to_heal end, 0, 1, 2)
            }, 0.25)
        ),

        RunAway(self.inst, { fn = IsDanger, tags = {"_combat", "_health"}, notags = {"INLIMBO", "player"} }, 10, 15),
        WhileNode(function() return self.inst.components.burnable and self.inst.components.burnable:IsBurning() end, "OnFire", Panic(self.inst)),
        
        -- ¡EL SÚPER NODO DE ÓRDENES LIMPIO! (Ya no depende de wilto_state)
        -- 1. SUPERVIVENCIA
        -- DoAction(self.inst, FindMissingEquipmentToPickup, "Pickup Missing Equipment", true), YA NO ES NECESARIO

        -- 2. KLEI SYNCHRONIZED COMBAT (Kite + Attack)
        WhileNode(function() return IsLeaderAttacking(self.inst) end, "is leader attacking",
            ChaseAndAttack(self.inst)
        ),

        WhileNode(function() return not IsLeaderAttacking(self.inst) and IsLeaderMoving(self.inst) and LeaderInRangeOfTarget(self.inst) end, "is leader not attacking",
            -- Reduced distances: Flees if enemy is within 3 units, stops fleeing at 5 units
            RunAway(self.inst, RUNAWAY_PARAM, 3, 5)
        ),

        -- 3. TRABAJAR Y RECOGER
        WhileNode(
            function() return not self.inst.sg:HasStateTag("recoil") end,
            "<busy state guard>",
            PriorityNode({
                WhileNode(
                    function() self.keepworking = false return true end,
                    "Keep Working",
                    DoAction(self.inst, function()
                        local act = FindAnyEntityToWorkActionsOn(self.inst)
                        if act then
                            if self.inst.sg:HasStateTag("pre"..string.lower(act.action.id)) then self.keepworking = true else return act end
                        end
                    end)),
                FailIfSuccessDecorator(ConditionWaitNode(function() return not self.keepworking end, "Repeating action")),

                -- ¡AQUÍ ESTÁ NUESTRA NUEVA ORDEN!
                DoAction(self.inst, FindPlantToPick, "Harvest Plants", true),

                DoAction(self.inst, FindResourceToPickup, "Pickup Resources", true),
            }, 0.25)),

        -- 4. DAR RECURSOS AL LÍDER
        DoAction(self.inst, GiveResourcesToLeader, "Give Resources", true),

        -- 5. ESTADOS DE SEGUIMIENTO E INACTIVIDAD
        SequenceNode{
            ConditionWaitNode(function()
                return self.inst._lastruntime == nil or (GetTime() - self.inst._lastruntime > RUN_AFTER_KITE_DELAY)
            end, "Wait after kiting"),
            Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST, true),
        },
        FaceEntity(self.inst, GetFaceLeaderFn, KeepFaceLeaderFn),
        CreateWanderer(self, 6),
    }, 0.25)

    self.bt = BT(self.inst, root)
end

return WiltolionWiltoBrain