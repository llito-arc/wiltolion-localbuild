-- scripts/prefabs/wiltolion_modded_skins.lua

if CreatePrefabSkin == nil then
    return
end

local prefabs = {}

-- ==========================================================
-- TEMPLATE FOR FUTURE SKINS
-- Uncomment and modify the block below to add a custom skin.
-- ==========================================================

--[[
table.insert(prefabs, CreatePrefabSkin("wiltolion_example_skin", {
    assets = {
        Asset("ANIM", "anim/wiltolion_example_skin.zip"),
        Asset("ANIM", "anim/ghost_wiltolion_build.zip"),
    },
    skins = {
        normal_skin = "wiltolion_example_skin",
        ghost_skin = "ghost_wiltolion_build",
    },

    base_prefab = "wiltolion",
    build_name_override = "wiltolion_example_skin",

    type = "base",
    
    -- Triggers the golden frame and golden name logic in the UI.
    rarity = "ModMade",

    -- CRITICAL FIX: Prevents the API from querying Steam for item metadata.
    -- This ensures the golden title renders using local assets.
    check_item_info = false,

    skin_tags = { "WILTOLION", "EXAMPLE_TAG" },
}))
]]

return unpack(prefabs)