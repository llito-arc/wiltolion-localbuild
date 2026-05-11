local assets = {
    -- Mientras haces tus propios gráficos, usaremos los de la abeja base
    Asset("ANIM", "anim/wiltolion_buddy.zip"),
}

-- El StateGraph de la abeja (SGbee) exige que existan estas rutas de sonido o crasheará
local buddysounds = {
    takeoff = "dontstarve/bee/bee_takeoff",
    attack = "dontstarve/bee/bee_attack",
    buzz = "dontstarve/bee/bee_fly_LP",
    hit = "dontstarve/bee/bee_hurt",
    death = "dontstarve/bee/bee_death",
}

-- Función obligatoria para que el SGbee pueda encender/apagar el zumbido
local function EnableBuzz(inst, enable)
    if enable then
        if not inst.buzzing then
            inst.buzzing = true
            if not inst.SoundEmitter:PlayingSound("buzz") then
                inst.SoundEmitter:PlaySound(inst.sounds.buzz, "buzz")
            end
        end
    elseif inst.buzzing then
        inst.buzzing = false
        inst.SoundEmitter:KillSound("buzz")
    end
end
-- Lista de enemigos a los que la mosca atacará sin que se lo ordenes
local ANNOYING_ENEMIES = {
    perd = true,                  -- Pavos roba-bayas (Gobblers)
    buzzard = true,               -- Buitres
    
    -- Sombras que curan al Fuelweaver (Klei usa varias variantes)
    stalker_minion = true,        
    stalker_minion1 = true,       
    stalker_minion2 = true,       
    
    mossling = true,              -- Crías del Moose/Goose
    bat = true,                   -- Murciélagos (Batilisks)
    slurper = true,               -- Roba-cordura de las ruinas
}

local FORMATION_MAX_SPEED = 10.5
local FORMATION_RADIUS = 3.5 -- La distancia a la que orbitan
local FORMATION_ROTATION_SPEED = 0.5

local function OnUpdate(inst, dt)
    -- Seguridad ante todo
    if not inst:IsValid() then return end

    local leader = inst.components.follower and inst.components.follower:GetLeader()
    
    -- Si hay líder, el cerebro funciona y no estamos parados
    if leader and leader:IsValid() and inst.brain and not inst.brain.stopped then
        
        -- [NUEVO] ¿La mosca tiene a alguien en la mira?
        local has_target = inst.components.combat and inst.components.combat:HasTarget()
        
        -- Si la mosca está golpeando, ocupada, o PERSIGUIENDO un objetivo, devolvemos el control a la IA
        if inst.sg:HasStateTag("attack") or inst.sg:HasStateTag("busy") or has_target then
            inst.components.locomotor.directdrive = false
            
            -- [NUEVO] ¡Devolverles su velocidad normal para que persigan rápido!
            inst.components.locomotor.walkspeed = 7
            
            return
        end
        -- Si no hay enemigos, tomamos el control para la órbita bonita
        inst.components.locomotor.directdrive = true

        -- Averiguar cuántas moscas hay y cuál es el índice de ESTA mosca para separarlas
        local index = 0
        local maxpets = 1
        if leader.components.petleash then
            local pets = leader.components.petleash:GetPets()
            maxpets = 0
            for pet, _ in pairs(pets) do
                if pet:HasTag("wiltolion_buddy") then
                    maxpets = maxpets + 1
                    if pet == inst then
                        index = maxpets - 1
                    end
                end
            end
        end

        if maxpets == 0 then maxpets = 1 end

        -- Matemática de órbita (suave, cuadro por cuadro)
        local theta = (index / maxpets) * TWOPI + GetTime() * FORMATION_ROTATION_SPEED
        local lx, ly, lz = leader.Transform:GetWorldPosition()

        lx, lz = lx + FORMATION_RADIUS * math.cos(theta), lz + FORMATION_RADIUS * math.sin(theta)

        local px, py, pz = inst.Transform:GetWorldPosition()
        local dx, dz = px - lx, pz - lz
        local dist = math.sqrt(dx*dx + dz*dz)

        -- Ajusta su velocidad según qué tan lejos esté de su punto ideal
        inst.components.locomotor.walkspeed = math.min(dist * 8, FORMATION_MAX_SPEED)
        inst:FacePoint(lx, 0, lz)
        
        -- Empuja la entidad físicamente hacia adelante
        if inst.updatecomponents[inst.components.locomotor] == nil then
            inst.components.locomotor:WalkForward(true)
        end
    end
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    -- [NUEVO] Le dice al juego que voltee a la mosquita al moverse
    inst.Transform:SetFourFaced()

    -- 1. FÍSICA DE VUELO (Ignora el agua y los bordes)
    MakeFlyingCharacterPhysics(inst, 1, 0.5)

    -- 2. TAGS DE VUELO
    inst:AddTag("flying")
    inst:AddTag("ignorewalkableplatformdrowning")
    inst:AddTag("insect")
    inst:AddTag("companion")
    inst:AddTag("NOBLOCK")
    inst:AddTag("wiltolion_buddy")

    inst.AnimState:SetBank("wiltolion_buddy")
    inst.AnimState:SetBuild("wiltolion_buddy")
    inst.AnimState:PlayAnimation("idle", true)

    -- [NUEVO] Hace que la mosquita brille en la oscuridad
    inst.AnimState:SetLightOverride(0.85)
    
    inst:DoPeriodicTask(2, function(inst)
        if inst.AnimState then
            inst.AnimState:SetLightOverride(0.85)
        end
    end)

    inst.entity:SetPristine()
    
    if not TheWorld.ismastersim then
        return inst
    end

    -- 3. LOCOMOTOR DE VUELO
    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 7
    inst.components.locomotor.runspeed = 12
    inst.components.locomotor:EnableGroundSpeedMultiplier(false) -- Vuela a la misma velocidad sobre caminos o barro
    inst.components.locomotor:SetTriggersCreep(false) -- No activa telarañas

    -- 4. EL STATEGRAPH DE LA ABEJA
    inst:SetStateGraph("SGwiltolionbuddy")

    -- 5. VARIABLES DE SONIDO
    inst.sounds = buddysounds
    inst.buzzing = true
    inst.EnableBuzz = EnableBuzz

    -- [[ SEGUIDOR Y COMBATE ]]
    inst:AddComponent("follower")
    inst.components.follower:KeepLeaderOnAttacked()
    inst.components.follower.keepdeadleader = true

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(150)

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(10)
    inst.components.combat:SetAttackPeriod(1)
    inst.components.combat:SetRange(2) -- Las abejas necesitan rango de ataque
    inst.components.combat:SetRetargetFunction(1, function(inst)
        local leader = inst.components.follower.leader
        
        -- Prioridad 1: Si el líder tiene un objetivo, atacamos a ese sin dudarlo
        if leader ~= nil and leader.components.combat.target ~= nil then
            return leader.components.combat.target
        end

        -- Prioridad 2: Si el líder no está peleando, escaneamos 12 unidades a la redonda
        return FindEntity(inst, 12, function(guy)
            return guy.components.health and not guy.components.health:IsDead()
               and guy.components.combat and guy.components.combat:CanBeAttacked(inst)
               and ANNOYING_ENEMIES[guy.prefab] -- ¿Está en nuestra lista negra?
        end,
        { "_combat", "_health" }, -- Etiquetas obligatorias (Optimización del juego)
        { "INCOVER", "notarget", "invisible", "playerghost", "player" } -- Ignorar si están escondidos
        )
    end)
    inst.components.combat:SetKeepTargetFunction(function(inst, target)
        local leader = inst.components.follower.leader
        
        -- Si estábamos persiguiendo un pavo, pero de repente el jugador empieza a 
        -- pelear contra otra cosa (ej: un sabueso), abandonamos al pavo y volvemos al líder.
        if leader and leader.components.combat.target and leader.components.combat.target ~= target then
            return false
        end
        
        -- Si todo está bien, seguimos persiguiendo mientras siga vivo
        return inst.components.combat:CanTarget(target)
    end)

    inst:AddComponent("inspectable")

    local brain = require("brains/wiltolionbuddy_brain") 
    inst:SetBrain(brain)

    -- Efecto al morir
    inst:ListenForEvent("death", function(inst)
        local x, y, z = inst.Transform:GetWorldPosition()
        SpawnPrefab("halloween_firepuff_1").Transform:SetPosition(x, y, z)
        inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
        inst:Remove()
    end)

    -- Invocación usando el sistema Petleash de Klei (Con reciclaje y efecto de fuego)
    inst:ListenForEvent("onbuilt", function(inst, data)
        local builder = data and data.builder
        if builder and builder.components.petleash then
            local pets = builder.components.petleash:GetPets()
            
            local lowest_health_buddy = nil
            local min_health_pct = 999 -- Un número alto inicial para comparar
            local buddy_count = 0
            
            -- 1. Revisamos cuántas moscas hay y buscamos la que tenga MENOS VIDA
            for pet_inst, _ in pairs(pets) do
                if pet_inst:HasTag("wiltolion_buddy") then
                    buddy_count = buddy_count + 1
                    
                    -- Leemos la vida actual de la mosca
                    if pet_inst.components.health then
                        local current_health_pct = pet_inst.components.health:GetPercent()
                        
                        -- Si es la primera que revisamos, o si tiene menos vida que la anterior más débil...
                        if lowest_health_buddy == nil or current_health_pct < min_health_pct then
                            lowest_health_buddy = pet_inst
                            min_health_pct = current_health_pct
                        end
                    end
                end
            end
            
            -- 2. Si ya hay 5, forzamos la desaparición de la más herida
            if buddy_count >= 5 and lowest_health_buddy ~= nil then
                -- Efecto visual y sonoro para la mosca que desaparece
                local ox, oy, oz = lowest_health_buddy.Transform:GetWorldPosition()
                SpawnPrefab("halloween_firepuff_1").Transform:SetPosition(ox, oy, oz)
                lowest_health_buddy.SoundEmitter:PlaySound("dontstarve/common/fireOut")
                
                builder.components.petleash:DespawnPet(lowest_health_buddy)
            end

            -- 3. Invocamos la mosca nueva
            local x, y, z = inst.Transform:GetWorldPosition()
            local real_buddy = builder.components.petleash:SpawnPetAt(x, y, z, "wiltolion_buddy")
            
            if real_buddy then
                -- 4. Efecto de llamarada de la mosca nueva
                SpawnPrefab("halloween_firepuff_1").Transform:SetPosition(x, y, z)
            end
            
            -- Eliminamos la "mosca falsa" del menú
            -- Eliminamos la "mosca falsa" del menú de forma segura
            inst:Hide() -- La ocultamos primero para evitar parpadeos
            inst:DoTaskInTime(0, inst.Remove) -- La eliminamos en el siguiente frame
        end
    end)
    
    local updatelooper = inst:AddComponent("updatelooper")
    updatelooper:AddOnUpdateFn(OnUpdate)

    return inst
end

return Prefab("wiltolion_buddy", fn, assets)