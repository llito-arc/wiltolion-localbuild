local GLOBAL = GLOBAL
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- ==========================================
-- CHARACTER STRINGS
-- ==========================================
STRINGS.CHARACTER_TITLES.wiltolion = "The Sun Lion"
STRINGS.CHARACTER_NAMES.wiltolion = "Wiltolion"
STRINGS.CHARACTER_DESCRIPTIONS.wiltolion = "*Made of sun\n*And lions\n*well, not lions but he is kinda one"
STRINGS.CHARACTER_QUOTES.wiltolion = "\"I will take care of you\""
STRINGS.CHARACTER_SURVIVABILITY.wiltolion = "Slim"

STRINGS.CHARACTERS.WILTOLION = require("speech_wiltolion")
STRINGS.NAMES.WILTOLION = "Wiltolion"
STRINGS.SKIN_NAMES.wiltolion_none = "Wiltolion"

-- ==========================================
-- CUSTOM CHARACTER DIALOGUES
-- ==========================================
local wiltolion_descriptions = {
    GENERIC = "I say! Is that a celestial body or a feline? Scientifically speaking, he's adorable.", 
    WILLOW = "Finally, a friend who appreciates a good fire! You burn bright, whiskers.",
    WOLFGANG = "Is tiny sun-cat! Do not worry little friend, Wolfgang will protect you from monsters!",
    WENDY = "He shines so brightly... it makes the shadows look deeper. Doesn't it, Abigail?",
    WX78 = "WARNING: SOLAR ORGANISM DETECTED. DO NOT OVERHEAT MY CIRCUITS, MINION.",
    WICKERBOTTOM = "Classification: Panthera solaris. A fascinating specimen, but please keep your volume down.",
    WOODIE = "Look at you glow, eh? Just keep those sparks away from the timber, buddy.",
    WAXWELL = "A child of the stars? Hmph. I certainly didn't write *you* into the script.",
    WIGFRID = "A glöriöus beast of legend! Come, sun-cub! We shall vanquish the darkness together!",
    WEBBER = "Wow! He's like a big, fuzzy nightlight! Can we play tag, Wiltolion?",
    WINONA = "Hey there, sparks. If you've got that much energy, grab a wrench and help out.",
    WARLY = "Mon dieu! You are radiating heat like a perfect oven. Just don't burn the soufflé!",
    WORTOX = "Hyuyu! A starry soul comes to visit! Are you here for pranks or snacks?",
    WORMWOOD = "Sun Friend! Warm... belly feels good.",
    WURT = "You too bright, florp! Do not dry out my scales, okay?",
    WALTER = "A Sun-lion? That's definitely going in my field guide!",
    WANDA = "So much time ahead of you, little star. Try not to waste it.",
}

local torus_descriptions = {
    GENERIC = "A miniature sun captured in a ring.",
    WILLOW = "It's so warm and cozy! I want to burn things with it.",
    WOLFGANG = "Is mighty glowing crown! Too small for Wolfgang's head.",
    WENDY = "A fleeting star, trapped in an endless circle.",
    WX78 = "WARNING: UNSTABLE ENERGY CONTAINMENT DETECTED.",
    WICKERBOTTOM = "A fascinating application of solar containment.",
    WOODIE = "That's a bright little tuque, eh?",
    WAXWELL = "An arrogant display of light.",
    WIGFRID = "The glowing helm of the sun-cub!",
    WEBBER = "It's a glowing ring! Can we jump through it?",
    WINONA = "That must be some high-voltage headwear.",
    WARLY = "It smells faintly of toasted marshmallows.",
    WORTOX = "A shiny ring for a shiny thing!",
    WORMWOOD = "Bright star ring. Very warm.",
    WURT = "Bright ring hurt my eyes, florp.",
    WALTER = "A magical glowing crown! Just like in the stories.",
    WANDA = "A star whose time hasn't run out yet."
}

local buddy_descriptions = {
    GENERIC = "A fascinating specimen of pure light.",
    WILLOW = "A flying light! I wonder if it can start fires!",
    WOLFGANG = "Tiny shiny bug. Wolfgang will try not to crush it.",
    WENDY = "A fleeting spark, doomed to fade into the darkness...",
    WX78 = "WARNING: UNREGISTERED LIGHT EMITTER.",
    WICKERBOTTOM = "A bioluminescent insectoid, though its thermal signature is anomalous.",
    WOODIE = "That's quite a bright little critter, eh?",
    WAXWELL = "Ugh. It's far too bright and irritating.",
    WIGFRID = "A radiant companion for battle!",
    WEBBER = "Whoa! A shiny fly! Can we keep it?",
    WINONA = "Looks like a flying spark plug with wings.",
    WARLY = "It provides excellent lighting for my cooking.",
    WORTOX = "Hyuyu! A little dancing light!",
    WORMWOOD = "Buzzing light bug!",
    WURT = "Shiny bug hurts eyes, florp!",
    WALTER = "A new species of fireproof firefly! I should write this down.",
    WANDA = "So much energy... its lifespan must be incredibly short."
}

local sundrop_descriptions = {
    GENERIC = "A concentrated drop of daylight.",
    WILLOW = "It's so bright! I want to set something on fire with it!",
    WOLFGANG = "seems like a tiny glowing potato. But is too hot to eat!",
    WENDY = "Even this bright light will eventually fade to black...",
    WX78 = "WARNING: UNCONTAINED SOLAR ENERGY DETECTED.",
    WICKERBOTTOM = "A condensed particle of solar radiation. Fascinating.",
    WOODIE = "Keeps the shadows away, eh?",
    WAXWELL = "A detestable amount of cheerfulness in one drop.",
    WIGFRID = "A glowing tear shed by the sun goddess!",
    WEBBER = "It's so warm and fuzzy to hold!",
    WINONA = "Pure, unadulterated solar power.",
    WARLY = "A bit too hot to use as a garnish, I'm afraid.",
    WORTOX = "A soul made of sunshine! Hyuyu!",
    WORMWOOD = "yummy sky drop.",
    WURT = "Glurgh! It hurts my eyes!",
    WALTER = "Wow! A real piece of the sun! I need a jar for this.",
    WANDA = "Time is ticking rapidly for this little spark."
}

local wilto_descriptions = {
    GENERIC = "He looks a bit pale... and pretty sad. I should keep an eye on him.",
    WILLOW = "Ugh, he's so gloomy. He needs a good fire to cheer him up!",
    WOLFGANG = "Is tiny sad boy! Wolfgang will protect him and make him smile!",
    WENDY = "His soul weeps, just like mine... but I sense he is merely an echo.",
    WX78 = "SADNESS DETECTED. FLESHLING DUPLICATE LACKS EFFICIENCY.",
    WICKERBOTTOM = "A melancholy youth. Or rather, a fascinating facsimile of one.",
    WOODIE = "Looks like he could use a good stack of flapjacks, eh?",
    WAXWELL = "Another tragic, hollow figure? This isn't my doing, for once.",
    WIGFRID = "Cheer up, little squire! A glöriöus battle will lift yöur spirits!",
    WEBBER = "He looks so lonely... Do you want to play with us?",
    WINONA = "Chin up, kid. Hard work is the best cure for the blues.",
    WARLY = "The poor garçon looks famished. I must cook him a warm, comforting soup.",
    WORTOX = "Hyuyu! A dreary echo, meek and pale! Why so blue, frail mortal tale?",
    WORMWOOD = "Sad friend. Needs water? Or sun?",
    WURT = "Why human boy look so droopy, florp?",
    WALTER = "Cheer up, friend! A good scout never lets the wilderness get them down!",
    WANDA = "He seems stuck in a very melancholy moment... I know the feeling.",
}

local journal_descriptions = {
    GENERIC = "A floating notebook full of... highly unscientific doodles.",
    WILLOW = "It's full of silly drawings. I wonder if the pages burn nice and bright?",
    WOLFGANG = "Is tiny book with many funny pictures! Wolfgang likes the lion ones.",
    WENDY = "A ledger of fleeting, colorful joys... destined to fade into nothingness.",
    WX78 = "PRIMITIVE ANALOG DATA STORAGE. FULL OF CRUDE SCHEMATICS.",
    WICKERBOTTOM = "A rather chaotic scrapbook. The spelling is atrocious, but the illustrations are spirited.",
    WOODIE = "Lots of drawings of trees in here. None of 'em chopped down, though.",
    WAXWELL = "A child's scrapbook. Spare me the finger paintings, please.",
    WIGFRID = "An epic saga öf bravery, töld entirely in cölörful scribbles!",
    WEBBER = "Wow! Look at all the cool monster drawings! Can we draw a spider next?",
    WINONA = "Looks like a little blueprint for playtime. Pretty cute, actually.",
    WARLY = "Ah, a recipe book for grand adventures! Sadly lacking in actual recipes, though.",
    WORTOX = "Scribbles and scraps and glowing pages! A toy to last through all the ages! Hyuyu!",
    WORMWOOD = "Flappy paper thing. Has pictures of friends inside.",
    WURT = "Book has funny pictures! Not for eating, just for looking, florp.",
    WALTER = "An adventure log! I should show him my Pine Pioneer survival manual!",
    WANDA = "Such a vibrant record of the present moment... I hope these memories last.",
}

local pylon_descriptions = {
    GENERIC = "A monument of celestial stone. It hums with solar energy.", 
    WILLOW = "It's like a giant, eternal matchstick! I love it.",
    WOLFGANG = "Mighty sun-flower is strong like Wolfgang! Good for quick travels.",
    WENDY = "A beacon of light in this endless dark.",
    WX78 = "FAST TRAVEL NODE ACQUIRED. SOLAR CHARGING STATION NOMINAL.",
    WICKERBOTTOM = "A remarkable solar-powered transit mechanism. The masonry is quite ancient.",
    WOODIE = "That's a lot of magic rock, eh? Saves me a long walk, at least.",
    WAXWELL = "They left their cosmic toys scattered about. How predictably messy.",
    WIGFRID = "A pörtal forged by the sun göds themselves! To battle we fly!",
    WEBBER = "Whoa... it's a giant starry flower! Can we go for a ride?",
    WINONA = "Solid stonework and self-sustaining energy. That's a good piece of machinery.",
    WARLY = "It radiates a warmth that reminds me of a slow-cooking hearth.",
    WORTOX = "Hyuyu! A stepping stone through the sky! Weeee!",
    WORMWOOD = "Big Sun Flower! Safe place.",
    WURT = "Magic rock-flower is too bright, florp! But it takes us home fast.",
    WALTER = "A genuine Celestial Pylon! Woby, get ready for a fast trip!",
    WANDA = "A crude manipulation of space, but it saves precious time.",
}

-- =========================================================
-- CHARACTER DESCRIPTIONS FOR WILTOLION THINGY
-- =========================================================
local thingy_descriptions = {
    GENERIC = "An unusual arachnid. It seems to weave light instead of silk.",
    WILLOW = "Usually I'd burn any spider, but this one is actually helpful.",
    WOLFGANG = "Wolfgang is confused. Is scary spider, but makes Wolfgang feel strong!",
    WENDY = "It mends the flesh, but the heart remains forever broken.",
    WX78 = "BIOLOGICAL REPAIR DRONE DETECTED.",
    WICKERBOTTOM = "A fascinating mutation of Araneae, possessing restorative bioluminescence.",
    WOODIE = "That's a weird looking glowing bug, eh?",
    WAXWELL = "Someone went through a lot of trouble to make a pest look pretty.",
    WIGFRID = "A radiant little beast to mend our battle wounds!",
    WEBBER = "Wow! A shiny new spider friend! Can we keep it?",
    WINONA = "Handy little critter to have around when you take a beating.",
    WARLY = "Its presence is quite comforting, much like a warm hearth.",
    WORTOX = "Hyuyu! A little web-spinner that heals instead of bites!",
    WORMWOOD = "Bright webby bug helps friends.",
    WURT = "Glowing web-bug! Don't bite, florp!",
    WALTER = "A bioluminescent healing spider! I need to sketch this in my journal.",
    WANDA = "A useful little creature. Healing up saves precious time."
}

for char, line in pairs(thingy_descriptions) do
    if STRINGS.CHARACTERS[char] then
        if not STRINGS.CHARACTERS[char].DESCRIBE then STRINGS.CHARACTERS[char].DESCRIBE = {} end
        STRINGS.CHARACTERS[char].DESCRIBE.WILTOLION_THINGY = line
    end
end

-- Inyectar de forma segura los diálogos
for char, line in pairs(journal_descriptions) do
    if STRINGS.CHARACTERS[char] then
        if not STRINGS.CHARACTERS[char].DESCRIBE then STRINGS.CHARACTERS[char].DESCRIBE = {} end
        STRINGS.CHARACTERS[char].DESCRIBE.WILTO_JOURNAL = line
    end
end
for char, line in pairs(wilto_descriptions) do
    if STRINGS.CHARACTERS[char] then
        if not STRINGS.CHARACTERS[char].DESCRIBE then STRINGS.CHARACTERS[char].DESCRIBE = {} end
        STRINGS.CHARACTERS[char].DESCRIBE.WILTOLION_WILTO = line
    end
end
for char, line in pairs(buddy_descriptions) do
    if STRINGS.CHARACTERS[char] then
        if not STRINGS.CHARACTERS[char].DESCRIBE then STRINGS.CHARACTERS[char].DESCRIBE = {} end
        STRINGS.CHARACTERS[char].DESCRIBE.WILTOLION_BUDDY = line
    end
end
for char, line in pairs(torus_descriptions) do
    if STRINGS.CHARACTERS[char] then
        if not STRINGS.CHARACTERS[char].DESCRIBE then STRINGS.CHARACTERS[char].DESCRIBE = {} end
        STRINGS.CHARACTERS[char].DESCRIBE.WILTOLION_TORUS = line
    end
end
for char, line in pairs(wiltolion_descriptions) do
    if STRINGS.CHARACTERS[char] then
        if not STRINGS.CHARACTERS[char].DESCRIBE then STRINGS.CHARACTERS[char].DESCRIBE = {} end
        STRINGS.CHARACTERS[char].DESCRIBE.WILTOLION = line
    end
end
for char, line in pairs(sundrop_descriptions) do
    if STRINGS.CHARACTERS[char] then
        if not STRINGS.CHARACTERS[char].DESCRIBE then STRINGS.CHARACTERS[char].DESCRIBE = {} end
        STRINGS.CHARACTERS[char].DESCRIBE.WILTOLION_SUNDROP = line
    end
end
for char, line in pairs(pylon_descriptions) do
    if STRINGS.CHARACTERS[char] then
        if not STRINGS.CHARACTERS[char].DESCRIBE then STRINGS.CHARACTERS[char].DESCRIBE = {} end
        STRINGS.CHARACTERS[char].DESCRIBE.WILTOLION_PYLON = line
    end
end

-- ==========================================
-- CRAFTABLE ITEM STRINGS
-- ==========================================
STRINGS.NAMES.WILTOLION_TORUS = "Sun Torus"
STRINGS.RECIPE_DESC.WILTOLION_TORUS = "The crown of a star."
STRINGS.CHARACTERS.WILTOLION.DESCRIBE.WILTOLION_TORUS = "My own space donut!"

STRINGS.NAMES.WILTOLION_BUDDY = "Sun fly"
STRINGS.RECIPE_DESC.WILTOLION_BUDDY = "A small spark of loyal and blazing life."
STRINGS.CHARACTERS.WILTOLION.DESCRIBE.WILTOLION_BUDDY = "My little dancing spark!"

STRINGS.NAMES.WILTOLION_SUNDROP = "Solar Energy"
STRINGS.RECIPE_DESC.WILTOLION_SUNDROP = "A drop of pure sunlight."
STRINGS.CHARACTERS.WILTOLION.DESCRIBE.WILTOLION_SUNDROP = "A tiny piece of the sky star!"

STRINGS.NAMES.WILTO_JOURNAL = "Adventure Journal"
STRINGS.RECIPE_DESC.WILTO_JOURNAL = "A guide to command your loyal friend."
STRINGS.CHARACTERS.WILTOLION.DESCRIBE.WILTO_JOURNAL = "It's full of cool doodles and a super fun plan for our next adventure!"

STRINGS.NAMES.WILTOLION_WILTO = "Wilto"
STRINGS.NAMES.WILTOLION_WILTO_BUILDER = "Echo of Wilto"
STRINGS.RECIPE_DESC.WILTOLION_WILTO_BUILDER = "Summon an echo of Wilto."
STRINGS.CHARACTERS.WILTOLION.DESCRIBE.WILTOLION_WILTO_BUILDER = "A comforting reminder of Him."
STRINGS.CHARACTERS.WILTOLION.DESCRIBE.WILTOLION_WILTO = "I know you're just an echo... but I'm still so glad you're here!"

STRINGS.NAMES.WILTOLION_THINGY = "Sun Spider"
STRINGS.RECIPE_DESC.WILTOLION_THINGY = "Summon a healing companion of pure light."
STRINGS.CHARACTERS.WILTOLION.DESCRIBE.WILTOLION_THINGY = "Keep shining, my little friend!"

STRINGS.NAMES.WILTOLION_PYLON = "Sunflower Rock Pylon"
STRINGS.RECIPE_DESC.WILTOLION_PYLON = "A statue that represents hope."
STRINGS.CHARACTERS.WILTOLION.DESCRIBE.WILTOLION_PYLON = "It's one of those super cool statues! It wasn’t easy at all to recreate it!" 

GLOBAL.STRINGS.UI.HUD.PYLON_TOOCLOSE = "It's too close to another Pylon!"

-- Añadimos los textos para que no aparezcan códigos en la UI
--STRINGS.SKILLTREE.WILTOLION = {
--    -- Títulos de las Ramas (ORDERS)
--    CATEGORY_CORE = "NÚCLEO SOLAR",
--    CATEGORY_CHASSIS = "CHASIS",
--    CATEGORY_UTILITY = "UTILIDAD",
--    CATEGORY_ALLEGIANCE = "AFILIACIÓN",

--    -- Ejemplo para una habilidad específica
--    -- El nombre debe coincidir con el ID que pusiste en el .lua (ej: wiltolion_core_1)
--    WILTOLION_CORE_1_TITLE = "Combustión Eficiente I",
--    WILTOLION_CORE_1_DESC = "Tu núcleo consume el hambre un poco más lento.",
--}