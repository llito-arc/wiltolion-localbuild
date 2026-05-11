local assets =
{
	Asset( "ANIM", "anim/wiltolion.zip" ),
	Asset( "ANIM", "anim/ghost_wiltolion_build.zip" ),
}

local skins =
{
	normal_skin = "wiltolion",
	ghost_skin = "ghost_wiltolion_build",
}

return CreatePrefabSkin("wiltolion_none",
{
	base_prefab = "wiltolion",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"WILTOLION", "CHARACTER", "BASE"},
	build_name_override = "wiltolion",
	rarity = "Character",
})