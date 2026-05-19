-- ==============================================================================
-- WILTOLION SKILL TREE DEFINITION
-- ==============================================================================

-- Base horizontal and vertical positions (Panel Centers)
local SOLAR_X = -133
local SOLAR_Y = 100
local CONSTEL_X = 20
local LUNAR_ZONE_X = 160

-- Solar Branch Settings (Circular layout)
local CROSS_DIST = 72    
local CORNER_DIST = 48   

-- Layout Offsets
local LOCK_Y_OFFSET = 30 

-- Exact positions for key nodes and locks
local CONSTEL_1_X = -7
local CONSTEL_1_Y = 152
local LUNAR_1_X = 205
local LUNAR_1_Y = 120
local LUNAR_2_X = 133
local LUNAR_2_Y = 190

-- Title Positions
local SOLAR_TITLE_Y = SOLAR_Y + CROSS_DIST + 40
local CONSTEL_TITLE_X = CONSTEL_X + 60
local LUNAR_TITLE_X = LUNAR_ZONE_X + 70

-- Panel Drawing Orders (Global Strings expected: SOLAR, CONSTEL, LUNAR)
local ORDERS =
{
    {"solar",   { SOLAR_X, SOLAR_TITLE_Y }},
    {"constel", { CONSTEL_TITLE_X, 180 }},
    {"lunar",   { LUNAR_TITLE_X, 230 }},
}

--------------------------------------------------------------------------------------------------

local function BuildSkillsData(SkillTreeFns)
    local skills = {}

    -- ==========================================
    -- BRANCH 1: THE SOLAR CORE (The Heart of the Lion)
    -- ==========================================
    
    skills.wiltolion_solar_core = {
        title = "Solar Core",
        desc = "Wilto can now spot Sundrops drifting down from the sky, and catch them in his little paws!",
        icon = "skilltree1",
        pos = {SOLAR_X, SOLAR_Y}, 
        group = "solar",
        tags = {"solar"},
        root = true,
        defaultfocus = true,
        onactivate = function(inst) inst:AddTag("wiltolion_solar_core") end,
        ondeactivate = function(inst) inst:RemoveTag("wiltolion_solar_core") end,
        connects = {
            "wiltolion_solar_1", "wiltolion_solar_2", "wiltolion_solar_3", "wiltolion_solar_4",
            "wiltolion_solar_5", "wiltolion_solar_6", "wiltolion_solar_7", "wiltolion_solar_8"
        },
    }

    local solar_coords = {
        {0, CROSS_DIST}, {CORNER_DIST, CORNER_DIST}, {CROSS_DIST, 0}, {CORNER_DIST, -CORNER_DIST},
        {0, -CROSS_DIST}, {-CORNER_DIST, -CORNER_DIST}, {-CROSS_DIST, 0}, {-CORNER_DIST, CORNER_DIST}
    }

    -- Solar Flare Nodes (1-8)
    local solar_flares = {
        { title = "Toasty Tummy",        desc = "When it gets nice and toasty inside, little sunbursts happily zap any nearby snacks.", icon = "skilltree2", },
        { title = "Shiny Hunt",          desc = "Wiltolion just *has* to double-check every stone... what if one sparkles back?", icon = "skilltree3",},
        { title = "Sunfly buddies",      desc = "Learn how to call tiny Sunfly buddies to flutter by your side.", icon = "skilltree4",},
        { title = "Echo Wilto",          desc = "Summon a cheeky echo of Wilto to lend a friendly hand.", icon = "skilltree5", },
        { title = "Sunny drops",         desc = "Use Sundrops to fuel a bunch of items.", icon = "skilltree6", },
        { title = "Sparkly Crafting",    desc = "Discover fun new ways to tinker with Opal and Yellow Staves.", icon = "skilltree7",},
        { title = "Shimmer Tricks",      desc = "Wands feel lighter, brighter, and a bit more magical to use.", icon = "skilltree8",},
        { title = "Sunny Crown",         desc = "Learn to make your own space-donut!", icon = "skilltree9",},
    }

    for i = 1, 8 do
        local name = "wiltolion_solar_"..i
        skills[name] = {
            title = solar_flares[i].title,
            desc = solar_flares[i].desc,
            icon = solar_flares[i].icon,
            pos = {SOLAR_X + solar_coords[i][1], SOLAR_Y + solar_coords[i][2]},
            group = "solar",
            tags = {"solar"},
            onactivate = function(inst) inst:AddTag(name) end,
            ondeactivate = function(inst) inst:RemoveTag(name) end,
        }
    end

    -- ==========================================
    -- BRANCH 2: THE CONSTELLATIONS (Stellar Architecture)
    -- ==========================================
    
    skills.wiltolion_constel_lock = {
        desc = "Requires complete mastery of the Solar Heartbeat (9 skills).",
        pos = {CONSTEL_1_X, CONSTEL_1_Y + LOCK_Y_OFFSET}, 
        group = "constel",
        tags = {"constel", "lock"},
        root = true,
        lock_open = function(prefabname, activatedskills, readonly)
            return SkillTreeFns.CountTags(prefabname, "solar", activatedskills) >= 9
        end,
        connects = {"wiltolion_constel_1"},
    }

    local constel_positions = {
        {CONSTEL_1_X, CONSTEL_1_Y},
        {10, 48},   
        {73, 107},  
        {137, 38}   
    }

    local constel_data = {
        { title = "Adventure Diary",    desc = "A cozy journal to share adventures with Wilto.", icon = "skilltree10",  },
        { title = "Sunflower Friend",   desc = "Build a big, quiet sunflower statue that always seems to watch over you.", icon = "skilltree11", },
        { title = "Celestial Hop",      desc = "Learn to hop between sunflower friends in a blink!.", icon = "skilltree12", },
        { title = "Sun Spider",         desc = "Summon a tiny spider that heals you and your allies.", icon = "skilltree13", },
    }

    for i = 1, 4 do
        local name = "wiltolion_constel_" .. i
        skills[name] = {
            title = constel_data[i].title,
            desc = constel_data[i].desc,
            icon = constel_data[i].icon,
            pos = constel_positions[i],
            group = "constel",
            tags = {"constel"},
            onactivate = function(inst) inst:AddTag(name) end,
            ondeactivate = function(inst) inst:RemoveTag(name) end,
            connects = (i < 4) and {"wiltolion_constel_"..(i+1)} or nil,
        }
    end

    -- ==========================================
    -- BRANCH 3: THE LUNAR ALIGNMENT (Celestial Perfection)
    -- ==========================================

    skills.wiltolion_lunar_lock_1 = {
        desc = "Requires the defeat of the Celestial Champion.",
        pos = {LUNAR_1_X, LUNAR_1_Y + LOCK_Y_OFFSET}, 
        group = "lunar",
        tags = {"lunar", "lock"},
        root = true,
        lock_open = function(prefabname, activatedskills, readonly)
            if readonly then return "question" end
            return TheGenericKV:GetKV("celestialchampion_killed") == "1" and SkillTreeFns.CountSkills(prefabname, activatedskills) >= 13
        end,
        connects = {"wiltolion_lunar_1"},
    }
    
    skills.wiltolion_lunar_1 = {
        title = "Moon-Biting Mirage",
        desc = "Wilto calls out to the night friend for help, and it sends a swarm of hungry little Gestalts to nibble at his foes.",
        icon = "wilson_favor_lunar", 
        pos = {LUNAR_1_X, LUNAR_1_Y},
        group = "lunar", 
        tags = {"lunar", "lunar_favor"},
        onactivate = function(inst) inst:AddTag("wiltolion_lunar_1") end,
        ondeactivate = function(inst) inst:RemoveTag("wiltolion_lunar_1") end,
    }

    skills.wiltolion_lunar_lock_2 = {
        desc = "Requires total enlightenment (all branches reached).",
        pos = {LUNAR_2_X, LUNAR_2_Y + LOCK_Y_OFFSET},
        group = "lunar",
        tags = {"lunar", "lock"},
        root = true,
        lock_open = function(prefabname, activatedskills, readonly)
            return SkillTreeFns.CountSkills(prefabname, activatedskills) >= 14
        end,
        connects = {"wiltolion_lunar_2"},
    }
    
    skills.wiltolion_lunar_2 = {
        title = "Moony Bond",
        desc = "Night tools and weapons feel extra happy in your hands, working well for you.",
        icon = "skilltree14", 
        pos = {LUNAR_2_X, LUNAR_2_Y},
        group = "lunar", 
        tags = {"lunar", "lunar_favor"},
        onactivate = function(inst) inst:AddTag("wiltolion_lunar_2") end,
        ondeactivate = function(inst) inst:RemoveTag("wiltolion_lunar_2") end,
    }

    return {
        SKILLS = skills,
        ORDERS = ORDERS,
        BACKGROUND_SETTINGS = {
            tint_bright = { 0.35, 0.35, 0.35 }, 
            tint_dim = { 0.25, 0.25, 0.25 },    
            tint_bright_alpha = 1,
            tint_dim_alpha = 1,
        },
    }
end

--------------------------------------------------------------------------------------------------

return BuildSkillsData