-- This information tells other players more about the mod
name = "Wiltolion"
description = [[
You can get all the info at the steam workshop
]]

author = "llito"
version = "1.0.0" -- Quitado el punto extra al final para que sea un formato limpio

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