local GLOBAL = GLOBAL
local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH

AddRecipe2(
    "wiltolion_torus",
    { 
        Ingredient("thulecite", 3), 
        Ingredient("yellowgem", 3),
        Ingredient("greengem", 1),
        Ingredient("goldnugget", 10),
        Ingredient("wiltolion_sundrop", 200), 
    },
    TECH.MAGIC_THREE,
    {
        -- Skill tag required instead of 'level'
        builder_tag = "wiltolion_solar_8", 
        atlas = "images/inventoryimages/wiltolion_torus.xml",
        image = "wiltolion_torus.tex",
    },
    {"MAGIC", "CLOTHING", "CHARACTER"}
)

AddRecipe2(
    "wiltolion_buddy",
    { 
        Ingredient("wiltolion_sundrop", 3), 
    },
    TECH.NONE,
    {
        -- Skill tag required instead of 'level'
        builder_tag = "wiltolion_solar_3", 
        atlas = "images/inventoryimages/wiltolion_buddy.xml",
        image = "wiltolion_buddy.tex",
    },
    {"CHARACTER", "MAGIC"}
)

AddRecipe2(
    "yellowgem",
    { 
        Ingredient("goldnugget", 3), 
        Ingredient("wiltolion_sundrop", 50), 
    },
    TECH.NONE,
    {
        -- Skill tag required instead of 'level'
        builder_tag = "wiltolion_solar_core", 
    },
    {"CHARACTER", "REFINE"}
)

AddRecipe2(
    "wiltolion_sundrop",
    { 
        Ingredient("yellowgem", 1), 
    },
    TECH.NONE, 
    {
        -- Skill tag required instead of 'level'
        builder_tag = "wiltolion_solar_core", 
        numtogive = 20, 
    },
    {"CHARACTER", "REFINE"}
)

AddRecipe2(
    "opalstaff",
    { 
        Ingredient("livinglog", 2),
        Ingredient("opalpreciousgem", 1),
        Ingredient("wiltolion_sundrop", 20),
    },
    TECH.MAGIC_THREE,
    {
        -- Skill tag required instead of 'level'
        builder_tag = "wiltolion_solar_6", 
    },
    {"CHARACTER", "MAGIC", "WEAPONS"}
)

AddRecipe2(
    "yellowstaff",
    { 
        Ingredient("livinglog", 2),
        Ingredient("yellowgem", 2),
        Ingredient("wiltolion_sundrop", 20),
    },
    TECH.MAGIC_TWO,
    {
        -- Skill tag required instead of 'level'
        builder_tag = "wiltolion_solar_6", 
    },
    {"CHARACTER", "MAGIC", "WEAPONS"}
)

AddRecipe2(
    "wiltolion_wilto_builder",
    { 
        Ingredient("reviver", 1), 
        Ingredient("wiltolion_sundrop", 20),
        Ingredient("boneshard", 5),
    },
    TECH.NONE,
    {
        -- Skill tag required instead of 'level'
        builder_tag = "wiltolion_solar_4", 
        atlas = "images/inventoryimages/wiltolion_wilto.xml",
        image = "wiltolion_wilto.tex",
    },
    {"CHARACTER", "MAGIC"}
)

AddRecipe2(
    "wilto_journal",
    { 
        Ingredient("papyrus", 2), 
        Ingredient("wiltolion_sundrop", 5), 
    },
    TECH.NONE,
    {
        -- Skill tag required instead of 'level'
        builder_tag = "wiltolion_constel_1", 
        atlas = "images/inventoryimages/wilto_journal.xml",
        image = "wilto_journal.tex",
    },
    {"CHARACTER", "MAGIC"}
)

AddRecipe2(
    "wiltolion_pylon",
    { 
        Ingredient("cutstone", 4),
        Ingredient("goldnugget", 2),
        Ingredient("transistor", 2),
        Ingredient("wiltolion_sundrop", 10),
        Ingredient("thulecite", 2),
        Ingredient("gears", 2),         -- Mechanical complexity
    },
    TECH.SCIENCE_TWO,
    {
        -- Skill tag required instead of 'level'
        builder_tag = "wiltolion_constel_2",
        placer = "wiltolion_pylon_placer",
        atlas = "images/inventoryimages/wiltolion_pylon.xml",
        image = "wiltolion_pylon.tex",
        testfn = function(pt, rot)
            local pylons = GLOBAL.TheSim:FindEntities(pt.x, pt.y, pt.z, 120, {"wiltolion_pylon"})
            if #pylons > 0 then
                return false, "PYLON_TOOCLOSE"
            end
            return true
        end
    },
    {"CHARACTER", "STRUCTURES"}
)

-- ==========================================
-- RECETA DE LA INVOCACIÓN CURATIVA
-- ==========================================
AddRecipe2("wiltolion_thingy",
    {
        GLOBAL.Ingredient("silk", 3),
        Ingredient("goldnugget", 2),
        Ingredient("wiltolion_sundrop", 10),
        Ingredient("spidergland", 1)
    },
    GLOBAL.TECH.NONE, 
    {
        builder_tag = "wiltolion_constel_4", 
        nounlock = true,
        -- Use the atlas and image you want to show in the crafting menu
        atlas = "images/inventoryimages/wiltolion_thingy.xml",
        image = "wiltolion_thingy.tex",
    },
    {"CHARACTER", "MAGIC"}
)