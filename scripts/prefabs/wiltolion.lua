local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
    Asset("SOUNDPACKAGE", "sound/customvoice.fev"),
    Asset("SOUND", "sound/wiltolionvoice.fsb"),
}

-- ===========================================================================
--                         SECTION 1: BASIC CONFIGURATION
-- ===========================================================================
TUNING.WILTOLION_HEALTH = 200   
TUNING.WILTOLION_HUNGER = 200   
TUNING.WILTOLION_SANITY = 100   
TUNING.WILTOLION_AURA = TUNING.SANITYAURA_TINY 

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.WILTOLION = {
    "wiltolion_torus",
    "wilto_journal",
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.WILTOLION
end
local prefabs = FlattenTree(start_inv, true)


-- ===========================================================================
--                         SECTION 2: MATH FUNCTIONS
-- ===========================================================================
local function Lerp(a, b, t)
    return a + (b - a) * t
end


-- ===========================================================================
--                         SECTION 3: CORE PASSIVES & FX
-- ===========================================================================

-- [[ 3.1: Random Sparks Visual Effect ]]
local function SpawnRandomSpark(inst)
    if not inst:IsValid() or inst:HasTag("playerghost") then return end

    local fx = SpawnPrefab("halloween_firepuff_1")
    
    if fx ~= nil then
        -- Set initial scale
        fx.Transform:SetScale(0.5, 0.5, 0.5)
        
        -- Get current player position
        local x, y, z = inst.Transform:GetWorldPosition()
        
        -- Randomize coordinates for a scattered effect
        local offset_x = (math.random() * 0.8) - 0.4
        local offset_y = math.random() * 1.5 
        local offset_z = (math.random() * 0.8) - 0.4
        
        -- Position the spark
        fx.Transform:SetPosition(x + offset_x, y + offset_y, z + offset_z)
        
        -- Apply visual bloom effect
        fx:DoTaskInTime(0, function(f)
            if f:IsValid() and f.AnimState ~= nil then
                f.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
            end
        end)
        
        -- Cleanup spark entity after animation
        fx:DoTaskInTime(1, function(spark)
            if spark:IsValid() then
                spark:Remove()
            end
        end)
    end
end

-- [[ 3.2: Passive Inventory Cooking ]]
local function PassiveCook(inst)
    if not (inst.components.skilltreeupdater and inst.components.skilltreeupdater:IsActivated("wiltolion_solar_1")) then
        return 
    end
    -- Cancel if ghost or missing inventory
    if not inst:IsValid() or inst:HasTag("playerghost") or not inst.components.inventory then 
        return 
    end

    -- Cook only when hunger is above 40% (heat emitting threshold)
    if inst.components.hunger and inst.components.hunger:GetPercent() < 0.40 then
        return
    end

    -- Find raw food in inventory
    local raw_food = inst.components.inventory:FindItem(function(item)
        return item.components.cookable ~= nil and item.components.cookable.product ~= nil
    end)

    if raw_food then
        local product_prefab = raw_food.components.cookable.product
        
        -- If the game returns a function instead of a string (e.g., rabbits), 
        -- execute it to get the real product prefab name ("cookedmorsel").
        if type(product_prefab) == "function" then
            product_prefab = product_prefab(raw_food)
        end
        
        -- Fallback: If it's still not a valid string, cancel to avoid crashes.
        if type(product_prefab) ~= "string" then return end
        
        -- Save stack size
        local stacksize = 1
        if raw_food.components.stackable then
            stacksize = raw_food.components.stackable:StackSize()
        end

        -- Calculate freshness using standard game logic
        local new_freshness = 1
        if raw_food.components.perishable then
            local raw_percent = raw_food.components.perishable:GetPercent()
            -- Calculate spoilage amount
            local spoilage = 1 - raw_percent
            -- Restore half of the spoilage (standard campfire behavior)
            new_freshness = 1 - (spoilage / 2)
        end

        -- Spawn cooked food
        local cooked_food = SpawnPrefab(product_prefab)
        if cooked_food then
            if cooked_food.components.stackable then
                cooked_food.components.stackable:SetStackSize(stacksize)
            end
            
            -- Apply calculated freshness
            if cooked_food.components.perishable then
                cooked_food.components.perishable:SetPercent(new_freshness)
            end
            
            -- Replace raw food with cooked food
            inst.components.inventory:RemoveItem(raw_food, true)
            raw_food:Remove()
            inst.components.inventory:GiveItem(cooked_food)
            
            -- Sound and visual effects
            inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
            
            local x, y, z = inst.Transform:GetWorldPosition()
            local fx = SpawnPrefab("halloween_firepuff_1")
            if fx then
                fx.Transform:SetPosition(x, y + 1, z)
            end
        end
    end
end

-- [[ 3.3: Random Solar Drop Spawner ]]
local function DropSolarEnergy(inst)
    if not (inst.components.skilltreeupdater and inst.components.skilltreeupdater:IsActivated("wiltolion_solar_core")) then
        return 
    end
    if not inst:IsValid() or inst:HasTag("playerghost") then return end
    if not TheWorld.state.isday then return end
    if TheWorld:HasTag("cave") then return end

    -- 20% chance to drop energy every tick
    if math.random() < 0.20 then
        local x, y, z = inst.Transform:GetWorldPosition()
        local drop = SpawnPrefab("wiltolion_sundrop")
        
        if drop ~= nil then
            -- Calculate a slightly wider range around the player
            local offset_x = (math.random() * 4) - 2
            local offset_z = (math.random() * 4) - 2
            
            -- KEY POINT: y=12 spawns it high in the air so it falls down
            drop.Transform:SetPosition(x + offset_x, 12, z + offset_z)
            
            -- Decorative spark in the air where the sun "spawns"
            local fx = SpawnPrefab("halloween_firepuff_1")
            if fx then
                fx.Transform:SetPosition(x + offset_x, 12, z + offset_z)
            end
        end
    end
end


-- ===========================================================================
--                         SECTION 4: THERMAL & LIGHT LOGIC (CORE REWORK)
-- ===========================================================================

-- 1. Configuration Table for Day Phases
local PHASE_STATS = {
    day   = { dmg = 1.25, spd = 1.1, dap = TUNING.DAPPERNESS_SMALL, light_mult = 1.0, color = {255/255, 230/255, 150/255}, override = 0.0 },
    dusk  = { dmg = 1.00, spd = 1.0, dap = 0,                       light_mult = 0.6, color = {255/255, 200/255, 120/255}, override = 0.3 },
    night = { dmg = 0.75, spd = 0.9, dap = -TUNING.DAPPERNESS_MED,  light_mult = 0.4, color = {200/255, 150/255,  50/255}, override = 1.0 }
}

local function GetCurrentPhaseStats()
    if TheWorld.state.isday then return PHASE_STATS.day end
    if TheWorld.state.isdusk then return PHASE_STATS.dusk end
    return PHASE_STATS.night
end

-- 2. Smooth Light Transition
local function SmoothLight(inst)
    if not inst:IsValid() then return end
    inst._cur_rad = Lerp(inst._cur_rad or 0, inst._tgt_rad or 0, 0.15)
    inst._cur_int = Lerp(inst._cur_int or 0, inst._tgt_int or 0, 0.15)
    inst._cur_ovr = Lerp(inst._cur_ovr or 0, inst._tgt_ovr or 0, 0.15)
    
    inst.Light:SetRadius(inst._cur_rad)
    inst.Light:SetIntensity(inst._cur_int)
    inst.AnimState:SetLightOverride(inst._cur_ovr)
end

-- 3. Core Logic Loop (Runs every 1 second)
local function UpdateThermalAndLight(inst)
    if not inst:IsValid() then return end

    -- BLOCK A: GHOST OVERRIDE
    if inst:HasTag("playerghost") then
        inst.Light:Enable(true)
        inst.Light:SetColour(180/255, 195/255, 225/255)
        inst._tgt_rad, inst._tgt_int, inst._tgt_ovr = 0.5, 0.6, 1.0
        
        if inst.components.locomotor then inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "wiltolion_solar_speed") end
        if inst.components.combat then inst.components.combat.damagemultiplier = 1 end
        if inst.components.heater then inst.components.heater:SetThermics(false, false) end
        if inst._sparks_task then inst._sparks_task:Cancel(); inst._sparks_task = nil end
        return
    end

    -- BLOCK B: ACTUALIZAR EL NÚCLEO (HEAT POWER)
    local hunger_pct = inst.components.hunger:GetPercent()
    
    -- Salvavidas inicial
    inst._heat_power = inst._heat_power or 50 
    
    -- THERMOSTAT REWORK: Target power scales so 95% hunger = 100% heat
    -- Using math.min ensures that reaching 100% hunger doesn't exceed 100 heat power
    local target_power = math.min(100, (hunger_pct / 0.95) * 100)

    -- Dynamic speed: Calculates the distance between current heat and target
    local diff = target_power - inst._heat_power

    if diff > 0 then
        -- Heating up: Moves 20% of the remaining distance per tick
        -- math.max ensures a minimum speed of 1.0 so it doesn't get stuck in decimals
        local step = math.max(1.0, diff * 0.05)
        inst._heat_power = math.min(target_power, inst._heat_power + step)
        
    elseif diff < 0 then
        -- Cooling down: Applies the same dynamic logic for a smooth drop
        local step = math.max(1.0, math.abs(diff) * 0.03)
        inst._heat_power = math.max(target_power, inst._heat_power - step)
    end

    -- Enviamos el valor exacto al HUD
    inst._net_heat_power:set(math.floor(inst._heat_power))

    local core_pct = inst._heat_power / 100 -- Valor de 0.0 a 1.0 para los cálculos del Bloque C

    -- BLOCK C: CALCULATE CORE-BASED THERMALS & LIGHT RADIUS
    local temp_modifier, heater_emit, insulation = 0, 0, 0
    local base_radius = 4.0
    local should_spark = false

    -- 4 FASES DEL NÚCLEO
    if core_pct >= 0.90 then
        -- FASE ARDIENTE (90% - 100%)
        local p = (core_pct - 0.90) / 0.10 
        temp_modifier = Lerp(60, 90, p)
        heater_emit = Lerp(60, 90, p)
        insulation = Lerp(200, 240, p)
        base_radius = Lerp(8.0, 12.0, p)
        should_spark = true

    elseif core_pct >= 0.50 then
        -- FASE CÁLIDA (50% - 90%)
        local p = (core_pct - 0.50) / 0.40
        temp_modifier = Lerp(20, 60, p)
        heater_emit = Lerp(20, 60, p)
        insulation = Lerp(60, 200, p)
        base_radius = Lerp(4.0, 8.0, p)

    elseif core_pct >= 0.20 then
        -- FASE TEMPLADA (20% - 50%)
        local p = (core_pct - 0.20) / 0.30
        temp_modifier = Lerp(0, 20, p)
        heater_emit = Lerp(0, 20, p)
        insulation = Lerp(0, 60, p)
        base_radius = Lerp(1.5, 4.0, p)

    else
        -- FASE APAGADA (0% - 20%)
        local p = core_pct / 0.20
        -- De 20% a 0%, la temperatura cae drásticamente a -35
        temp_modifier = Lerp(-35, 0, p) 
        heater_emit = 0
        insulation = 0
        base_radius = Lerp(0, 1.5, p) -- Se apaga poco a poco hasta 0
    end

    -- BLOCK D: MANAGE SPARKS                                                                                                                     
    if should_spark and inst._sparks_task == nil then
        inst._sparks_task = inst:DoPeriodicTask(2.5, SpawnRandomSpark)
    elseif not should_spark and inst._sparks_task ~= nil then
        inst._sparks_task:Cancel()
        inst._sparks_task = nil
    end

    -- BLOCK E: APPLY THERMALS TO COMPONENTS
    if not inst.components.heater then inst:AddComponent("heater") end
    
    if heater_emit > 0 then
        inst.components.heater:SetThermics(true, false)
        inst.components.heater.heat = heater_emit
        inst.components.heater.heatradius = 5.0
    else
        inst.components.heater:SetThermics(false, false)
    end

    if inst.components.temperature then
        -- Aplicamos el modificador seguro que definimos
        if temp_modifier ~= 0 then
            inst.components.temperature:SetModifier("solar_core", temp_modifier)
        else
            inst.components.temperature:RemoveModifier("solar_core")
        end
        inst.components.temperature.inherentinsulation = insulation
    end

    -- BLOCK F: CALCULATE LIGHT & STATS
    local phase = GetCurrentPhaseStats()
    local current_temp = (inst.components.temperature and inst.components.temperature:GetCurrent()) or 25
    local temp_mult = math.max(0, math.min(1, current_temp / 10)) 

    -- Si el núcleo llega a 0, apagamos la luz del todo, independientemente del clima
    if core_pct <= 0 then temp_mult = 0 end

    inst.Light:Enable(temp_mult > 0)
    inst.Light:SetColour(unpack(phase.color))

    inst._tgt_rad = base_radius * phase.light_mult * temp_mult
    inst._tgt_int = 0.8 * temp_mult

    if phase == PHASE_STATS.night and temp_mult < 0.2 then
        inst._tgt_ovr = temp_mult * 5
    else
        inst._tgt_ovr = phase.override
    end

    -- Apply current phase modifiers
    if inst.components.combat then inst.components.combat.damagemultiplier = phase.dmg end
    if inst.components.locomotor then inst.components.locomotor:SetExternalSpeedMultiplier(inst, "wiltolion_solar_speed", phase.spd) end
    if inst.components.sanity then inst.components.sanity.dapperness = phase.dap * temp_mult end
    if inst.components.sanityaura then inst.components.sanityaura.aura = TUNING.WILTOLION_AURA * temp_mult end
end

-- ===========================================================================
--                         SECTION 5: INITIALIZATION AND LISTENERS
-- ===========================================================================

local function StartSolarSystems(inst)
    if inst._solar_task == nil then inst._solar_task = inst:DoPeriodicTask(1, UpdateThermalAndLight) end
    if inst._light_task == nil then inst._light_task = inst:DoPeriodicTask(0.05, SmoothLight) end
    if inst._cook_task == nil then inst._cook_task = inst:DoPeriodicTask(10, PassiveCook) end
    if inst._sundrop_task == nil then inst._sundrop_task = inst:DoPeriodicTask(5, DropSolarEnergy) end
    UpdateThermalAndLight(inst) -- Force an immediate update
end

local function StopSolarSystems(inst)
    if inst._solar_task then inst._solar_task:Cancel(); inst._solar_task = nil end
    if inst._sparks_task then inst._sparks_task:Cancel(); inst._sparks_task = nil end
    if inst._cook_task then inst._cook_task:Cancel(); inst._cook_task = nil end
    if inst._sundrop_task then inst._sundrop_task:Cancel(); inst._sundrop_task = nil end
    UpdateThermalAndLight(inst) -- Force update to apply ghost visuals
end

-- 1. ONSAVE: Triggers when saving or leaving the world
local function onsave(inst, data)
    data.wiltolion_heat_power = inst._heat_power
    data.alter_tokens = inst.alter_tokens
end

-- 2. ONLOAD: Triggers when loading into an existing world
local function onload(inst, data)
    -- Restore Heat Power (Defaults to 50 if new)
    if data and data.wiltolion_heat_power then
        inst._heat_power = data.wiltolion_heat_power
    else
        inst._heat_power = 50
    end

    -- Restore Alter Tokens (Defaults to 3 if new)
    if data and data.alter_tokens then
        inst.alter_tokens = data.alter_tokens
    else
        inst.alter_tokens = 3
    end

    -- [FIX] Force synchronization between server and client UI immediately upon loading
    if inst._net_alter_tokens ~= nil then
        inst._net_alter_tokens:set(inst.alter_tokens)
    end
    if inst._net_heat_power ~= nil then
        inst._net_heat_power:set(math.floor(inst._heat_power))
    end

    inst:ListenForEvent("ms_respawnedfromghost", StartSolarSystems)
    inst:ListenForEvent("ms_becameghost", StopSolarSystems)
    
    if inst:HasTag("playerghost") then
        StopSolarSystems(inst)
    else
        StartSolarSystems(inst)
    end
end

-- 3. ONNEWSPAWN: Triggers only on Day 1 (First time entering the world)
local function onnewspawn(inst)
    onload(inst, {}) 
    inst:DoTaskInTime(0, function(inst)
        if inst.components.inventory then
            local torus = inst.components.inventory:FindItem(function(item) return item.prefab == "wiltolion_torus" end)
            if torus ~= nil then inst.components.inventory:Equip(torus) end
        end
    end)
end

local common_postinit = function(inst) 
    inst.MiniMapEntity:SetIcon("wiltolion.tex")
    inst:AddTag("wiltolion") 
    inst:AddTag("has_light") 
    inst:AddTag("monster")
    inst:AddTag("playermonster")
    inst._net_heat_power = net_byte(inst.GUID, "wiltolion.heat_power", "heatpowerdirty")
    inst._net_alter_tokens = net_byte(inst.GUID, "wiltolion.alter_tokens", "altertokensdirty")
end

local master_postinit = function(inst)
    -- ==========================================
    -- ALTER CALL & HEAT POWER API
    -- ==========================================
    inst.alter_tokens = 3
    if not inst.components.timer then inst:AddComponent("timer") end

    inst:ListenForEvent("timerdone", function(inst, data)
        if data.name == "alter_recharge" then
            if inst.alter_tokens < 3 then
                inst.alter_tokens = inst.alter_tokens + 1
                inst._net_alter_tokens:set(inst.alter_tokens)
                if inst.alter_tokens < 3 then
                    inst.components.timer:StartTimer("alter_recharge", 180)
                end
            end
        end
    end)

    inst.ConsumeHeatPower = function(self, amount)
        self._heat_power = math.max(0, (self._heat_power or 0) - amount)
        self._net_heat_power:set(math.floor(self._heat_power))
    end

    inst.AddHeatPower = function(self, amount)
        self._heat_power = math.min(100, (self._heat_power or 0) + amount)
        self._net_heat_power:set(math.floor(self._heat_power))
    end
    
    -- ==========================================
    -- CORE SETUP
    -- ==========================================
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default
    inst.soundsname = "wiltolionevent"
    inst.talker_path_override = "customvoice/"

    inst.entity:AddLight()

    inst._cur_rad, inst._tgt_rad = 0, 0
    inst._cur_int, inst._tgt_int = 0, 0
    inst._cur_ovr, inst._tgt_ovr = 0, 0
    inst._sparks_task = nil 
    
    inst.components.health:SetMaxHealth(TUNING.WILTOLION_HEALTH)
    inst.components.hunger:SetMax(TUNING.WILTOLION_HUNGER)
    inst.components.sanity:SetMax(TUNING.WILTOLION_SANITY)
    inst.components.builder.magic_bonus = 1

    -- [[ READING SYSTEM ]]
    inst:AddComponent("reader")
    local _OldRead = inst.components.reader.Read
    inst.components.reader.Read = function(self, book)
        if book.prefab == "wilto_journal" or book:HasTag("wilto_journal") then
            return _OldRead(self, book)
        end
        if self.inst.components.talker then
            self.inst.components.talker:Say("I tried, but this magic is super duper tricky!")
        end
        return true 
    end
    
    -- [[ PET SYSTEM ]]
    if inst.components.petleash == nil then inst:AddComponent("petleash") end
    inst.components.petleash:SetMaxPetsForPrefab("wiltolion_buddy", 5)
    inst.components.petleash:SetMaxPetsForPrefab("wiltolion_wilto", 1)
    inst.components.petleash:SetMaxPetsForPrefab("wiltolion_thingy", 2)
    
    inst.components.hunger.hungerrate = 1.25 * TUNING.WILSON_HUNGER_RATE
    inst.components.health.fire_damage_scale = 0

    if not inst.components.sanityaura then inst:AddComponent("sanityaura") end
    inst.components.sanityaura.aura = TUNING.WILTOLION_AURA
    
    inst:AddComponent("heater")

    if inst.components.temperature then
        inst.components.temperature.maxtemp = 99
        inst.components.temperature.hurttemp = 99
        inst.components.temperature.overheattemp = 99
        inst.components.temperature.mintemp = -20 
    end

    inst:WatchWorldState("isday", UpdateThermalAndLight)
    inst:WatchWorldState("isdusk", UpdateThermalAndLight)
    inst:WatchWorldState("isnight", UpdateThermalAndLight)

    -- Attach Save/Load mechanics
    inst.OnSave = onsave
    inst.OnLoad = onload
    inst.OnNewSpawn = onnewspawn
end

return MakePlayerCharacter("wiltolion", prefabs, assets, common_postinit, master_postinit)