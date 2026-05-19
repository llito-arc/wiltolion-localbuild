local GLOBAL = GLOBAL

-- ===========================================================================
-- DATA TABLES
-- ===========================================================================
local STAFF_MODIFIERS = {
    yellowstaff = { use_mult = 0.75, sanity_mult = 0.25 },
    opalstaff   = { use_mult = 0.95, sanity_mult = 0.50 },
    greenstaff  = { use_mult = 0.75, sanity_mult = 0.50 },
    telestaff   = { use_mult = 0.50, sanity_mult = 0.50 },
    orangestaff = { use_mult = 0.50, sanity_mult = 0.50 },
    firestaff   = { use_mult = 0.50, sanity_refund = 0.5 },
    icestaff    = { use_mult = 0.50, sanity_refund = 0.5 },
}

local SHADOW_EQUIPMENT = {
    ["nightsword"] = true, ["armor_sanity"] = true, ["purpleamulet"] = true,
    ["skeletonhat"] = true, ["armor_skeleton"] = true, ["dreadstonehat"] = true,
    ["armor_dreadstone"] = true, ["voidclothhat"] = true, ["armor_voidcloth"] = true,
    ["voidcloth_scythe"] = true, ["voidcloth_umbrella"] = true,
}

local LUNAR_GEAR = {
    ["glasscutter"] = true,
    ["moonglassaxe"] = true,
    ["sword_lunarplant"] = true,   
    ["pickaxe_lunarplant"] = true, 
    ["shovel_lunarplant"] = true,  
    ["staff_lunarplant"] = true, 
    ["armor_lunarplant"] = true,
    ["lunarplanthat"] = true,
    ["alterguardianhat"] = true,
    ["alterguardianhatshard"] = true,
    ["opalstaff"] = true,
}

-- ===========================================================================
-- SERVER LOGIC FUNCTIONS
-- ===========================================================================

-- 1. Shadow Fear (Passive sanity drain)
-- 1. Sanity Affinities (Shadow Fear & Lunar Comfort)
local function WiltolionSanityAffinities(inst)
    local extra_rate = 0
    
    if inst.components.inventory then
        for slot, item in pairs(inst.components.inventory.equipslots) do
            if item and item.components.equippable then
                
                -- A) SHADOW FEAR (Penalty)
                if SHADOW_EQUIPMENT[item.prefab] then
                    local dap = item.components.equippable.dapperness
                    if dap and dap < 0 then
                        -- Multiplies existing negative sanity drain by 2x extra
                        extra_rate = extra_rate + (dap * 2.0)
                    else
                        -- Flat penalty of -20 sanity per minute if it doesn't have native drain
                        extra_rate = extra_rate - (20 / 60)
                    end
                end
                
                -- B) LUNAR COMFORT (Bonus)
                if LUNAR_GEAR[item.prefab] then
                    local dap = item.components.equippable.dapperness
                    if dap and dap > 0 then
                        -- Grants a 100% extra bonus if the item already provides positive sanity
                        extra_rate = extra_rate + dap
                    else
                        -- Flat small comfort bonus (+1.8 sanity per minute) for neutral lunar tools
                        extra_rate = extra_rate + (1.8 / 60)
                    end
                end

            end
        end
    end
    
    return extra_rate
end

-- 2. Staff Affinities (Injected into prefabs)
local function InjectStaffAffinities(inst)
    if not GLOBAL.TheWorld.ismastersim then return end
    
    local mods = STAFF_MODIFIERS[inst.prefab]
    if not mods then return end

    -- A) Modify durability (Magic and Melee)
    if mods.use_mult and inst.components.finiteuses then
        local old_Use = inst.components.finiteuses.Use
        inst.components.finiteuses.Use = function(self, num)
            local cost = num or 1
            local owner = self.inst.components.inventoryitem and self.inst.components.inventoryitem.owner
            
            if owner and owner:HasTag("wiltolion") and owner:HasTag("wiltolion_solar_7") then
                cost = cost * mods.use_mult
            end
            if old_Use then old_Use(self, cost) end
        end
    end

    -- B) Modify sanity cost (For casting staves)
    if mods.sanity_mult and inst.components.spellcaster then
        local old_CanCast = inst.components.spellcaster.CanCast
        if old_CanCast then
            inst.components.spellcaster.CanCast = function(self, doer, target, pos)
                local original_cost = self.sanitycost or 0 
                if doer and doer:HasTag("wiltolion") and doer:HasTag("wiltolion_solar_7") then
                    self.sanitycost = original_cost * mods.sanity_mult
                end
                local can_cast = old_CanCast(self, doer, target, pos)
                self.sanitycost = original_cost
                return can_cast
            end
        end

        local old_CastSpell = inst.components.spellcaster.CastSpell
        if old_CastSpell then
            inst.components.spellcaster.CastSpell = function(self, doer, target, pos)
                local original_cost = self.sanitycost or 0 
                if doer and doer:HasTag("wiltolion") and doer:HasTag("wiltolion_solar_7") then
                    self.sanitycost = original_cost * mods.sanity_mult
                end
                old_CastSpell(self, doer, target, pos)
                self.sanitycost = original_cost
            end
        end
    end

    -- C) Modify per-attack sanity refund (Fire and Ice staves)
    if mods.sanity_refund and inst.components.weapon then
        local old_onattack = inst.components.weapon.onattack
        if old_onattack then
            inst.components.weapon.onattack = function(weapon, attacker, target)
                local pre_sanity = attacker.components.sanity and attacker.components.sanity.current or 0
                old_onattack(weapon, attacker, target)
                
                if attacker and attacker:HasTag("wiltolion") and attacker.components.sanity and attacker:HasTag("wiltolion_solar_7") then
                    local post_sanity = attacker.components.sanity.current
                    local sanity_lost = pre_sanity - post_sanity
                    
                    if sanity_lost > 0 then
                        attacker.components.sanity:DoDelta(sanity_lost * mods.sanity_refund, true)
                    end
                end
            end
        end
    end
end

-- 3. Gem Mining
local function OnFinishedWork(inst, data)
    if data ~= nil and data.target ~= nil and data.action ~= nil and data.action.id == "MINE" then
        if not inst:HasTag("wiltolion_solar_2") then
            return
        end
        local target = data.target
        local is_natural_rock = target:HasTag("boulder") or target:HasTag("stalagmite") or target:HasTag("moonrock")

        if is_natural_rock and not target:HasTag("wall") and not target:HasTag("statue") then
            local x, y, z = target.Transform:GetWorldPosition()
            local gems_to_roll = {
                {prefab = "redgem", chance = 0.10}, {prefab = "bluegem", chance = 0.10},
                {prefab = "purplegem", chance = 0.03}, {prefab = "yellowgem", chance = 0.10},
                {prefab = "greengem", chance = 0.005}, {prefab = "orangegem", chance = 0.01},
                {prefab = "opalpreciousgem", chance = 0.001}
            }

            for _, gem_data in ipairs(gems_to_roll) do
                if math.random() < gem_data.chance then
                    local gem = GLOBAL.SpawnPrefab(gem_data.prefab)
                    if gem ~= nil then
                        gem.Transform:SetPosition(x, y, z)
                        if gem.components.inventoryitem ~= nil then
                            gem.components.inventoryitem:OnDropped(true, 0.5 + math.random() * 0.8)
                        end
                        local fx = GLOBAL.SpawnPrefab("sparklefx")
                        if fx then fx.Transform:SetPosition(x, y, z) end
                    end
                end
            end
        end
    end
end

-- 4. Lunar Gear Durability Affinity
local function InjectLunarGearAffinity(inst)
    if not GLOBAL.TheWorld.ismastersim then return end

    if inst.components.finiteuses then
        local old_Use = inst.components.finiteuses.Use
        inst.components.finiteuses.Use = function(self, num)
            local cost = num or 1
            local owner = self.inst.components.inventoryitem and self.inst.components.inventoryitem.owner
            
            if owner and owner:HasTag("wiltolion") and owner:HasTag("wiltolion_lunar_2") then
                cost = cost * 0.5 
            end
            if old_Use then old_Use(self, cost) end
        end
    end
end

-- ===========================================================================
-- INJECTION REGISTRY
-- ===========================================================================

AddPlayerPostInit(function(inst)
    if not GLOBAL.TheWorld.ismastersim then return end
    
    if inst:HasTag("wiltolion") then
        if inst.components.foodaffinity then
            inst.components.foodaffinity:AddPrefabAffinity("dragonpie", GLOBAL.TUNING.AFFINITY_15_CALORIES_HUGE)
        end

        inst:ListenForEvent("finishedwork", OnFinishedWork)

        if inst.components.sanity then
            -- Updated to use the new dual-affinity function
            inst.components.sanity.custom_rate_fn = WiltolionSanityAffinities
        end
    end
end)

for prefab, _ in pairs(LUNAR_GEAR) do
    AddPrefabPostInit(prefab, InjectLunarGearAffinity)
end

for prefab, _ in pairs(STAFF_MODIFIERS) do
    AddPrefabPostInit(prefab, InjectStaffAffinities)
end