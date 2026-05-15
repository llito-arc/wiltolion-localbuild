local assets = {
    Asset("ANIM", "anim/wilto.zip"),
}

local prefabs = {}

local brain = require("brains/wiltolionwilto_brain")

-- =========================================================
-- SISTEMA MÉDICO Y TOKENS DE CURACIÓN
-- =========================================================

-- 1. AQUÍ DECIDES CUÁNTOS PUNTOS DA CADA OBJETO
-- Añade o quita lo que quieras (el nombre interno de DST, ej: "jellybean" = 50)
-- =========================================================
-- 1. AQUÍ DECIDES CUÁNTOS PUNTOS DA CADA OBJETO
-- =========================================================
local HEALING_VALUES = {
    -- [ Los que ya tenías ] --
    honey = 5,
    butterflywings = 5,
    bluecap = 10,
    spidergland = 15,
    mosquito_sack = 20,
    healingsalve = 30,
    bandage = 50, 
    
    -- [ Plantas y Básicos (1 punto) ] --
    petals = 5,             -- Flores normales.
    foliage = 5,            -- Helechos de las cuevas.
    lightbulb = 3,          -- Bioluminiscencia. ¡Para un ser de luz/sol es alimento puro!
    kelp = 5,               -- Algas marinas (superalimento).

    -- [ Inusuales y Restos de Monstruos (2 a 5 puntos) ] --
    moon_tree_blossom = 10,  -- Flores lunares.
    batwing = 5,            -- Las alas de murciélago se comen en el juego base para curar un poco.
    -- [ Objetos Raros / Médicos Fuertes (10 a 20 puntos) ] --
    lifeinjector = 60,      -- Booster shot. Medicina de muy alto nivel. (Vale por 1 curación instantánea).
    
    -- [ Épicos / Jefes (30+ puntos) ] --
    royal_jelly = 60,       -- Jalea Real (Reina Abeja). 
    jellybean = 120,         -- Gominolas curativas.
}

-- 2. AQUÍ CONFIGURAS LOS LÍMITES
local POINTS_PER_TOKEN = 30 -- ¿Cuántos puntos cuesta conseguir 1 curación?
local MAX_TOKENS = 20        -- ¿Cuántas curaciones máximas puede guardar a la vez?

local function ProcessHealingItems(inst)
    if not inst.components.inventory then return end
    
    -- Si ya está lleno, ni se molesta en mirar la mochila
    if (inst.wilto_heal_tokens or 0) >= MAX_TOKENS then return end

    local inv = inst.components.inventory
    local points_gained_this_tick = 0
    
    -- PASO A: Recorrer el inventario buscando objetos médicos
    for k, v in pairs(inv.itemslots) do
        if v and HEALING_VALUES[v.prefab] then
            local item_value = HEALING_VALUES[v.prefab]
            
            -- PASO B: Consumir el stack UNO POR UNO mientras necesite tokens
            while v and v:IsValid() and (inst.wilto_heal_tokens or 0) < MAX_TOKENS do
                
                -- Sumamos los puntos de ese objeto individual
                points_gained_this_tick = points_gained_this_tick + item_value
                inst.wilto_heal_points = (inst.wilto_heal_points or 0) + item_value
                
                -- Convertimos los puntos acumulados en Tokens
                while inst.wilto_heal_points >= POINTS_PER_TOKEN do
                    inst.wilto_heal_points = inst.wilto_heal_points - POINTS_PER_TOKEN
                    inst.wilto_heal_tokens = (inst.wilto_heal_tokens or 0) + 1
                end
                
                -- Le quitamos 1 unidad al stack. Si se acaba, borramos el objeto.
                if v.components.stackable and v.components.stackable:IsStack() then
                    local single_item = v.components.stackable:Get()
                    single_item:Remove()
                else
                    inv:RemoveItem(v)
                    v:Remove()
                    break -- Stack terminado, pasamos al siguiente slot
                end
            end
        end
        
        -- Si en medio del proceso alcanzamos el límite máximo, rompemos la búsqueda
        if (inst.wilto_heal_tokens or 0) >= MAX_TOKENS then
            inst.wilto_heal_points = 0 -- Limpiamos puntos sobrantes para ser limpios
            break
        end
    end
    
    if points_gained_this_tick > 0 and inst.components.talker then
        inst.components.talker:Say("I'm saving this to patch you up!")
    end
end
-- =========================================================
-- INTELIGENCIA DE COMBATE Y HERRAMIENTAS
-- =========================================================

-- Evalúa si Wilto debe huir para sobrevivir
local function ShouldFleeForSurvival(inst)
    if not inst.components.health or inst.components.health:IsDead() then return false end
    
    local hp_percent = inst.components.health:GetPercent()
    local has_armor = false
    
    -- Revisamos si lleva puesto algo que lo proteja (Casco o Armadura)
    if inst.components.inventory then
        local body = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
        local head = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if (body and body.components.armor) or (head and head.components.armor) then
            has_armor = true
        end
    end

    -- UMBRALES DE PÁNICO:
    -- Si tiene armadura, aguanta hasta el 15% de vida.
    -- Si no tiene armadura, entra en pánico al 30% de vida.
    if (has_armor and hp_percent <= 0.15) or (not has_armor and hp_percent <= 0.30) then
        -- Opcional: Que pida ayuda
        if inst.components.talker and math.random() < 0.05 then
            inst.components.talker:Say("I can't take much more of this!")
        end
        return true
    end
    
    return false
end

local function wiltoretargetfn(inst)
    if inst.sg:HasStateTag("dancing") then return nil end
    
    -- CORRECCIÓN: Ahora solo se rinde si el botón está explícitamente en false
    if inst.wilto_toggles ~= nil and inst.wilto_toggles.fight == false then return nil end
    
    local leader = inst.components.follower and inst.components.follower:GetLeader()
    if not leader then return nil end

    local target = leader.components.combat and leader.components.combat.target
    if target ~= nil and target ~= leader and not target:HasTag("player") and inst.components.combat:CanTarget(target) then
        return target
    end

    return nil
end

local function wiltokeeptargetfn(inst, target)
    -- Si le ordenaste no pelear
    if inst.wilto_toggles ~= nil and inst.wilto_toggles.fight == false then return false end
    
    -- NUEVA BARRERA: Si se está muriendo, suelta al objetivo
    if ShouldFleeForSurvival(inst) then return false end
    
    return inst.components.combat:CanTarget(target) and not inst.sg:HasStateTag("dancing")
end

-- Clasifica los objetos para saber qué son
local function CategorizeItem(item)
    if not item or not item.components.equippable then return nil end
    if item.components.equippable.equipslot == EQUIPSLOTS.HEAD then return "helmet" end
    if item.components.equippable.equipslot == EQUIPSLOTS.BODY then return "armor" end
    if item.components.tool then
        if item.components.tool:CanDoAction(ACTIONS.CHOP) then return "axe" end
        if item.components.tool:CanDoAction(ACTIONS.MINE) then return "pickaxe" end
        if item.components.tool:CanDoAction(ACTIONS.DIG) then return "shovel" end
    end
    if item.components.weapon then return "weapon" end
    return "other"
end


-- =========================================================
-- SMART EQUIPMENT SYSTEM
-- =========================================================

-- Evaluates the raw power of an item based on Klei's native stats
local function GetItemScore(item)
    if not item or not item:IsValid() then return 0 end
    
    -- Weapon score is driven by damage
    if item.components.weapon ~= nil then
        local dmg = item.components.weapon.damage or 0
        if type(dmg) == "function" then dmg = 15 end -- Approximate dynamic damage
        -- Penalize tools slightly so pure weapons are preferred
        if item.components.tool ~= nil then dmg = dmg - 10 end 
        return dmg
    end
    
    -- Armor score is driven by absorption percentage (0.0 to 1.0)
    if item.components.armor ~= nil then
        return (item.components.armor.absorb_percent or 0) * 100
    end
    
    return 0
end

-- Scans the entire inventory and equips the items with the highest score
-- =========================================================
-- SMART EQUIPMENT SYSTEM (Context Aware)
-- =========================================================
local function EquipBestGear(inst)
    local inv = inst.components.inventory
    if not inv then return end

    local current_weapon = inv:GetEquippedItem(EQUIPSLOTS.HANDS)
    local current_armor = inv:GetEquippedItem(EQUIPSLOTS.BODY)
    local current_helmet = inv:GetEquippedItem(EQUIPSLOTS.HEAD)

    local best_weapon = current_weapon
    local best_armor = current_armor
    local best_helmet = current_helmet

    -- CONTEXT CONTROLLER: Is Wilto currently engaged in combat?
    local in_combat = inst.components.combat ~= nil and inst.components.combat.target ~= nil

    -- Scan inventory for the best replacement
    for k, item in pairs(inv.itemslots) do
        if item:IsValid() and item.components.equippable ~= nil then
            local slot = item.components.equippable.equipslot
            local score = GetItemScore(item)

            if slot == EQUIPSLOTS.BODY then
                if score > GetItemScore(best_armor) then
                    best_armor = item
                end
            elseif slot == EQUIPSLOTS.HEAD then
                if score > GetItemScore(best_helmet) then
                    best_helmet = item
                end
            elseif slot == EQUIPSLOTS.HANDS then
                if in_combat then
                    -- COMBAT MODE: Actively override any tool for the highest damage weapon
                    if score > GetItemScore(best_weapon) then
                        best_weapon = item
                    end
                else
                    -- PEACEFUL MODE: Respect currently equipped tools (like axes/pickaxes).
                    -- Only force equip a weapon if his hands are completely empty.
                    if current_weapon == nil and score > GetItemScore(best_weapon) then
                        best_weapon = item
                    end
                end
            end
        end
    end

    -- Perform the equip only if a better (or new) item was found
    if best_weapon and best_weapon ~= current_weapon then 
        inv:Equip(best_weapon) 
    end
    if best_armor and best_armor ~= current_armor then 
        inv:Equip(best_armor) 
    end
    if best_helmet and best_helmet ~= current_helmet then 
        inv:Equip(best_helmet) 
    end
end

-- =========================================================
-- CREACIÓN DEL NPC PRINCIPAL
-- =========================================================
local function wiltofn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.net_heal_tokens = net_smallbyte(inst.GUID, "wilto.heal_tokens")
    inst.net_heal_points = net_smallbyte(inst.GUID, "wilto.heal_points")

    MakeCharacterPhysics(inst, 50, 0.5)
    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBuild("wilto") 
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:AddOverrideBuild("wurt_peruse")

    inst.AnimState:Hide("ARM_carry")
    inst.AnimState:Hide("HAT")
    inst.AnimState:Hide("HAIR_HAT")

    inst:AddTag("character")
    inst:AddTag("trader") 
    inst:AddTag("alltrader") 
    inst:AddTag("wilto_companion") -- Etiqueta para reconocerlo al hacer click
    inst:AddTag("companion") 
    inst:AddTag("NOBLOCK")
    
    -- MEMORIA BASE
    inst.wilto_toggles = { pickup = true, chop = true, mine = true, dig = true, fight = true, give = true, harvest = true }
    inst.wilto_heal_points = 0
    inst.wilto_heal_tokens = 0

    -- GUARDAR MEMORIA EN EL MUNDO
    inst.OnSave = function(inst, data)
        if inst.wilto_toggles ~= nil then data.wilto_toggles = inst.wilto_toggles end
        data.wilto_heal_points = inst.wilto_heal_points
        data.wilto_heal_tokens = inst.wilto_heal_tokens
    end

    -- CARGAR MEMORIA AL ENTRAR AL MUNDO
    inst.OnLoad = function(inst, data)
        if data ~= nil then 
            if data.wilto_toggles ~= nil then inst.wilto_toggles = data.wilto_toggles end
            inst.wilto_heal_points = data.wilto_heal_points or 0
            inst.wilto_heal_tokens = data.wilto_heal_tokens or 0
        end
    end

    -- Tarea periódica: Cada 3 segundos revisa su inventario para hacer medicinas
    inst:DoPeriodicTask(3, ProcessHealingItems)
    
    inst:AddComponent("talker")
    inst.components.talker.fontsize = 35
    inst.components.talker.font = TALKINGFONT -- Sin el punto al final
    inst.components.talker.offset = Vector3(0, -400, 0)
    inst.components.talker:MakeChatter() -- ¡VITAL para NPCs en multijugador!
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("locomotor")
    inst.components.locomotor.runspeed = 8.5
    inst.components.locomotor.walkspeed = 5.5
    
    -- [NUEVO] Permite que el motor busque caminos hacia plataformas (barcos)
    inst.components.locomotor:SetAllowPlatformHopping(true)

    -- [NUEVO] El componente que maneja la física y animación de saltar
    inst:AddComponent("embarker")
    inst.components.embarker.embark_speed = inst.components.locomotor.runspeed
    inst.components.embarker.antigravity = true -- Evita que se caiga al agua durante el salto

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(120)
    inst.components.health:StartRegen(3, 10)
    MakeMediumBurnableCharacter(inst, "torso")
    MakeMediumFreezableCharacter(inst, "torso")
    inst.components.freezable:SetResistance(2) -- Requiere el doble de golpes gélidos para congelarlo
    inst.components.freezable:SetDefaultWearOffTime(1) -- Si lo congelan, se derrite en 1 segundo

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(15)
    inst.components.combat:SetAttackPeriod(0.50)
    inst.components.combat:SetRetargetFunction(1, wiltoretargetfn)
    inst.components.combat:SetKeepTargetFunction(wiltokeeptargetfn)
    inst.ShouldFleeForSurvival = ShouldFleeForSurvival
    
    -- =========================================================
    -- COMBAT INTERCEPTOR: TANKING, PERFECT DODGE & ANTI-STUNLOCK
    -- =========================================================
    local old_GetAttacked = inst.components.combat.GetAttacked
    
    inst.components.combat.GetAttacked = function(self, attacker, damage, weapon, stimuli)
        local reduced_damage = damage * 0.5 
        local time_now = GetTime()

        -- STUNLOCK BREAKER: Check if Wilto is already in pain/busy
        if inst.sg:HasStateTag("hit") or inst.sg:HasStateTag("busy") then
            inst._stunlock_hits = (inst._stunlock_hits or 0) + 1
        else
            inst._stunlock_hits = 0
        end

        -- If Wilto receives a second hit while already stunned, force an emergency breakout
        if inst._stunlock_hits >= 2 then
            inst._stunlock_hits = 0
            -- Pass the attacker to the StateGraph so Wilto knows which direction to jump away from
            inst.sg:GoToState("perfect_dodge", attacker)
            return true -- Negate this hit's damage completely
        end

        -- REGULAR PERFECT DODGE (25% chance, 5s cooldown, only when not busy)
        if not inst.sg:HasStateTag("busy") and 
           (inst._last_dodge_time == nil or (time_now - inst._last_dodge_time > 2)) then
            
            if math.random() < 0.25 then
                inst._last_dodge_time = time_now
                inst.sg:GoToState("perfect_dodge", attacker)
                return true 
            end
        end
        return old_GetAttacked(self, attacker, reduced_damage, weapon, stimuli)
    end

    inst:AddComponent("follower")
    inst.components.follower:KeepLeaderOnAttacked()
    inst.components.follower.keepdeadleader = true

    inst:AddComponent("inventory")
    inst.components.inventory.maxslots = 35

    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true -- ¡LA LÍNEA MÁGICA DE WX!
    inst.components.trader.deleteitemonaccept = false
    inst.components.trader:SetAcceptTest(function(inst, item, giver)
        -- Evita objetos que rompen el juego (como el Chester Bone o el Star-sky)
        if item.components.inventoryitem and item.components.inventoryitem.cangoincontainer == false then
            return false
        end
        -- Al devolver 'true', Wilto aceptará CUALQUIER objeto que le des en mano
        return true
    end)
    inst.components.trader.onaccept = function(inst, giver, item)
        if inst.components.talker then
            inst.components.talker:Say("I'll put this to good use...!")
        end
        -- Nota: No forzamos el equipamiento aquí porque tu evento "gotnewitem" 
        -- más abajo ya hace un trabajo perfecto organizando el inventario.
    end

    inst:AddComponent("inspectable")
    -- =========================================================
    -- NOMBRE Y DIÁLOGOS
    -- =========================================================
    inst:AddComponent("named")
    inst.components.named.possiblenames = { "Wilto" } -- Pon aquí el nombre que quieras


    -- Ignorador temporal para no recoger cosas que acaba de tirar
    inst._ignored_items = {}
    setmetatable(inst._ignored_items, {__mode = "k"})

    -- When entering combat, evaluate and draw the best weapon available
    inst:ListenForEvent("newcombattarget", function(inst, data)
        if inst.wilto_toggles ~= nil and inst.wilto_toggles.fight == false then
            inst:DoTaskInTime(0, function() 
                if inst.components.combat then inst.components.combat:DropTarget() end 
            end)
            return
        end
        
        if data.target ~= nil then
            EquipBestGear(inst)
        end
    end)

    -- Smart inventory management when receiving items
    inst:ListenForEvent("gotnewitem", function(inst, data)
        if data.item ~= nil and data.item.components.equippable ~= nil then
            inst:DoTaskInTime(0, function()
                if not (data.item:IsValid() and data.item.components.inventoryitem and data.item.components.inventoryitem.owner == inst) then
                    return
                end
                
                -- Reject items that cannot go in containers (like Chester's Eyebone)
                if data.item.components.inventoryitem.cangoincontainer == false then
                    inst.components.inventory:DropItem(data.item, true, true)
                    return
                end

                -- Trigger the smart equip logic to compare the new item with the current gear
                EquipBestGear(inst)
                inst.SoundEmitter:PlaySound("dontstarve/characters/wilson/equip_item")
            end)
        end
    end)

    -- =========================================================
    -- REPLACEMENT LOGIC (When items break)
    -- =========================================================

    -- Triggered specifically when an armor piece reaches 0 condition and shatters
    inst:ListenForEvent("armorbroke", function(inst)
        inst:DoTaskInTime(0.2, EquipBestGear)
    end)

    -- Triggered specifically when a weapon reaches 0 condition and breaks
    inst:ListenForEvent("weaponbroke", function(inst)
        inst:DoTaskInTime(0.2, EquipBestGear)
    end)

    -- Extra safety: Check equipment when performing an attack or working
    -- This ensures he never swings with bare hands if he has a weapon available
    local function CheckGearBeforeAction(inst)
        local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if weapon == nil then
            EquipBestGear(inst)
        end
    end

    inst:ListenForEvent("onattackother", CheckGearBeforeAction)
    inst:ListenForEvent("working", CheckGearBeforeAction)

    inst:ListenForEvent("death", function(inst)
        -- 1. Suelta todo su equipo
        if inst.components.inventory ~= nil then
            inst.components.inventory:DropEverything(true)
        end
        
        -- 2. IMPACTO EMOCIONAL: Wiltolion pierde el 50% de su cordura actual
        local leader = inst.components.follower:GetLeader()
        if leader ~= nil and leader.components.sanity ~= nil then
            local current_sanity = leader.components.sanity.current
            
            -- Le restamos exactamente la mitad de lo que le quede
            leader.components.sanity:DoDelta(-(current_sanity * 0.5))
            
            -- ¡Un pequeño grito de dolor de Wiltolion para darle dramatismo!
            if leader.components.talker ~= nil then
                leader.components.talker:Say("I really didn't want to see that at all!")
            end
        end
    end)

-- =========================================================
    -- VÍNCULO VITAL (Simple y Letal)
    -- =========================================================
    inst:ListenForEvent("startfollowing", function(inst, data)
        -- Limpieza de seguridad por si cambia de líder
        if inst._on_leader_despawn ~= nil and inst._old_leader ~= nil then
            inst:RemoveEventCallback("ms_playerreroll", inst._on_leader_despawn, inst._old_leader)
            inst:RemoveEventCallback("ms_playerdespawn", inst._on_leader_despawn, inst._old_leader)
            inst._on_leader_despawn = nil
        end
        
        if data.leader ~= nil then
            inst._old_leader = data.leader
            
            -- La acción: Matarlo incondicionalmente
            inst._on_leader_despawn = function()
                if inst.components.health and not inst.components.health:IsDead() then
                    if inst.components.talker then inst.components.talker:Say("Goodbye...!") end
                    inst.components.health:Kill()
                end
            end
            
            -- 1. Disparador: Usar el Portal Celestial para cambiar de personaje
            inst:ListenForEvent("ms_playerreroll", inst._on_leader_despawn, data.leader)
            
            -- 2. Disparador: Forzar el despawn (Comando c_despawn)
            inst:ListenForEvent("ms_playerdespawn", inst._on_leader_despawn, data.leader)
        end
    end)

    inst:DoPeriodicTask(20 + math.random() * 20, function()
        -- Solo habla si no está en combate y no está haciendo una acción
        if not inst.sg:HasStateTag("busy") and not inst.components.combat:HasTarget() then
            -- Solo habla con un 30% de probabilidad para no ser pesado
            if math.random() < 0.3 then
                local ambient_lines = {
                    -- Exploración y timidez
                    "This place is... quite big.",
                    "Are you sure we're going the right way?",
                    "It's a bit scary out here, but I trust you.",
                    "Do you think it will rain?",
                    "What was that noise...?",
                    "I hope we don't run into anything too big.",
                    "Is it getting darker, or is it just me?",
                    
                    -- Lealtad y cariño hacia el jugador
                    "I'll follow your lead.",
                    "I'm glad I'm not alone here.",
                    "Your light makes me feel safe.",
                    "I'll try my best to protect you.",
                    "You don't have to carry all the weight yourself, you know.",
                    
                    -- Melancolía y su naturaleza como "Eco"
                    "Do you ever feel like you've been here before?",
                    "Sometimes I feel like I'm forgetting something important...",
                    "It's peaceful when it's quiet like this.",
                    "The world is so strange... but it's okay if we are together.",
                }
                if inst.components.talker then
                    inst.components.talker:Say(ambient_lines[math.random(#ambient_lines)])
                end
            end
        end
    end)

    inst:SetBrain(brain)
    inst:SetStateGraph("SGwiltolionwilto")

    return inst
end

-- =========================================================
-- CONSTRUCTOR Y REEMBOLSO DINÁMICO (Seguro para Servidores)
-- =========================================================
local function onwiltobuilt(inst, builder)
    
    -- 1. BUSCAMOS A WILTO A MANO PARA EVITAR CRASHEOS
    local has_wilto = false
    if builder.components.petleash ~= nil then
        local pets = builder.components.petleash:GetPets()
        if pets ~= nil then
            -- Revisamos una por una las mascotas que te siguen
            for pet, _ in pairs(pets) do
                if pet.prefab == "wiltolion_wilto" then
                    has_wilto = true
                    break
                end
            end
        end
    end

    -- 2. SI YA EXISTE, REEMBOLSAMOS MATERIALES
    if has_wilto then
        if builder.components.talker then
            builder.components.talker:Say("He is already here with me.")
        end
        
        local recipe = GetValidRecipe("wiltolion_wilto_builder")
        
        if recipe ~= nil and builder.components.inventory ~= nil then
            for i, v in ipairs(recipe.ingredients) do
                if v.amount > 0 and type(v.type) == "string" then
                    local item = SpawnPrefab(v.type)
                    if item ~= nil then
                        if item.components.stackable ~= nil then
                            item.components.stackable:SetStackSize(v.amount)
                            builder.components.inventory:GiveItem(item, nil, builder:GetPosition())
                        else
                            builder.components.inventory:GiveItem(item, nil, builder:GetPosition())
                            if v.amount > 1 then
                                for k = 2, v.amount do
                                    local extra_item = SpawnPrefab(v.type)
                                    if extra_item ~= nil then
                                        builder.components.inventory:GiveItem(extra_item, nil, builder:GetPosition())
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        
        inst:Remove()
        return
    end

    -- 3. SI NO EXISTE, LO INVOCAMOS NORMALMENTE
    local theta = math.random() * 2 * PI
    local pt = builder:GetPosition()
    local offset = FindWalkableOffset(pt, theta, 3, 12, true, true)
    
    if offset ~= nil then
        pt.x = pt.x + offset.x
        pt.z = pt.z + offset.z
    end

    if builder.components.petleash ~= nil then
        local npc = builder.components.petleash:SpawnPetAt(pt.x, 0, pt.z, "wiltolion_wilto")
        
        if npc then
            local fx1 = SpawnPrefab("halloween_firepuff_1")
            fx1.Transform:SetPosition(pt.x, 0, pt.z)
            fx1.Transform:SetScale(2, 2, 2)
            
            local fx2 = SpawnPrefab("halloween_firepuff_3")
            fx2.Transform:SetPosition(pt.x, 0.5, pt.z)
            fx2.Transform:SetScale(1.8, 1.8, 1.8)
            
            npc.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
            npc.components.follower:SetLeader(builder)
        end
    end
    
    inst:Remove()
end

local function wiltobuilderfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst:AddTag("CLASSIFIED")
    inst.persists = false
    inst:DoTaskInTime(0, inst.Remove)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.OnBuiltFn = onwiltobuilt
    return inst
end

return Prefab("wiltolion_wilto_builder", wiltobuilderfn), 
       Prefab("wiltolion_wilto", wiltofn, assets, prefabs)