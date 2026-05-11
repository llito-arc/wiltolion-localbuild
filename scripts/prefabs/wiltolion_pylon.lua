local assets = {
    Asset("ANIM", "anim/wiltolion_pylon.zip"),
}

local prefabs = {
    "collapse_small", 
}

-- =========================================================
-- REGISTRO GLOBAL DE PILONES (NUEVO)
-- =========================================================
local function RegisterPylon(inst)
    if not TheWorld.wiltolion_pylons then
        TheWorld.wiltolion_pylons = {}
    end
    TheWorld.wiltolion_pylons[inst] = true
end

local function UnregisterPylon(inst)
    if TheWorld.wiltolion_pylons then
        TheWorld.wiltolion_pylons[inst] = nil
    end
end

-- =========================================================
-- CONFIGURACIÓN DE GEMAS Y PODERES
-- =========================================================
local GEMS_DATA = {
    redgem          = { timer = "power_red",    duration = 1800 },
    bluegem         = { timer = "power_blue",   duration = 1800 },
    purplegem       = { timer = "power_purple", duration = 3600 },
    orangegem       = { timer = "power_orange", duration = 5400 },
    yellowgem       = { timer = "power_yellow", duration = 5400 },
    greengem        = { timer = "power_green",  duration = 9000 },
    opalpreciousgem = { timer = "power_opal",   duration = 14400 },
}

-- =========================================================
-- EVENTOS DE ESTRUCTURA
-- =========================================================
local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle", false)
end

local function onmined(inst, worker)
    inst.components.lootdropper:DropLoot()
    
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
    
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("stone")
    
    inst:Remove()
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", false)
    inst.SoundEmitter:PlaySound("dontstarve/common/place_structure_stone")
end

-- =========================================================
-- SISTEMA NERVIOSO: AURAS, RADAR Y VISUALES
-- =========================================================
local function UpdateAuras(inst)
    local timer = inst.components.timer
    if not timer then return end

    local has_red = timer:TimerExists("power_red")
    local has_blue = timer:TimerExists("power_blue")
    local has_yellow = timer:TimerExists("power_yellow")
    local has_purple = timer:TimerExists("power_purple")
    local has_opal = timer:TimerExists("power_opal")

    local multiplier = has_opal and 1.5 or 1.0

    -- ==========================================
    -- 1. FEEDBACK VISUAL: AURA DIVINA DE SPAWN
    -- ==========================================
    if has_opal then
        -- Si el Ópalo está activo y el escudo blanco no existe, lo invocamos
        if inst._opal_shield_fx == nil then
            -- Este es el nombre exacto en el código de Klei para la inmunidad al spawnear
            inst._opal_shield_fx = SpawnPrefab("spawnprotectionbuff")
            
            if inst._opal_shield_fx ~= nil then
                -- Lo emparentamos al Pilón para que lo siga y se destruya con él
                inst._opal_shield_fx.entity:SetParent(inst.entity)
                
                -- Ajustamos la posición vertical. Al ser para un jugador, suele spawnear en los pies.
                inst._opal_shield_fx.Transform:SetPosition(0, 0.2, 0)
                
                -- Escala para que cubra bien la estructura de roca
                inst._opal_shield_fx.Transform:SetScale(1.6, 1.6, 1.6)
            end
        end
    else
        -- Si el Ópalo se agota, limpiamos la cúpula blanca
        if inst._opal_shield_fx ~= nil then
            if inst._opal_shield_fx:IsValid() then
                inst._opal_shield_fx:Remove()
            end
            inst._opal_shield_fx = nil
        end
    end

    -- ==========================================
    -- Mezclador dinámico de colores (Tinte visual aditivo sutil)
    -- ==========================================
    local r, g, b = 0, 0, 0
    if has_red then r = r + 0.15 end
    if has_blue then b = b + 0.15 end
    if has_yellow then r = r + 0.1; g = g + 0.1 end
    if has_purple then r = r + 0.1; b = b + 0.1 end
    if timer:TimerExists("power_green") then g = g + 0.15 end

    -- Aplicamos el color al propio pilón por debajo del escudo blanco
    inst.AnimState:SetAddColour(math.min(r, 0.3), math.min(g, 0.3), math.min(b, 0.3), 0)

    -- ==========================================
    -- 2. TEMPERATURA Y AHORRO DE ENERGÍA
    -- ==========================================
    local is_winter = TheWorld.state.iswinter
    local is_summer = TheWorld.state.issummer
    local is_heating, is_cooling = false, false
    local heat_amount = 0

    if has_red then
        if not is_winter and not timer:IsPaused("power_red") then
            timer:PauseTimer("power_red")
        elseif is_winter and timer:IsPaused("power_red") then
            timer:ResumeTimer("power_red")
        end
    end

    if has_blue then
        if not is_summer and not timer:IsPaused("power_blue") then
            timer:PauseTimer("power_blue")
        elseif is_summer and timer:IsPaused("power_blue") then
            timer:ResumeTimer("power_blue")
        end
    end

    if has_red and is_winter and not timer:IsPaused("power_red") then
        heat_amount = 100 * multiplier 
        is_heating = true
    elseif has_blue and is_summer and not timer:IsPaused("power_blue") then
        heat_amount = -20 * multiplier
        is_cooling = true
    end

    if inst.components.heater then
        inst.components.heater:SetThermics(is_heating, is_cooling)
        inst.components.heater.heat = heat_amount
    end

    -- ==========================================
    -- 3. LUZ FÍSICA
    -- ==========================================
    if has_yellow then
        inst.Light:Enable(true)
        inst.Light:SetRadius(3.5 * multiplier) 
    else
        inst.Light:Enable(false)
    end

    -- ==========================================
    -- 4. CORDURA
    -- ==========================================
    if inst.components.sanityaura then
        if has_purple then
            inst.components.sanityaura.aura = 0.20 * multiplier
        else
            inst.components.sanityaura.aura = 0
        end
    end
end

local function ApplyRadarPulses(inst)
    local timer = inst.components.timer
    if not timer then return end

    local has_green = timer:TimerExists("power_green")
    local has_orange = timer:TimerExists("power_orange")
    local has_opal = timer:TimerExists("power_opal")

    if not (has_green or has_orange or has_opal) then return end

    local multiplier = has_opal and 1.5 or 1.0
    local radius = 40 

    local x, y, z = inst.Transform:GetWorldPosition()
    local players = FindPlayersInRange(x, y, z, radius, true)

    for i, player in ipairs(players) do
        
        -- CURACIÓN PASIVA
        if has_green and player.components.health then
            player.components.health:DoDelta(0.25 * multiplier, true, "wiltolion_pylon")
        end

        -- VELOCIDAD
        if has_orange and player.components.locomotor then
            local speed_bonus = 0.10 * multiplier
            local speed_mult = 1.0 + speed_bonus
            
            player.components.locomotor:SetExternalSpeedMultiplier(player, "wiltolion_pylon_speed", speed_mult)
            
            if player.wiltolion_speed_task ~= nil then
                player.wiltolion_speed_task:Cancel()
            end
            
            player.wiltolion_speed_task = player:DoTaskInTime(1.5, function(p)
                if p.components.locomotor then
                    p.components.locomotor:RemoveExternalSpeedMultiplier(p, "wiltolion_pylon_speed")
                end
                p.wiltolion_speed_task = nil
            end)
        end

        -- DEFENSA BASE
        if has_opal and player.components.health then
            if player.components.health.externalabsorbmodifiers then
                player.components.health.externalabsorbmodifiers:SetModifier(inst, 0.20, "wiltolion_pylon_defense")
            end
            
            if player.wiltolion_defense_task ~= nil then
                player.wiltolion_defense_task:Cancel()
            end
            
            player.wiltolion_defense_task = player:DoTaskInTime(1.5, function(p)
                if p.components.health and p.components.health.externalabsorbmodifiers then
                    p.components.health.externalabsorbmodifiers:RemoveModifier(inst, "wiltolion_pylon_defense")
                end
                p.wiltolion_defense_task = nil
            end)
        end
    end
end

-- =========================================================
-- METABOLISMO: CONSUMO Y FOTOSÍNTESIS
-- =========================================================
local function GenerateSundrops(inst)
    if not inst:IsValid() then return end
    
    if not TheWorld.state.isday then return end
    if TheWorld:HasTag("cave") then return end

    if math.random() < 0.10 then
        local container = inst.components.container
        if container ~= nil then
            local drop = SpawnPrefab("wiltolion_sundrop")
            if drop ~= nil then
                local success = container:GiveItem(drop)
                
                if not success then
                    drop:Remove()
                end
            end
        end
    end
end

local function CheckGems(inst)
    if not inst.components.container then return end

    for gem_prefab, data in pairs(GEMS_DATA) do
        if not inst.components.timer:TimerExists(data.timer) then
            if inst.components.container:Has(gem_prefab, 1) then
                inst.components.container:ConsumeByName(gem_prefab, 1)
                
                inst.components.timer:StartTimer(data.timer, data.duration)
                inst.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")
                
                UpdateAuras(inst)
            end
        end
    end
end

local function OnTimerDone(inst, event_data)
    if event_data ~= nil and event_data.name ~= nil then
        for _, data in pairs(GEMS_DATA) do
            if event_data.name == data.timer then
                UpdateAuras(inst)
                break
            end
        end
    end
end

-- =========================================================
-- CREACIÓN DE LA ENTIDAD
-- =========================================================
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon("wiltolion_pylon_mapicon.tex")
    inst.entity:AddNetwork()

    inst.entity:AddLight()
    inst.Light:SetFalloff(0.7)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetRadius(3.5)
    inst.Light:SetColour(255/255, 255/255, 100/255)
    inst.Light:Enable(false)
    
    MakeObstaclePhysics(inst, .75)

    inst.MiniMapEntity:SetPriority(5)

    inst.AnimState:SetBank("wiltolion_pylon")
    inst.AnimState:SetBuild("wiltolion_pylon")
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("structure")
    inst:AddTag("wiltolion_pylon")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("wiltolion_pylon")

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    
    inst:DoPeriodicTask(5, CheckGems)
    inst:DoPeriodicTask(1, ApplyRadarPulses)
    inst:DoPeriodicTask(5, GenerateSundrops)
    
    inst:WatchWorldState("iswinter", UpdateAuras)
    inst:WatchWorldState("issummer", UpdateAuras)

    inst:AddComponent("heater")
    inst.components.heater:SetThermics(false, false)

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = 0 
    inst.components.sanityaura.max_distsq = 1600 
    
    inst.components.sanityaura.fallofffn = function(inst, observer, distsq)
        return 1
    end

    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
    inst.components.workable:SetOnFinishCallback(onmined)
    inst.components.workable:SetOnWorkCallback(onhit)

    -- [[ NUEVOS LISTENERS INTEGRADOS CORRECTAMENTE ]]
    inst:ListenForEvent("onbuilt", function(inst)
        onbuilt(inst)
        RegisterPylon(inst) -- Se anota al construirlo
    end)

    inst:ListenForEvent("onremove", UnregisterPylon) -- Se borra al destruirlo

    MakeHauntableWork(inst)

    inst.OnLoad = function(inst)
        inst:DoTaskInTime(0, function()
            UpdateAuras(inst)
            RegisterPylon(inst) -- Se anota al cargar la partida guardada
        end)
    end

    return inst
end

return Prefab("wiltolion_pylon", fn, assets, prefabs),
       MakePlacer("wiltolion_pylon_placer", "wiltolion_pylon", "wiltolion_pylon", "idle")