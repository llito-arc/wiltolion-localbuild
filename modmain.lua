-- ==========================================
-- 1. ASSETS & PREFABS
-- ==========================================
PrefabFiles = {
    "wiltolion",
    "wiltolion_none",
    "wiltolion_torus",
    "wiltolion_sundrop",
    "wiltolion_buddy",
    "wiltolion_wilto",
    "wilto_journal",
    "wilto_journal_fx",
    "wiltolion_pylon",
    "wiltolion_gestalt_projectile",
    "wiltolion_thingy",
}

Assets = {
    Asset("IMAGE", "images/saveslot_portraits/wiltolion.tex" ),
    Asset("ATLAS", "images/saveslot_portraits/wiltolion.xml" ),
    Asset("IMAGE", "images/selectscreen_portraits/wiltolion.tex" ),
    Asset("ATLAS", "images/selectscreen_portraits/wiltolion.xml" ),
    Asset("IMAGE", "images/selectscreen_portraits/wiltolion_silho.tex" ),
    Asset("ATLAS", "images/selectscreen_portraits/wiltolion_silho.xml" ),
    Asset("IMAGE", "bigportraits/wiltolion.tex" ),
    Asset("ATLAS", "bigportraits/wiltolion.xml" ),
    Asset("IMAGE", "images/map_icons/wiltolion.tex" ),
    Asset("ATLAS", "images/map_icons/wiltolion.xml" ),
    Asset("IMAGE", "images/avatars/avatar_wiltolion.tex" ),
    Asset("ATLAS", "images/avatars/avatar_wiltolion.xml" ),
    Asset("IMAGE", "images/avatars/avatar_ghost_wiltolion.tex" ),
    Asset("ATLAS", "images/avatars/avatar_ghost_wiltolion.xml" ),
    Asset("IMAGE", "images/avatars/self_inspect_wiltolion.tex" ),
    Asset("ATLAS", "images/avatars/self_inspect_wiltolion.xml" ),
    Asset("IMAGE", "images/names_wiltolion.tex" ),
    Asset("ATLAS", "images/names_wiltolion.xml" ),
    Asset("IMAGE", "images/names_gold_wiltolion.tex" ),
    Asset("ATLAS", "images/names_gold_wiltolion.xml" ),
    Asset("IMAGE", "images/inventoryimages/wiltolion_torus.tex"),
    Asset("ATLAS", "images/inventoryimages/wiltolion_torus.xml"),
    Asset("IMAGE", "images/inventoryimages/wiltolion_buddy.tex"),
    Asset("ATLAS", "images/inventoryimages/wiltolion_buddy.xml"),
    Asset("IMAGE", "images/inventoryimages/wiltolion_wilto.tex"),
    Asset("ATLAS", "images/inventoryimages/wiltolion_wilto.xml"),
    Asset("IMAGE", "images/wilto_panel.tex" ),
    Asset("ATLAS", "images/wilto_panel.xml" ),
    Asset("IMAGE", "images/inventoryimages/wilto_journal.tex"),
    Asset("ATLAS", "images/inventoryimages/wilto_journal.xml"),
    Asset("IMAGE", "images/inventoryimages/wiltolion_pylon.tex"),
    Asset("ATLAS", "images/inventoryimages/wiltolion_pylon.xml"),
    Asset("ATLAS", "images/map_icons/wiltolion_pylon_mapicon.xml"),
    Asset("IMAGE", "images/map_icons/wiltolion_pylon_mapicon.tex"),
    Asset("ATLAS", "images/wiltolion_background.xml"),
    Asset("IMAGE", "images/wiltolion_background.tex"),
    Asset("ATLAS", "images/inventoryimages/wiltolion_thingy.xml"),
    Asset("IMAGE", "images/inventoryimages/wiltolion_thingy.tex"),
}

for i = 1, 14 do
    local xml_path = "images/skilltree/skilltree"..i..".xml"
    local tex_name = "skilltree"..i..".tex"
    
    -- 1. CARGAR EN MEMORIA (Esto es lo que faltaba)
    table.insert(Assets, Asset("ATLAS", xml_path))
    table.insert(Assets, Asset("IMAGE", "images/skilltree/"..tex_name))
    
    -- 2. REGISTRAR PARA EL MENÚ
    RegisterSkilltreeIconsAtlas(xml_path, tex_name)
end

RegisterInventoryItemAtlas("images/inventoryimages/wilto_journal.xml", "wilto_journal.tex")
RegisterInventoryItemAtlas("images/inventoryimages/wiltolion_torus.xml", "wiltolion_torus.tex")
RegisterInventoryItemAtlas("images/inventoryimages/wiltolion_buddy.xml", "wiltolion_buddy.tex")
RegisterInventoryItemAtlas("images/inventoryimages/wiltolion_sundrop.xml", "wiltolion_sundrop.tex")
RegisterInventoryItemAtlas("images/inventoryimages/wiltolion_wilto.xml", "wiltolion_wilto.tex")
RegisterInventoryItemAtlas("images/inventoryimages/wiltolion_pylon.xml", "wiltolion_pylon.tex")
RegisterInventoryItemAtlas("images/inventoryimages/wiltolion_thingy.xml", "wiltolion_thingy.tex")

AddMinimapAtlas("images/map_icons/wiltolion.xml")
AddMinimapAtlas("images/map_icons/wiltolion_pylon_mapicon.xml")

-- ==========================================
-- 2. CHARACTER SETUP
-- ==========================================
local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 } 
    },
}
AddModCharacter("wiltolion", "MALE", skin_modes)

-- ==========================================
-- 3. MODULE IMPORTS
-- ==========================================
modimport("scripts/modmain/wiltolion_strings.lua")
modimport("scripts/modmain/wiltolion_recipes.lua")
modimport("scripts/modmain/wiltolion_containers.lua")
modimport("scripts/modmain/wiltolion_actions.lua")
modimport("scripts/modmain/wiltolion_visuals.lua")
modimport("scripts/modmain/wiltolion_affinities.lua")

local _G = GLOBAL

-- 2. Hook the internal function to inject your custom background
local old_GetSkilltreeBG = _G.GetSkilltreeBG
_G.GetSkilltreeBG = function(bgname)
    if bgname == "wiltolion_background.tex" then
        return "images/wiltolion_background.xml"
    end
    
    if old_GetSkilltreeBG then
        return old_GetSkilltreeBG(bgname)
    end
    
    return nil
end

-- 3. THE MISSING PART: Register your skills into the game's registry
local skilltreedefs = require("prefabs/skilltree_defs")
local BuildWiltolionSkills = require("prefabs/skilltree_wiltolion")
local data = BuildWiltolionSkills(skilltreedefs.FN)

if data then
    skilltreedefs.CreateSkillTreeFor("wiltolion", data.SKILLS)
    skilltreedefs.SKILLTREE_ORDERS["wiltolion"] = data.ORDERS
end