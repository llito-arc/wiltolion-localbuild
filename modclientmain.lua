local _G = GLOBAL

-- =========================================================
-- 1. PREFABS (Evita crasheos en ropero y compendio)
-- =========================================================
PrefabFiles = {
    "wiltolion",
    "wiltolion_none",
    "wiltolion_torus", -- Necesario para que el compendio reconozca el ítem
}

-- =========================================================
-- 2. ASSETS LIST
-- =========================================================
Assets = {
    -- Retratos del Ropero y Menú
    Asset( "IMAGE", "images/selectscreen_portraits/wiltolion.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/wiltolion.xml" ),
    Asset( "IMAGE", "images/selectscreen_portraits/wiltolion_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/wiltolion_silho.xml" ),
    
    Asset( "IMAGE", "bigportraits/wiltolion.tex" ),
    Asset( "ATLAS", "bigportraits/wiltolion.xml" ),
    Asset( "IMAGE", "bigportraits/wiltolion_none.tex" ),
    Asset( "ATLAS", "bigportraits/wiltolion_none.xml" ),
    
    Asset( "IMAGE", "images/names_wiltolion.tex" ),
    Asset( "ATLAS", "images/names_wiltolion.xml" ),
    Asset( "IMAGE", "images/names_gold_wiltolion.tex" ),
    Asset( "ATLAS", "images/names_gold_wiltolion.xml" ),
    
    -- ¡NUEVO! Icono para la lista de mundos / saveslot
    Asset( "IMAGE", "images/saveslot_portraits/wiltolion.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/wiltolion.xml" ),

    -- ¡NUEVO! Imágenes para que el Torus cargue en el menú
    Asset("IMAGE", "images/inventoryimages/wiltolion_torus.tex"),
    Asset("ATLAS", "images/inventoryimages/wiltolion_torus.xml"),
}

local STRINGS = _G.STRINGS

-- =========================================================
-- 3. STRINGS (Textos e info del menú/compendio)
-- =========================================================
STRINGS.CHARACTER_TITLES.wiltolion = "The Sun Lion"
STRINGS.CHARACTER_NAMES.wiltolion = "Wiltolion"
STRINGS.CHARACTER_DESCRIPTIONS.wiltolion = "*Made of sun\n*And lions\n*well, not lions but he is kinda one"
STRINGS.CHARACTER_QUOTES.wiltolion = "\"I will take care of you\""
STRINGS.CHARACTER_SURVIVABILITY.wiltolion = "Slim"

-- Nombres internos
STRINGS.NAMES.WILTOLION = "Wiltolion"
STRINGS.SKIN_NAMES.wiltolion_none = "Wiltolion"

-- ¡NUEVO! Habilidades listadas en el compendio
STRINGS.CHARACTER_DETAILS.wiltolion = "- Emits light and heat when well fed\n- Passively cooks food in his inventory\n- Restores sanity and durability using magic"

-- ¡NUEVO! Biografía del compendio
STRINGS.CHARACTER_ABOUTME.wiltolion = "A radiant anomaly bound to a feline form, Wiltolion wanders the Constant bringing the warmth of a star wherever he steps."

-- Necesitamos el nombre del ítem en el cliente para la interfaz
STRINGS.NAMES.WILTOLION_TORUS = "Sun Torus"

-- =========================================================
-- INFO DETALLADA DEL COMPENDIO (Cumpleaños, Comida, Lore)
-- =========================================================
if not _G.STRINGS.CHARACTER_BIOS then
    _G.STRINGS.CHARACTER_BIOS = {}
end

_G.STRINGS.CHARACTER_BIOS.wiltolion = {
    { 
        title = "Birthday", 
        desc = "december 12" -- ¡Pon el cumpleaños que prefieras!
    },
    { 
        title = "Favorite Food", 
        desc = "Wiltolion likes any yummy things, but Dragonpie makes his mane shine extra bright!" -- O la comida que elijas
    },
    { 
        title = "Cosmos", -- O puedes llamarlo "Possessions", "History", etc.
        desc = "Wiltolion claims he came from somewhere beyond the cosmic event horizon, a distant, silent region at the farthest edges of the universe, where light itself struggles to return.\nNo astronomer has ever observed such a place.\nNo telescope has ever reached that far.\nAnd yet, Wiltolion speaks of it as if it were home."
    }
}

-- =========================================================
-- 4. CONFIGURACIÓN DEL COMPENDIO (Ítems Iniciales)
-- =========================================================
-- Registrar el atlas para la interfaz
RegisterInventoryItemAtlas("images/inventoryimages/wiltolion_torus.xml", "wiltolion_torus.tex")

-- Decirle al menú con qué empieza el personaje
if _G.TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT == nil then
    _G.TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT = {}
end
_G.TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.WILTOLION = {
    "wiltolion_torus",
    "yellowstaff",
}

-- Decirle al menú dónde encontrar la imagen de tu ítem customizado
if _G.TUNING.STARTING_ITEM_IMAGE_OVERRIDE == nil then
    _G.TUNING.STARTING_ITEM_IMAGE_OVERRIDE = {}
end
_G.TUNING.STARTING_ITEM_IMAGE_OVERRIDE.wiltolion_torus = {
    atlas = "images/inventoryimages/wiltolion_torus.xml",
    image = "wiltolion_torus.tex",
}

-- =========================================================
-- 5. SKINS Y REGISTRO
-- =========================================================
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