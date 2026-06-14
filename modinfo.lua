-- This information tells other players more about the mod
name = "Wiltolion"

description = [[
󰀈 The Sun Lion arrives! 󰀈

󰀏 You can find all the detailed info on the Steam Workshop page.

󰀏 Main Features:
󰀈 Dynamic Thermal Core mechanics with custom HUD badges.
󰀅 Full Custom Skill Tree with 15 unlockable perks.
󰀤 Exclusive equipment: The Sun Torus & Adventure Journal.
󰀘 Summon light companions to fight and heal and other tasks!
󰀝 Fast-travel across the world using Sunflower Pylons.
]]

author = "llito"
version = "2.0.3" 

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = ""

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true

-- Not compatible with Don't Starve
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

-- Character mods are required by all clients
all_clients_require_mod = true 
client_only_mod = false  -- Must be false because it's a character

-- Add this to ensure it loads with priority
priority = -1

icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- The mod's tags displayed on the server list
server_filter_tags = {
    "character",
    "wiltolion",
    "magic",
    "custom character",
}

--configuration_options = {}