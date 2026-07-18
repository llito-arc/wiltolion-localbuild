local assets = {
    -- While you make your own graphics, we'll use the base bee ones
    Asset("ANIM", "anim/wiltolion_buddy.zip"),
}

-- The bee StateGraph (SGbee) requires these sound paths to exist or it will crash
local buddysounds = {
    takeoff = "dontstarve/bee/bee_takeoff",
    attack = "dontstarve/bee/bee_attack",
    buzz = "dontstarve/bee/bee_fly_LP",
    hit = "dontstarve/bee/bee_hurt",
    death = "dontstarve/bee/bee_death",
}

-- Mandatory function for SGbee to turn buzz on/off
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
-- List of enemies the fly will attack without being ordered to
local ANNOYING_ENEMIES = {
    perd = true,                  -- Pavos roba-bayas (Gobblers)
    buzzard = true,               -- Buitres
    
    -- Sombras que curan al Fuelweaver (Klei usa varias variantes)
    stalker_minion = true,        
    stalker_minion1 = true,       
    stalker_minion2 = true,       
    
    mossling = true,              -- Baby Moose/Goose
    bat = true,                   -- Bats (Batilisks)
    slurper = true,               -- Roba-cordura de las ruinas

    bird_mutant = true,           -- Mutant birds from the ruins
    bird_mutant_spitter = true,   -- Escupidores mutantes de las ruinas
}

-- =========================================================
-- COMBAT VALIDATION HELPER (DEEP INVESTIGATION FIX)
-- =========================================================
local function IsTargetVulnerable(target)
    if target == nil or not target:IsValid() then 
        return false 
    end
    
    -- 1. General Invincibility
    if target.components.health ~= nil and target.components.health:IsInvincible() then
        return false
    end
    
    -- 2. ANCIENT FUELWEAVER (stalker_atrium) SPECIFIC BYPASS
    if target.prefab == "stalker_atrium" then
        -- LAYER 1: Internal native flags
        if target.hasshield or target.shield ~= nil then
            return false
        end
        -- LAYER 2: Damage Absorption Modifiers
        if target.components.health ~= nil and target.components.health.externalabsorptmodifiers ~= nil then
            if target.components.health.externalabsorptmodifiers:Get() >= 1 then
                return false
            end
        end
        -- LAYER 3: The Mechanical Anchor (Unseen Hands)
        local x, y, z = target.Transform:GetWorldPosition()
        local hands = TheSim:FindEntities(x, y, z, 30, {"stalkerminion"}, {"INLIMBO"})
        if #hands > 0 then
            return false
        end
    end
    
    return true
end

local FORMATION_MAX_SPEED = 10.5
local FORMATION_RADIUS = 3.5 -- La distancia a la que orbitan
local FORMATION_ROTATION_SPEED = 0.5

local function OnUpdate(inst, dt)
    -- Seguridad ante todo
    if not inst:IsValid() then return end

    local leader = inst.components.follower and inst.components.follower:GetLeader()
    
    -- If there's a leader, the brain works and we're not standing still
    if leader and leader:IsValid() and inst.brain and not inst.brain.stopped then
        
        -- [NEW] Does the fly have someone in their sights?
        local has_target = inst.components.combat and inst.components.combat:HasTarget()
        
        -- If the fly is hitting, busy, or CHASING a target, return control to AI
        if inst.sg:HasStateTag("attack") or inst.sg:HasStateTag("busy") or has_target then
            inst.components.locomotor.directdrive = false
            
            -- [NEW] Give them their normal speed so they chase quickly!
            inst.components.locomotor.walkspeed = 7
            
            return
        end
        -- If there are no enemies, we take control for the nice orbit
        inst.components.locomotor.directdrive = true

        -- Figure out how many flies there are and what is THIS fly's index to separate them
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

        -- Orbit math (smooth, frame by frame)
        local theta = (index / maxpets) * TWOPI + GetTime() * FORMATION_ROTATION_SPEED
        local lx, ly, lz = leader.Transform:GetWorldPosition()

        lx, lz = lx + FORMATION_RADIUS * math.cos(theta), lz + FORMATION_RADIUS * math.sin(theta)

        local px, py, pz = inst.Transform:GetWorldPosition()
        local dx, dz = px - lx, pz - lz
        local dist = math.sqrt(dx*dx + dz*dz)

        -- Adjust speed based on how far it is from its ideal point
        inst.components.locomotor.walkspeed = math.min(dist * 8, FORMATION_MAX_SPEED)
        inst:FacePoint(lx, 0, lz)
        
        -- Push the entity physically forward
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

    inst.entity:AddLight()

    inst.Light:SetRadius(0.3)      
    inst.Light:SetFalloff(1)     
    inst.Light:SetIntensity(0.3)   

    inst.Light:SetColour(255/255, 230/255, 150/255) 

    inst.Light:Enable(true)

    -- Le dice al juego que voltee a la mosquita al moverse
    inst.Transform:SetFourFaced()

    -- 1. FLIGHT PHYSICS (Ignores water and edges)
    MakeFlyingCharacterPhysics(inst, 1, 0.5)

    -- 2. Fly tags 
    inst:AddTag("flying")
    inst:AddTag("ignorewalkableplatformdrowning")
    inst:AddTag("insect")
    inst:AddTag("companion")
    inst:AddTag("NOBLOCK")
    inst:AddTag("wiltolion_buddy")
    inst:AddTag("soulless")

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
    inst.components.locomotor:SetTriggersCreep(false) -- Doesn't trigger webs

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
        
        -- Priority 1: If the leader has a target AND IS VULNERABLE, attack it
        if leader ~= nil and leader.components.combat.target ~= nil then
            local leader_target = leader.components.combat.target
            if IsTargetVulnerable(leader_target) then
                return leader_target
            end
        end

        -- Priority 2: If the leader isn't fighting (or target has shield), scan annoying enemies
        return FindEntity(inst, 12, function(guy)
            return guy.components.health and not guy.components.health:IsDead()
               and guy.components.combat and guy.components.combat:CanBeAttacked(inst)
               and ANNOYING_ENEMIES[guy.prefab] -- Is it on our blacklist?
               and IsTargetVulnerable(guy) -- Ensure the heals aren't immortal from some bug
        end,
        { "_combat", "_health" }, 
        { "INCOVER", "notarget", "invisible", "playerghost", "player" }
        )
    end)
    inst.components.combat:SetKeepTargetFunction(function(inst, target)
        -- BARRERA 1: Si el objetivo levanta el escudo en mitad de la pelea, Buddy lo suelta al instante
        if not IsTargetVulnerable(target) then
            return false
        end

        local leader = inst.components.follower.leader
        
        -- BARRIER 2: If the leader attacks something new, Buddy changes targets to help.
        -- EXCEPTION: If the leader attacks a shielded boss, Buddy ignores the leader and keeps attacking their current target (e.g., a hand).
        if leader and leader.components.combat.target and leader.components.combat.target ~= target then
            if IsTargetVulnerable(leader.components.combat.target) then
                return false
            end
        end
        
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

    -- Summoning using Klei's Petleash system (With recycling and fire effect)
    inst:ListenForEvent("onbuilt", function(inst, data)
        local builder = data and data.builder
        if builder and builder.components.petleash then
            local pets = builder.components.petleash:GetPets()
            
            local lowest_health_buddy = nil
            local min_health_pct = 999 -- A high initial number to compare
            local buddy_count = 0
            
            -- 1. Check how many flies there are and find the one with LEAST HP
            for pet_inst, _ in pairs(pets) do
                if pet_inst:HasTag("wiltolion_buddy") then
                    buddy_count = buddy_count + 1
                    
                    -- Leemos la vida actual de la mosca
                    if pet_inst.components.health then
                        local current_health_pct = pet_inst.components.health:GetPercent()
                        
                        -- If it's the first we're reviewing, or if it has less HP than the previous weakest...
                        if lowest_health_buddy == nil or current_health_pct < min_health_pct then
                            lowest_health_buddy = pet_inst
                            min_health_pct = current_health_pct
                        end
                    end
                end
            end
            
            -- 2. If there are already 5, force the most injured to disappear
            if buddy_count >= 5 and lowest_health_buddy ~= nil then
                -- Visual and audio effect for the fly that disappears
                local ox, oy, oz = lowest_health_buddy.Transform:GetWorldPosition()
                SpawnPrefab("halloween_firepuff_1").Transform:SetPosition(ox, oy, oz)
                lowest_health_buddy.SoundEmitter:PlaySound("dontstarve/common/fireOut")
                
                builder.components.petleash:DespawnPet(lowest_health_buddy)
            end

            -- 3. Summon the new fly
            local x, y, z = inst.Transform:GetWorldPosition()
            local real_buddy = builder.components.petleash:SpawnPetAt(x, y, z, "wiltolion_buddy")
            
            if real_buddy then
                -- 4. Flare effect for the new fly
                SpawnPrefab("halloween_firepuff_1").Transform:SetPosition(x, y, z)
            end
            
            -- Remove the "fake fly" from the menu
            -- Remove the "fake fly" from the menu safely
            inst:Hide() -- La ocultamos primero para evitar parpadeos
            inst:DoTaskInTime(0, inst.Remove) -- La eliminamos en el siguiente frame
        end
    end)
    
    local updatelooper = inst:AddComponent("updatelooper")
    updatelooper:AddOnUpdateFn(OnUpdate)

    return inst
end

return Prefab("wiltolion_buddy", fn, assets)