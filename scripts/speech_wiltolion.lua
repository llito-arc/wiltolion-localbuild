-----------------------------------
-- This file is the template for other speech files. Once a new string is added here, simply run PropagateSpeech.bat
-- If you are adding strings that are character specific, or not required by all characters, you will still need to add the strings to speech_wilson.lua,
-- and then add the context string to speech_from_generic.lua. Once you run the PropagateSpeech.bat, you can go into your character's speech file and simply uncomment the new lines.
--
-- There are some caveats about maintaining sane formatting in this file.
--      -No single line lua tables
--      -Opening and closing brackets should be on their own line
--      -If wilson's speech has X unnamed strings in a table, then all other speech files must have at least X unnamed strings in that context too (example, CHESSPIECE_MOOSEGOOSE has 1 string in wilson, but 2 in wortox), this requirement could be relaxed if required by motifying po_vault.lua)

return {
	ACTIONFAIL =
	{
        GENERIC =
        {
            ITEMMIMIC = "Hey! That's not a real toy!",
        },

        ACTIVATE =
        {
            LOCKED_GATE = "The big door is being a meanie and won't open!",
            HOSTBUSY = "Mr. Bird-man is playing with someone else right now.",
            CARNIVAL_HOST_HERE = "I know the funny bird-man is hiding around here somewhere!",
            NOCARNIVAL = "Aww, the carnival birds flew away to another party.",
            EMPTY_CATCOONDEN = "Oh no, there aren't any fuzzy-kitties hiding in there!",
            KITCOON_HIDEANDSEEK_NOT_ENOUGH_HIDERS = "We need more little kitties to play a real game of hide and seek!",
            KITCOON_HIDEANDSEEK_NOT_ENOUGH_HIDING_SPOTS = "There's nowhere for the kitties to hide their fluffy tails!",
            KITCOON_HIDEANDSEEK_ONE_GAME_PER_DAY = "The fuzzy-kitties are too sleepy for another game today.",
            MANNEQUIN_EQUIPSWAPFAILED = "That toy is way too big for the wooden man!",
            PILLOWFIGHT_NO_HANDPILLOW = "I need a soft squishy pillow if I want to play the hitting-game!",
            NOTMYBERNIE = "That bear-toy is just taking a regular nap.",
            NOTMERM = "I can't talk to the fishy-frogs! They just say 'ribbit'!",
            NOKELP = "only_used_by_wurt",
            HASMERMLEADER = "only_used_by_wurt",
        },
        APPLYELIXIR =
        {
            TOO_SUPER = "Whoa! That magic juice is way too spicy for a star-cub!",
            NO_ELIXIRABLE = "only_used_by_wendy",
        },
        APPLYMODULE =
        {
            COOLDOWN = "only_used_by_wx78",
            NOTENOUGHSLOTS = "only_used_by_wx78",
        },
        APPRAISE =
        {
            NOTNOW = "The bird-man is too busy to look at my shiny toys right now.",
        },
        ATTUNE =
        {
            NOHEALTH = "My inner light is too dim to make a sparky-link right now.",
        },
        BATHBOMB =
        {
            GLASSED = "It's all shiny and hard! I can't make bubbles here.",
            ALREADY_BOMBED = "I already used my fizzy-pop toy there! Sharing is caring.",
        },
        BEDAZZLE =
        {
            BURNING = "only_used_by_webber",
            BURNT = "only_used_by_webber",
            FROZEN = "only_used_by_webber",
            ALREADY_BEDAZZLED = "only_used_by_webber",
        },
        BEGIN_QUEST =
        {
            ONEGHOST = "only_used_by_wendy",
        },
        BUILD =
        {
            MOUNTED = "I can't reach the ground from all the way up here!",
            HASPET = "But I already have a best friend!",
            TICOON = "My sniffer-kitty gets jealous if I follow another one!",
            BUSY_STATION = "I have to wait my turn to play with the magic table.",
        },
        CARNIVALGAME_FEED =
        {
            TOO_LATE = "Oh no! I wasn't fast enough with the bug-snacks!",
        },
        CAST_POCKETWATCH =
        {
            GENERIC = "only_used_by_wanda",
            REVIVE_FAILED = "only_used_by_wanda",
            WARP_NO_POINTS_LEFT = "only_used_by_wanda",
            SHARD_UNAVAILABLE = "only_used_by_wanda",
            NO_TELEPORT_ZONE = "only_used_by_wanda",
        },
        CAST_SPELLBOOK =
        {
            NO_TOPHAT = "only_used_by_waxwell",
        },
        CASTAOE =
        {
            NO_MAX_SANITY = "only_used_by_waxwell",
            NOT_ENOUGH_EMBERS = "only_used_by_willow",
            NO_TARGETS = "only_used_by_willow",
            CANT_SPELL_MOUNTED = "only_used_by_willow",
            SPELL_ON_COOLDOWN = "only_used_by_willow",
            NO_BATTERY = "only_used_by_winona",
            NO_CATAPULTS = "only_used_by_winona",
        },
        CASTSPELL =
        {
            TERRAFORM_TOO_SOON = "only_used_by_wurt",
        },
        CHANGEIN =
        {
            GENERIC = "I like my fuzzy mane just the way it is!",
            BURNING = "The closet is having a tiny supernova! I'm not going near that!",
            INUSE = "Someone else is in there playing dress-up. I'll wait!",
            NOTENOUGHHAIR = "The fuzzy monster doesn't have enough fur for a haircut yet!",
            NOOCCUPANT = "I can't play dress-up with nobody in the chair!",
        },
        CHARGE_FROM =
        {
            NOT_ENOUGH_CHARGE = "Aww, the machine is all out of sky-sparks.",
            CHARGE_FULL = "It's completely full of zappy-magic!",
        },
        COMPARE_WEIGHABLE =
        {
            FISH_TOO_SMALL = "This splashy-friend is way too tiny to win!",
            OVERSIZEDVEGGIES_TOO_SMALL = "My giant snack isn't heavy enough to beat that one!",
        },
        CONSTRUCT =
        {
            INUSE = "Someone beat me to the building-blocks!",
            NOTALLOWED = "It won't fit! Like a square peg in a round nebula.",
            EMPTY = "I need stuff to make the thing!",
            MISMATCH = "Whoopsie! Those aren't the right instructions.",
            NOTREADY = "The magic toy is still too grumpy to come out and play.",
        },
        COOK =
        {
            GENERIC = "The core is cold, and my magic cannot feed the pot alone!",
            INUSE = "Two chefs in the kitchen makes for a messy nebula!",
            TOOFAR = "It's too far away!",
        },
        DEPLOY = {
            HERMITCRAB_RELOCATE = "It's empty, I shell try again later.",
        },
        DIRECTCOURIER_MAP =
        {
            NOTARGET = "only_used_by_walter",
        },
		DISMANTLE =
		{
			COOKING = "only_used_by_warly",
			INUSE = "only_used_by_warly",
			NOTEMPTY = "only_used_by_warly",
        },
        DISMANTLE_POCKETWATCH =
        {
            ONCOOLDOWN = "only_used_by_wanda",
        },
        DRAW =
        {
            NOIMAGE = "I can't draw what I can't see! My imagination needs a peek first.",
        },
        ENTER_GYM =
        {
            NOWEIGHT = "only_used_by_wolfang",
            UNBALANCED = "only_used_by_wolfang",
            ONFIRE = "only_used_by_wolfang",
            SMOULDER = "only_used_by_wolfang",
            HUNGRY = "only_used_by_wolfang",
            FULL = "only_used_by_wolfang",
        },
        FILL_OCEAN =
        {
            UNSUITABLE_FOR_PLANTS = "For some reason, plants don't like salt water.",
        },
        FISH_OCEAN =
		{
			TOODEEP = "This rod wasn't made for deep sea fishing.",
		},
        GIVE =
        {
            GENERIC = "This thingy doesn't want to play in that spot!",
            DEAD = "Since they're all poofed out, I'll just keep this for later.",
            SLEEPING = "Wakey wakey! Oh... they're still in sleepy-bye land.",
            BUSY = "I'll wait until they're done with their serious work!",
            ABIGAILHEART = "I thought the ghost-flower would like it. Hmph.",
            GHOSTHEART = "Maybe this isn't the right way to make a new sparkle-friend.",
            NOTGEM = "That's not a shiny space-candy! Where's the glow?",
            WRONGGEM = "This rock doesn't have the right star-power for this!",
			NOGENERATORSKILL = "I'm not sticking that in there!",
            NOTSTAFF = "This stick is the wrong shape for this game.",
            MUSHROOMFARM_NEEDSSHROOM = "It needs a little mushy-friend to start growing!",
            MUSHROOMFARM_NEEDSLOG = "This farm needs a log that's still got some wiggle in it!",
            MUSHROOMFARM_NOMOONALLOWED = "These mushrooms seem to resist being planted!",
            SLOTFULL = "No more room! It's already full of toys.",
            FOODFULL = "The plate is already full of yummy snacks!",
            NOTDISH = "Hey, that's not yummy! It won't want to munch on that.",
            DUPLICATE = "We already played this game! I want a new one.",
            NOTSCULPTABLE = "Even my star-magic can't turn this into a statue!",
            NOTATRIUMKEY = "It's not the right shape for the spooky lock-hole.",
            CANTSHADOWREVIVE = "The shadows won't let it come back to play.",
            WRONGSHADOWFORM = "It's all messy! Like a constellation with the wrong stars.",
            NOMOON = "I can't see the little rock friend in the sky! It won't work.",
			PIGKINGGAME_MESSY = "My play-area is too messy! I gotta tidy up first.",
			PIGKINGGAME_DANGER = "It's too scary right now! The bullies are around.",
			PIGKINGGAME_TOOLATE = "Aww, did I miss the party? It's too late!",
			CARNIVALGAME_INVALID_ITEM = "I need to buy some tokens.",
			CARNIVALGAME_ALREADY_PLAYING = "A game is already underway.",
            SPIDERNOHAT = "I can't fit them together in my pocket",
            TERRARIUM_REFUSE = "Maybe I should experiment with different kinds of fuel...",
            TERRARIUM_COOLDOWN = "I suppose the tree has to grow back before we can give it anything.",
            NOTAMONKEY = "I don't speak monkey.",
            QUEENBUSY = "She seems busy.",
        },
        GIVE_TACKLESKETCH =
		{
			DUPLICATE = "I've already tackled this one.",
        },
        GIVETOPLAYER =
        {
            FULL = "Your toy-bags are all stuffed! No room for more stardust!",
            DEAD = "Oh no, you turned into a cloud! I'll hold this until you're solid again.",
            SLEEPING = "You're off visiting the Sandman in a nebula.",
            BUSY = "I'll try again when they stop being so busy.",
        },
        GIVEALLTOPLAYER =
        {
            FULL = "Your pockets are all full of stuff! Where would this even go?",
            DEAD = "You poofed away! I'll just keep these treats in my mane.",
            SLEEPING = "Shhh! They're busy dreaming of space-donuts.",
            BUSY = "I'll wait! Grown-up work looks very, very tiring.",
        },
        HARVEST =
        {
            DOER_ISNT_MODULE_OWNER = "It doesn't seem interested in a scientific discussion.",
        },
        HEAL =
        {
            NOT_MERM = "I guess it only works on merms.",
        },
        HERD_FOLLOWERS =
        {
            WEBBERONLY = "They won't listen to me, but they might listen to Webber.",
        },
        HITCHUP =
        {
            NEEDBEEF = "If I had a bell I could befriend a beefalo.",
            NEEDBEEF_CLOSER = "My beefalo buddy is too far away.",
            BEEF_HITCHED = "My beefalo is already hitched up.",
            INMOOD = "My beefalo seems to be too lively.",
        },
		LOOKAT = --fail strings for close inspection
		{
			-- Winona specific
			ROSEGLASSES_INVALID = "only_used_by_winona",
			ROSEGLASSES_COOLDOWN = "only_used_by_winona",
            ROSEGLASSES_DISMISS = "only_used_by_winona",
            ROSEGLASSES_STUMPED = "only_used_by_winona",
			--
		},
        LOWER_SAIL_FAIL =
        {
            "Whoops!",
            "We're not slowing down!",
            "Failure is success in progress!",
        },
        MARK =
        {
            ALREADY_MARKED = "I've already made my pick.",
            NOT_PARTICIPANT = "I've got no steak in this contest.",
        },
        MOUNT =
        {
            TARGETINCOMBAT = "The big smelly cow is having a tantrum! I'm staying down here.",
            INUSE = "Hey! I wanted the front seat on the fuzzy monster!",
			SLEEPING = "Time to wake up!",
        },
        OCEAN_FISHING_POND =
		{
			WRONGGEAR = "This rod wasn't made for pond fishing.",
		},
		OPEN_CRAFTING =
		{
            PROFESSIONALCHEF = "I'm not a fancy enough chef for that.",
			SHADOWMAGIC = "That's not science.",
		},
        PICK =
        {
            NOTHING_INSIDE = "It's empty.",
			STUCK = "It's stuck.",
        },
        PICKUP =
        {
			RESTRICTION = "My paws aren't big enough for that toy yet!",
			INUSE = "I cant play with that now, I have to wait my turn!",
            NOTMINE_SPIDER = "only_used_by_webber",
            NOTMINE_YOTC =
            {
                "You're not my carrat.",
                "OW, it bit me!",
            },
			NO_HEAVY_LIFTING = "only_used_by_wanda",
            FULL_OF_CURSES = "I'm not touching that.",
        },
        PLANTREGISTRY_RESEARCH_FAIL =
        {
            GENERIC = "I have nothing left to learn.",
            FERTILIZER = "I'd rather not know anything further.",
        },
        POUR_WATER =
        {
            OUT_OF_WATER = "Drat, out of water.",
        },
        POUR_WATER_GROUNDTILE =
        {
            OUT_OF_WATER = "My watering can ran dry.",
        },
        --wickerbottom specific action
        READ =
        {
            GENERIC = "only_used_by_wickerbottom",
            NOBIRDS = "only_used_by_wickerbottom",
            NOWATERNEARBY = "only_used_by_waxwell_and_wicker",
            TOOMANYBIRDS = "only_used_by_waxwell_and_wicker",
            WAYTOOMANYBIRDS = "only_used_by_waxwell_and_wicker",
            BIRDSBLOCKED = "only_used_by_waxwell_and_wicker",
            NOFIRES =       "only_used_by_waxwell_and_wicker",
            NOSILVICULTURE = "only_used_by_waxwell_and_wicker",
            NOHORTICULTURE = "only_used_by_waxwell_and_wicker",
            NOTENTACLEGROUND = "only_used_by_waxwell_and_wicker",
            NOSLEEPTARGETS = "only_used_by_waxwell_and_wicker",
            TOOMANYBEES = "only_used_by_waxwell_and_wicker",
            NOMOONINCAVES = "only_used_by_waxwell_and_wicker",
            ALREADYFULLMOON = "only_used_by_waxwell_and_wicker",
            -- rifts5.1
            DEADBIRDS = "only_used_by_waxwell_and_wicker",
        },
		REMOTE_TELEPORT =
		{
			NOSKILL = "only_used_by_winona",
			NODEST = "only_used_by_winona",
		},
        REMOVEMODULES =
        {
            NO_MODULES = "only_used_by_wx78",
        },
        REPAIR =
        {
            WRONGPIECE = "That's not where the puzzle piece goes! Hmph!",
        },
        REPLATE =
        {
            MISMATCH = "This bowl doesn't match! The colors are all wrong.",
            SAMEDISH = "One plate is enough for a solar snack!",
        },
        ROW_FAIL =
        {
            BAD_TIMING0 = "My splashy-sticks are too fast!",
            BAD_TIMING1 = "The rhythm of the stars is wonky!",
            BAD_TIMING2 = "Aww, my paws slipped again!",
        },
		RUMMAGE =
		{
			GENERIC = "My paws won't let me do that!",
			INUSE = "They're playing with the junk right now.",
            NOTMASTERCHEF = "I'm not a fancy enough chef for that.",
            NOTAMERM = "I don't think the merms would be happy about that.",
            NOTSOULJARHANDLER = "It's not my cup of tea.",
            RESTRICTED = "Case closed... to me.",
		},
        SADDLE =
        {
            TARGETINCOMBAT = "He's too busy being a bully to wear a comfy seat!",
        },
		SHAVE =
		{
			AWAKEBEEFALO = "He looks too grumpy for a haircut right now.",
			GENERIC = "I can't give that a makeover!",
			NOBITS = "It's already as smooth as a nightstone!",
            REFUSE = "Nooo, I like my mane just the way it is!",
            SOMEONEELSESBEEFALO = "I won't shave someone else's beefalo!",
		},
        SING_FAIL =
        {
            SAMESONG = "only_used_by_wathgrithr",
        },
        SLAUGHTER =
        {
            TOOFAR = "The zoomy-friend was too fast for me! Tag, you're it!",
        },
        START_CARRAT_RACE =
        {
            NO_RACERS = "I think I'm missing something here.",
        },
		STORE =
		{
			GENERIC = "My pockets are full of toys!",
			NOTALLOWED = "That doesn't want to go in there.",
			INUSE = "I should wait my turn! Patience is a virtue... I think.",
            NOTMASTERCHEF = "I'm not a fancy enough chef for that.",
            NOTSOULJARHANDLER = "I'm not soul'ed on it.",
            RESTRICTED = "Case closed... to me.",
		},
        TEACH =
        {
            --Recipes/Teacher
            KNOWN = "I already have that secret in my star-head!",
            CANTLEARN = "That's too complicated for a little cub like me.",

            --MapRecorder/MapExplorer
            WRONGWORLD = "This doodle-map is for a different galaxy!",

			--MapSpotRevealer/messagebottle
			MESSAGEBOTTLEMANAGER_NOT_FOUND = "I can't make anything out in this lighting!",--Likely trying to read messagebottle treasure map in caves

            STASH_MAP_NOT_FOUND = "I don't see an \"X marks the spot\". They must've forgotten to draw it.",-- Likely trying to read stash map  in world without stash                  
        },
		TELLSTORY =
		{
			GENERIC = "only_used_by_walter",
			NOT_NIGHT = "only_used_by_walter",
			NO_FIRE = "only_used_by_walter",
		},
		UNLOCK =
        {
            WRONGKEY = "That's the wrong key-toy for this lock!",
        },
        UPGRADE =
        {
            BEDAZZLED = "only_used_by_webber",
        },
        USEITEMON =
        {
            --GENERIC = "I can't use this on that!",

            --construction is PREFABNAME_REASON
            BEEF_BELL_INVALID_TARGET = "I couldn't possibly!",
            BEEF_BELL_ALREADY_USED = "This beefalo already belongs to someone else.",
            BEEF_BELL_HAS_BEEF_ALREADY = "I don't need a whole herd.",

			NOT_MINE = "This belongs to someone else.",

			CANNOT_FIX_DRONE = "It's too damaged to fix.",
        },
		USEKLAUSSACKKEY =
        {
            WRONGKEY = "Whoopsie! This jingle-key doesn't fit!",
            KLAUS = "I'm a bit busy playing tag with a giant scary goat right now!",
			QUAGMIRE_WRONGKEY = "I need to find a different shiny star-key.",
        },
        WRAPBUNDLE =
        {
            EMPTY = "I can't make a gift-surprise with nothing!",
        },
        WRITE =
        {
            GENERIC = "It's already a masterpiece! My scribbles wouldn't help.",
            INUSE = "Only one star-cub can doodle at a time!",
        },
        YOTB_STARTCONTEST =
        {
            DOESNTWORK = "I guess they don't support the arts here.",
            ALREADYACTIVE = "He must be busy with another contest somewhere.",
            NORESPONSE = "He must have wandered off.",
            RIGHTTHERE = "He's busy.",
        },
        YOTB_UNLOCKSKIN =
        {
            ALREADYKNOWN = "I'm seeing a familiar pattern... I've learned this already!",
        },
		CARVEPUMPKIN =
		{
			INUSE = "Looks like we had the same idea.",
			BURNING = "The flames are hurting me.",
		},
		DECORATESNOWMAN =
		{
			INUSE = "It's being snowmanned!",
			HASHAT = "I can't top that hat!",
			STACKEDTOOHIGH = "It's too high!",
			MELTING = "I can't! It's about to melt!",
		},
        MUTATE = 
        {
            NOGHOST = "only_used_by_wendy",
            NONEWMOON = "only_used_by_wendy",
            NOFULLMOON = "only_used_by_wendy",
            NOTNIGHT = "only_used_by_wendy",
            CAVE = "only_used_by_wendy",
        },
		MODSLINGSHOT =
		{
			NOSLINGSHOT = "only_used_by_walter",
		},
		POUNCECAPTURE =
		{
			MISSED = "Drat, I missed.",
		},
        DIVEGRAB =
        {
            MISSED = "Drat, I missed.",
        },

		-- Winter 2025
		SOAKIN =
		{
			NOSPACE = "Displace is not possible.",--there's someone in that space. there's no room there.
		},
    },

	ANNOUNCE_CANNOT_BUILD =
	{
		NO_INGREDIENTS = "It looks like I'm missing some important components.",
		NO_TECH = "This will need more scientific research!",
		NO_STATION = "I can't make it right now.",
	},

	ACTIONFAIL_GENERIC = "My paws won't let me do that!",
	ANNOUNCE_BOAT_LEAK = "The boat is crying! We're getting soggy!",
	ANNOUNCE_BOAT_SINK = "I'm going to turn into a sea-star! And not the cool kind!!",
    ANNOUNCE_PREFALLINVOID = "I'm sensing the gravity of the situation!",
	ANNOUNCE_DIG_DISEASE_WARNING = "There! I fixed the dirt-friend's boo-boo.", --removed
	ANNOUNCE_PICK_DISEASE_WARNING = "Pee-yew! Did a comet fart on this plant? It's stinky!", --removed
	ANNOUNCE_ADVENTUREFAIL = "Aww, I tripped on a nebula! Let's try that game again!",
    ANNOUNCE_MOUNT_LOWHEALTH = "The big fuzzy monster's inner glow is getting dim! He needs star-hugs!",

    --waxwell and wickerbottom specific strings
    ANNOUNCE_TOOMANYBIRDS = "only_used_by_waxwell_and_wicker",
    ANNOUNCE_WAYTOOMANYBIRDS = "only_used_by_waxwell_and_wicker",
    ANNOUNCE_NOWATERNEARBY = "only_used_by_waxwell_and_wicker",

	--waxwell specific
	ANNOUNCE_SHADOWLEVEL_ITEM = "only_used_by_waxwell",
	ANNOUNCE_EQUIP_SHADOWLEVEL_T1 = "only_used_by_waxwell",
	ANNOUNCE_EQUIP_SHADOWLEVEL_T2 = "only_used_by_waxwell",
	ANNOUNCE_EQUIP_SHADOWLEVEL_T3 = "only_used_by_waxwell",
	ANNOUNCE_EQUIP_SHADOWLEVEL_T4 = "only_used_by_waxwell",

    --wolfgang specific
    ANNOUNCE_NORMALTOMIGHTY = "only_used_by_wolfang",
    ANNOUNCE_NORMALTOWIMPY = "only_used_by_wolfang",
    ANNOUNCE_WIMPYTONORMAL = "only_used_by_wolfang",
    ANNOUNCE_MIGHTYTONORMAL = "only_used_by_wolfang",
    ANNOUNCE_EXITGYM = {
        MIGHTY = "only_used_by_wolfang",
        NORMAL = "only_used_by_wolfang",
        WIMPY = "only_used_by_wolfang",
    },

	ANNOUNCE_BEES = "Buzzz-off, spikey flies!",
	ANNOUNCE_BOOMERANG = "Ow! It came back for a hug too hard!",
	ANNOUNCE_CHARLIE = "The Big Dark is tickling me... and I don't like it!",
	ANNOUNCE_CHARLIE_ATTACK = "Ouch! The shadow bit my tail!",
	ANNOUNCE_CHARLIE_MISSED = "only_used_by_winona", --winona specific
	ANNOUNCE_COLD = "Brrr! I'm turning into a popsic-lion!",
	ANNOUNCE_HOT = "I'm having a super-nova meltdown!",
	ANNOUNCE_CRAFTING_FAIL = "I'm missing my magic bits and bobs for this toy!",
	ANNOUNCE_DEERCLOPS = "Something really big is stomping on our lands!",
	ANNOUNCE_CAVEIN = "The sky-ceiling is falling! It's a rock-alanche!",
	ANNOUNCE_ANTLION_SINKHOLE =
	{
		"The ground is destabilizing!",
		"A tremor!",
		"Terrible terralogical waves!",
	},
	ANNOUNCE_ANTLION_TRIBUTE =
	{
        "Allow me to pay tribute.",
        "A tribute for you, great Antlion.",
        "That'll appease it, for now...",
	},
	ANNOUNCE_SACREDCHEST_YES = "Yay! The box thinks I'm a good cub!",
	ANNOUNCE_SACREDCHEST_NO = "Hmph! The box is being a grumpy-pants.",
    ANNOUNCE_DUSK = "The sky friend is hiding. Time for me to glow!",

    --wx-78 specific
    ANNOUNCE_CHARGE = "only_used_by_wx78",
	ANNOUNCE_DISCHARGE = "only_used_by_wx78",

    -- Winona specific
    ANNOUNCE_ROSEGLASSES = 
    {
        "only_used_by_winona",
        "only_used_by_winona",
        "only_used_by_winona",
    },
    ANNOUNCE_CHARLIESAVE = 
    {
        "only_used_by_winona",
    },
	ANNOUNCE_ENGINEERING_CAN_UPGRADE = "only_used_by_winona",
	ANNOUNCE_ENGINEERING_CAN_DOWNGRADE = "only_used_by_winona",
	ANNOUNCE_ENGINEERING_CAN_SIDEGRADE = "only_used_by_winona",

	ANNOUNCE_EAT =
	{
		GENERIC = "Fusion power, engage! Yum!",
		PAINFUL = "Oww, my tummy feels like it might collapse...",
		SPOILED = "Blech! This tastes like a dusty old comet!",
		STALE = "This is getting a bit crunchy.",
		INVALID = "That's not food, that's a yucky thing!",
        YUCKY = "Putting that in my mouth would be super-duper gross!",

        --Warly specific ANNOUNCE_EAT strings
		COOKED = "only_used_by_warly",
		DRIED = "only_used_by_warly",
        PREPARED = "only_used_by_warly",
        RAW = "only_used_by_warly",
		SAME_OLD_1 = "only_used_by_warly",
		SAME_OLD_2 = "only_used_by_warly",
		SAME_OLD_3 = "only_used_by_warly",
		SAME_OLD_4 = "only_used_by_warly",
        SAME_OLD_5 = "only_used_by_warly",
		TASTY = "only_used_by_warly",
    },

	ANNOUNCE_FOODMEMORY = "only_used_by_warly",

    ANNOUNCE_ENCUMBERED =
    {
        "Huff... Pant...",
        "I should have built... a lifting machine...",
        "Lift... with your back...",
        "This isn't... gentleman's work...",
        "For... science... oof!",
        "Is this... messing up my hair?",
        "Hngh...!",
        "Pant... Pant...",
        "This is the worst... experiment...",
    },
    ANNOUNCE_ATRIUM_DESTABILIZING =
    {
		"I think it's time to leave!",
		"What's that?!",
		"It's not safe here.",
	},
    ANNOUNCE_RUINS_RESET = "The monster-friends came back for another round of tag!",
    ANNOUNCE_SNARED = "Ouchie! Sharp pointy bones!!",
    ANNOUNCE_SNARED_IVY = "Help! The garden is fighting back!",
    ANNOUNCE_REPELLED = "It's got a magic bubble!",
	ANNOUNCE_ENTER_DARK = "The Big Dark is here! I'm scared!",
	ANNOUNCE_ENTER_LIGHT = "Yay! I can see my paws again!",
	ANNOUNCE_FREEDOM = "I'm free! Time to go play!",
	ANNOUNCE_HIGHRESEARCH = "My star-head feels super-sized now!",
	ANNOUNCE_HOUNDS = "I hear scary doggies! Are they coming to play tag?",
	ANNOUNCE_WORMS = "Did the ground just have a tummy-rumble?",
    ANNOUNCE_WORMS_BOSS = "That sounds ominous?",
    ANNOUNCE_ACIDBATS = "Did you hear that?",
	ANNOUNCE_HUNGRY = "I might need some hydrogen soon... or a sandwich...",
	ANNOUNCE_HUNT_BEAST_NEARBY = "I smell a new friend! They must be very close.",
	ANNOUNCE_HUNT_LOST_TRAIL = "Aww, the trail went poof.",
	ANNOUNCE_HUNT_LOST_TRAIL_SPRING = "The soggy dirt hid all the footprints!",
    ANNOUNCE_HUNT_START_FORK = "This trail looks dangerous.",
    ANNOUNCE_HUNT_SUCCESSFUL_FORK = "No beast is a match for my wits!",
    ANNOUNCE_HUNT_WRONG_FORK = "I get the feeling that something is watching me.",
    ANNOUNCE_HUNT_AVOID_FORK = "This trail looks safer.",
	ANNOUNCE_INV_FULL = "I can't carry any more toys!",
	ANNOUNCE_KNOCKEDOUT = "Ugh, my head is full of dizzy shooting stars!",
	ANNOUNCE_LOWRESEARCH = "I only learned a teeny-tiny spark from that.",
	ANNOUNCE_MOSQUITOS = "Aaah! Stop poking me, spiky flies!",
    ANNOUNCE_NOWARDROBEONFIRE = "The closet is having a supernova! I'm not going in there!",
    ANNOUNCE_NODANGERGIFT = "I can't open presents while the bullies are watching!",
    ANNOUNCE_NOMOUNTEDGIFT = "I should hop off the fuzzy monster first.",
	ANNOUNCE_NODANGERSLEEP = "I'm too scared of the Big Dark to nap right now!",
	ANNOUNCE_NODAYSLEEP = "The Sky-friend is too awake for sleepy-time.",
	ANNOUNCE_NODAYSLEEP_CAVE = "I'm not ready for a nap yet!",
	ANNOUNCE_NOHUNGERSLEEP = "My tummy-nebula is rumbling too loud to sleep!",
	ANNOUNCE_NOSLEEPONFIRE = "I don't want to nap in a campfire! Too hot!",
    ANNOUNCE_NOSLEEPHASPERMANENTLIGHT = "only_used_by_wx78",
	ANNOUNCE_NODANGERSIESTA = "It's too scary for a siesta right now!",
	ANNOUNCE_NONIGHTSIESTA = "Night is for big sleeps, not teeny siestas.",
	ANNOUNCE_NONIGHTSIESTA_CAVE = "I don't think I can relax in this spooky hole.",
	ANNOUNCE_NOHUNGERSIESTA = "I'm too hungry for a siesta-snack!",
	ANNOUNCE_NO_TRAP = "Well, that was easy-peasy!",
	ANNOUNCE_PECKED = "Ow! No biting, Mr. Bird!",
	ANNOUNCE_QUAKE = "The ground is having a big tantrum!",
	ANNOUNCE_RESEARCH = "Never stop sparkling!",
	ANNOUNCE_SHELTER = "Thanks for being a big green umbrella, Mr. Tree!",
	ANNOUNCE_THORNS = "Ouchie!",
	ANNOUNCE_BURNT = "Yikes! That was a mega-hot touch!",
	ANNOUNCE_TORCH_OUT = "My stick-light went poof!",
	ANNOUNCE_THURIBLE_OUT = "The smelly-smoke is all gone.",
	ANNOUNCE_FAN_OUT = "My breeze-maker broke! Nooo!",
    ANNOUNCE_COMPASS_OUT = "This star compass doesn't point anymore.",
	ANNOUNCE_TRAP_WENT_OFF = "Whoopsie.",
	ANNOUNCE_UNIMPLEMENTED = "OW! I don't think it's ready to play yet.",
	ANNOUNCE_WORMHOLE = "That space-donut trip was super weird!",
    ANNOUNCE_WORMHOLE_SAMESPOT = "only_used_by_winona",
	ANNOUNCE_TOWNPORTALTELEPORT = "Whoosh! Magic travel is fun!",
	ANNOUNCE_CANFIX = "\nI think I can fix this boo-boo!",
	ANNOUNCE_ACCOMPLISHMENT = "I feel like a gold-star cub!",
	ANNOUNCE_ACCOMPLISHMENT_DONE = "If only my star-family could see me now...",
	ANNOUNCE_INSUFFICIENTFERTILIZER = "Is your tummy still empty, plant-friend?",
	ANNOUNCE_TOOL_SLIP = "Whoa, that toy is super slippery!",
	ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "Safe from those scary sky-sparks!",
	ANNOUNCE_TOADESCAPING = "The big froggy is getting bored of our game.",
	ANNOUNCE_TOADESCAPED = "The big froggy hopped away.",


	ANNOUNCE_DAMP = "Ooh, the sky-juice is touching me!",
	ANNOUNCE_WET = "My sparkly fur is getting all clumpy and soggy!",
	ANNOUNCE_WETTER = "I'm turning into a wet star-mop!",
	ANNOUNCE_SOAKED = "I'm a star-sponge! I can't hold any more water! I dont like this!!!",

	ANNOUNCE_WASHED_ASHORE = "The big splashy-ocean spat me out! I'm still glowing!",

    ANNOUNCE_DESPAWN = "I'm going home with the big sky-friend!",
	ANNOUNCE_BECOMEGHOST = "Wheee! I'm a floaty nebula-puff now! Spooky-rawr!",
	ANNOUNCE_GHOSTDRAIN = "My star-glow is leaking out of my cloud... oh no!",
	ANNOUNCE_PETRIFED_TREES = "The tree-friends turned into scary-grey statues!",
	ANNOUNCE_KLAUS_ENRAGE = "The big goat-meanie is super mad! Run away!!",
	ANNOUNCE_KLAUS_UNCHAINED = "He broke his shiny-links! He's gonna be a super-bully now!",
	ANNOUNCE_KLAUS_CALLFORHELP = "He's calling his meanie-friends to gank me!",

	ANNOUNCE_MOONALTAR_MINE =
	{
		GLASS_MED = "I see a hiding night-friend in there!",
		GLASS_LOW = "I've almost finished the rescue mission!",
		GLASS_REVEAL = "Yay! You're out! Come play!",
		IDOL_MED = "Someone is taking a nap inside the rock!",
		IDOL_LOW = "Don't worry, I'm digging you out of the rock-bed!",
		IDOL_REVEAL = "Peek-a-boo! I found you!",
		SEED_MED = "There's a teeny-tiny spark trapped inside!",
		SEED_LOW = "Hold on, little spark! I'm almost there!",
		SEED_REVEAL = "Safe and sound! Time to sparkle!",
	},

    --hallowed nights
    ANNOUNCE_SPOOKED = "Eek! A shadow-monster just did a 'boo'!",
	ANNOUNCE_BRAVERY_POTION = "My mane is extra sparkly! The trees don't look mean anymore!",
	ANNOUNCE_MOONPOTION_FAILED = "Aww, my star-juice didn't fizzy-pop enough...",

	--winter's feast
	ANNOUNCE_EATING_NOT_FEASTING = "I should really share this with the others.",
	ANNOUNCE_WINTERS_FEAST_BUFF = "I'm feeling a surge of holiday spirit!",
	ANNOUNCE_IS_FEASTING = "Happy Winter's Feast!",
	ANNOUNCE_WINTERS_FEAST_BUFF_OVER = "The holiday goes by so fast...",

    --lavaarena event
    ANNOUNCE_REVIVING_CORPSE = "Let me give you some of my solar-sparkles!",
    ANNOUNCE_REVIVED_OTHER_CORPSE = "Yay! Your inner glow-light is all fixed!",
    ANNOUNCE_REVIVED_FROM_CORPSE = "Thanks for the recharge! My fusion is back on!",

    ANNOUNCE_FLARE_SEEN = "Ooh! A shooting star that goes UP! Who did that?",
    ANNOUNCE_MEGA_FLARE_SEEN = "That flash is gonna bring trouble.",
    ANNOUNCE_OCEAN_SILHOUETTE_INCOMING = "Uh-oh! Scary water-shadows are coming to pounce!",

    --willow specific
	ANNOUNCE_LIGHTFIRE =
	{
		"only_used_by_willow",
    },

    --winona specific
    ANNOUNCE_HUNGRY_SLOWBUILD =
    {
	    "only_used_by_winona",
    },
    ANNOUNCE_HUNGRY_FASTBUILD =
    {
	    "only_used_by_winona",
    },

    --wormwood specific
    ANNOUNCE_KILLEDPLANT =
    {
        "only_used_by_wormwood",
    },
    ANNOUNCE_GROWPLANT =
    {
        "only_used_by_wormwood",
    },
    ANNOUNCE_BLOOMING =
    {
        "only_used_by_wormwood",
    },

    --wortox specfic
    ANNOUNCE_SOUL_EMPTY =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_EMPTY_NICE =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_EMPTY_NAUGHTY =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_FEW =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_FEW_NICE =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_FEW_NAUGHTY =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_MANY =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_MANY_NICE =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_MANY_NAUGHTY =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_OVERLOAD =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_OVERLOAD_NICE =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_OVERLOAD_NAUGHTY =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_OVERLOAD_WARNING =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_OVERLOAD_AVOIDED =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_PANFLUTE_BUFF_ACTIVE =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_PANFLUTE_BUFF_USED =
    {
        "only_used_by_wortox",
    },

    --walter specfic
	ANNOUNCE_AMMO_SLOT_OVERSTACKED = "only_used_by_walter",
	ANNOUNCE_SLINGHSOT_OUT_OF_AMMO =
	{
		"only_used_by_walter",
		"only_used_by_walter",
	},
	ANNOUNCE_SLINGHSOT_NO_AMMO_SKILL = "only_used_by_walter",
	ANNOUNCE_SLINGHSOT_NO_PARTS_SKILL = "only_used_by_walter",
	ANNOUNCE_STORYTELLING_ABORT_FIREWENTOUT =
	{
        "only_used_by_walter",
	},
	ANNOUNCE_STORYTELLING_ABORT_NOT_NIGHT =
	{
        "only_used_by_walter",
	},
	ANNOUNCE_WOBY_RETURN =
	{
		"only_used_by_walter",
	},
	ANNOUNCE_WOBY_SIT =
	{
		"only_used_by_walter",
	},
	ANNOUNCE_WOBY_FOLLOW =
	{
		"only_used_by_walter",
	},
	ANNOUNCE_WOBY_PRAISE =
	{
		"only_used_by_walter",
	},
	ANNOUNCE_WOBY_FORAGE =
	{
		"only_used_by_walter",
	},
	ANNOUNCE_WOBY_WORK =
	{
		"only_used_by_walter",
	},
	ANNOUNCE_WOBY_COURIER =
	{
		"only_used_by_walter",
	},
	ANNOUNCE_WOBY_REMEMBERCHEST_FAIL =
	{
		"only_used_by_walter",
	},

    -- wx specific
    ANNOUNCE_WX_SCANNER_NEW_FOUND = "only_used_by_wx78",
    ANNOUNCE_WX_SCANNER_FOUND_NO_DATA = "only_used_by_wx78",

    --quagmire event
    QUAGMIRE_ANNOUNCE_NOTRECIPE = "Aww, these bits didn't make a yummy star-snack! Just goop.",
    QUAGMIRE_ANNOUNCE_MEALBURNT = "Oopsie! I made a tiny black hole in the pot! It's all crispy.",
    QUAGMIRE_ANNOUNCE_LOSE = "My tummy-nebula is rumbling... I think we're in big trouble!",
    QUAGMIRE_ANNOUNCE_WIN = "Yay! Mission accomplished! Time to zoom-zoom away!",

    ANNOUNCE_ROYALTY =
    {
        "Your Majesty.",
        "Your Highness.",
        "My Liege!",
    },
    ANNOUNCE_ROYALTY_JOKER =
    {
        "Your \"Majesty\".",
        "Your \"Highness\".",
        "My \"Liege\"!",
    },

    ANNOUNCE_ATTACH_BUFF_ELECTRICATTACK    = "I feel positively electric! taste these positrons!!!",
    ANNOUNCE_ATTACH_BUFF_ATTACK            = "I'm a super-star lion! RAWR!",
    ANNOUNCE_ATTACH_BUFF_PLAYERABSORPTION  = "I have a magic star-shield! Yay!",
    ANNOUNCE_ATTACH_BUFF_WORKEFFECTIVENESS = "Zoomy-paws engage! I'm a working star!",
    ANNOUNCE_ATTACH_BUFF_MOISTUREIMMUNITY  = "I'm all fuzzy and dry! No more soggy star-mop!",
    ANNOUNCE_ATTACH_BUFF_SLEEPRESISTANCE   = "I feel so refreshed, I'll never get tired again!",

    ANNOUNCE_DETACH_BUFF_ELECTRICATTACK    = "My sky-sparks went poof, but I'm still tingly!",
    ANNOUNCE_DETACH_BUFF_ATTACK            = "Aww, my super-star power is all used up.",
    ANNOUNCE_DETACH_BUFF_PLAYERABSORPTION  = "My magic bubble popped! Hmph.",
    ANNOUNCE_DETACH_BUFF_WORKEFFECTIVENESS = "My zoomy-paws are getting sleepy... time for a break?",
    ANNOUNCE_DETACH_BUFF_MOISTUREIMMUNITY  = "Oh no, I'm gonna get soggy again!",
    ANNOUNCE_DETACH_BUFF_SLEEPRESISTANCE   = "I'll... (yawn) never get... tired...",

	ANNOUNCE_OCEANFISHING_LINESNAP = "All my hard work, gone in a snap!",
	ANNOUNCE_OCEANFISHING_LINETOOLOOSE = "Maybe reeling would help.",
	ANNOUNCE_OCEANFISHING_GOTAWAY = "It got away.",
	ANNOUNCE_OCEANFISHING_BADCAST = "My casting needs work...",
	ANNOUNCE_OCEANFISHING_IDLE_QUOTE =
	{
		"Where are the fish?",
		"Maybe I should find a better fishing spot.",
		"I thought there were supposed to be plenty of fish in the sea!",
		"I could be doing so many more scientific things right now...",
	},

	ANNOUNCE_WEIGHT = "Weight: {weight}",
	ANNOUNCE_WEIGHT_HEAVY  = "Weight: {weight}\nI'm a fishing heavyweight!",

	ANNOUNCE_WINCH_CLAW_MISS = "I think I missed the mark.",
	ANNOUNCE_WINCH_CLAW_NO_ITEM = "Drat! I've come up empty handed.",

    --Wurt announce strings
    ANNOUNCE_KINGCREATED = "only_used_by_wurt",
    ANNOUNCE_KINGDESTROYED = "only_used_by_wurt",
    ANNOUNCE_CANTBUILDHERE_THRONE = "only_used_by_wurt",
    ANNOUNCE_CANTBUILDHERE_HOUSE = "only_used_by_wurt",
    ANNOUNCE_CANTBUILDHERE_WATCHTOWER = "only_used_by_wurt",
    ANNOUNCE_READ_BOOK =
    {
        BOOK_SLEEP = "only_used_by_wurt",
        BOOK_BIRDS = "only_used_by_wurt",
        BOOK_TENTACLES =  "only_used_by_wurt",
        BOOK_BRIMSTONE = "only_used_by_wurt",
        BOOK_GARDENING = "only_used_by_wurt",
		BOOK_SILVICULTURE = "only_used_by_wurt",
		BOOK_HORTICULTURE = "only_used_by_wurt",

        BOOK_FISH = "only_used_by_wurt",
        BOOK_FIRE = "only_used_by_wurt",
        BOOK_WEB = "only_used_by_wurt",
        BOOK_TEMPERATURE = "only_used_by_wurt",
        BOOK_LIGHT = "only_used_by_wurt",
        BOOK_RAIN = "only_used_by_wurt",
        BOOK_MOON = "only_used_by_wurt",
        BOOK_BEES = "only_used_by_wurt",

        BOOK_HORTICULTURE_UPGRADED = "only_used_by_wurt",
        BOOK_RESEARCH_STATION = "only_used_by_wurt",
        BOOK_LIGHT_UPGRADED = "only_used_by_wurt",
    },

    ANNOUNCE_WEAK_RAT = "This carrat is in no shape to be training.",

    ANNOUNCE_CARRAT_START_RACE = "Let the experim- er, race begin!",

    ANNOUNCE_CARRAT_ERROR_WRONG_WAY = {
        "No, no! You're going the wrong way!",
        "Turn around, white eyes!",
    },
    ANNOUNCE_CARRAT_ERROR_FELL_ASLEEP = "Don't you dare! Wake up, we have a race to win!",
    ANNOUNCE_CARRAT_ERROR_WALKING = "Don't walk, RUN!",
    ANNOUNCE_CARRAT_ERROR_STUNNED = "Get up! GO GO!",

    ANNOUNCE_GHOST_QUEST = "only_used_by_wendy",
    ANNOUNCE_GHOST_HINT = "only_used_by_wendy",
    ANNOUNCE_GHOST_TOY_NEAR = {
        "only_used_by_wendy",
    },
	ANNOUNCE_SISTURN_FULL = "only_used_by_wendy",
    ANNOUNCE_SISTURN_FULL_EVIL = "only_used_by_wendy",
    ANNOUNCE_SISTURN_FULL_BLOSSOM = "only_used_by_wendy",
    ANNOUNCE_ABIGAIL_DEATH = "only_used_by_wendy",
    ANNOUNCE_ABIGAIL_RETRIEVE = "only_used_by_wendy",
	ANNOUNCE_ABIGAIL_LOW_HEALTH = "only_used_by_wendy",
    ANNOUNCE_ABIGAIL_SUMMON =
	{
		LEVEL1 = "only_used_by_wendy",
		LEVEL2 = "only_used_by_wendy",
		LEVEL3 = "only_used_by_wendy",
	},

    ANNOUNCE_GHOSTLYBOND_LEVELUP =
	{
		LEVEL2 = "only_used_by_wendy",
		LEVEL3 = "only_used_by_wendy",
	},

    ANNOUNCE_NOINSPIRATION = "only_used_by_wathgrithr",
    ANNOUNCE_NOTSKILLEDENOUGH = "only_used_by_wathgrithr",
    ANNOUNCE_BATTLESONG_INSTANT_TAUNT_BUFF = "only_used_by_wathgrithr",
    ANNOUNCE_BATTLESONG_INSTANT_PANIC_BUFF = "only_used_by_wathgrithr",
    ANNOUNCE_BATTLESONG_INSTANT_REVIVE_BUFF = "only_used_by_wathgrithr",

    ANNOUNCE_WANDA_YOUNGTONORMAL = "only_used_by_wanda",
    ANNOUNCE_WANDA_NORMALTOOLD = "only_used_by_wanda",
    ANNOUNCE_WANDA_OLDTONORMAL = "only_used_by_wanda",
    ANNOUNCE_WANDA_NORMALTOYOUNG = "only_used_by_wanda",

	ANNOUNCE_POCKETWATCH_PORTAL = "Nobody told me time travel would be such a pain in the rear...",

	ANNOUNCE_POCKETWATCH_MARK = "only_used_by_wanda",
	ANNOUNCE_POCKETWATCH_RECALL = "only_used_by_wanda",
	ANNOUNCE_POCKETWATCH_OPEN_PORTAL = "only_used_by_wanda",
	ANNOUNCE_POCKETWATCH_OPEN_PORTAL_DIFFERENTSHARD = "only_used_by_wanda",

    ANNOUNCE_ARCHIVE_NEW_KNOWLEDGE = "My mind is expanding with new ancient knowledge!",
    ANNOUNCE_ARCHIVE_OLD_KNOWLEDGE = "I already knew that.",
    ANNOUNCE_ARCHIVE_NO_POWER = "Maybe it needs more juice.",

    ANNOUNCE_PLANT_RESEARCHED =
    {
        "My knowledge about this plant is growing!",
    },

    ANNOUNCE_PLANT_RANDOMSEED = "I wonder what it will grow into.",

    ANNOUNCE_FERTILIZER_RESEARCHED = "I never thought I'd be applying my scientific mind to... this.",

	ANNOUNCE_FIRENETTLE_TOXIN =
	{
		"My insides are burning!",
		"Ouch, that's hot!",
	},
	ANNOUNCE_FIRENETTLE_TOXIN_DONE = "Note to self: no more experiments with Fire Nettle toxin.",

	ANNOUNCE_TALK_TO_PLANTS =
    {
        "Grow big and strong, little green-friend!",
        "You're the prettiest plant in the whole galaxy!",
        "Hi little leaf! Do you want to hear a star-story?",
        "You're such a good, quiet little green-friend.",
        "You always listen to my secrets, little leaf!",
    },

    ANNOUNCE_KITCOON_HIDEANDSEEK_START = "3, 2, 1... Ready or not, here I come to find you!",
    ANNOUNCE_KITCOON_HIDEANDSEEK_JOIN = "Aww, the fuzzy-kitties are playing hide and seek! Can I play?",
    ANNOUNCE_KITCOON_HIDANDSEEK_FOUND =
    {
        "Found you, sneaky kitty!",
        "There you are!",
        "You can't hide from my star-eyes!",
        "Peek-a-boo, I see you!",
    },
    ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_ONE_MORE = "Where is the last little fuzzy-kitty hiding?",
    ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_LAST_ONE = "Yay! I found the very last one!",
    ANNOUNCE_KITCOON_HIDANDSEEK_FOUND_LAST_ONE_TEAM = "{name} found the last hiding kitty! We win!",
    ANNOUNCE_KITCOON_HIDANDSEEK_TIME_ALMOST_UP = "Oh no, the kitties are getting tired of waiting...",
    ANNOUNCE_KITCOON_HIDANDSEEK_LOSEGAME = "Aww... they don't want to play hide and seek anymore.",
    ANNOUNCE_KITCOON_HIDANDSEEK_TOOFAR = "The kitties have tiny legs, they wouldn't hide way out here!",
    ANNOUNCE_KITCOON_HIDANDSEEK_TOOFAR_RETURN = "I should go back and look where the kitties are.",
    ANNOUNCE_KITCOON_FOUND_IN_THE_WILD = "I knew I saw a fluffy tail hiding over here!",

    ANNOUNCE_TICOON_START_TRACKING  = "His little nose is wiggling! He smells a friend!",
    ANNOUNCE_TICOON_NOTHING_TO_TRACK = "Aww, his nose couldn't find any hidden friends.",
    ANNOUNCE_TICOON_WAITING_FOR_LEADER = "Wait for me! I want to follow the sniffer-kitty!",
    ANNOUNCE_TICOON_GET_LEADER_ATTENTION = "He wants me to play follow-the-leader!",
    ANNOUNCE_TICOON_NEAR_KITCOON = "His tail is wagging super fast! A friend is close!",
    ANNOUNCE_TICOON_LOST_KITCOON = "Someone else played tag with the hidden kitty first.",
    ANNOUNCE_TICOON_ABANDONED = "I'll use my own nose to find the fuzzy-kitties!",
    ANNOUNCE_TICOON_DEAD = "Oh no... the poor sniffer-kitty went to sleep forever.",

    -- YOTB
    ANNOUNCE_CALL_BEEF = "Come here, big fuzzy monster! Let's play!",
    ANNOUNCE_CANTBUILDHERE_YOTB_POST = "The big bird-judge won't be able to see my fuzzy monster from way over here!",
    ANNOUNCE_YOTB_LEARN_NEW_PATTERN =  "My brain is full of sparkly new dress-up ideas for the fuzzy monsters!",

    -- AE4AE
    ANNOUNCE_EYEOFTERROR_ARRIVE = "Ahhh! The giant floating peeper is back!",
    ANNOUNCE_EYEOFTERROR_FLYBACK = "Finally! The giant peeper went away!",
    ANNOUNCE_EYEOFTERROR_FLYAWAY = "Hey! Come back, you giant meanie-peeper! I wasn't done playing!",

    -- PIRATES
    ANNOUNCE_CANT_ESCAPE_CURSE = "Aww, the spooky magic won't let me go!",
    ANNOUNCE_MONKEY_CURSE_1 = "I feel wibbly-wobbly and... monkey-ish?",
    ANNOUNCE_MONKEY_CURSE_CHANGE = "Ahhh! What happened to my beautiful sparkly mane?!",
    ANNOUNCE_MONKEY_CURSE_CHANGEBACK = "Yay! I'm a star-cub again! No more monkey business!",

    ANNOUNCE_PIRATES_ARRIVE = "Uh oh... that noisy song means the meanie water-bullies are here!",

    ANNOUNCE_BOOK_MOON_DAYTIME = "only_used_by_waxwell_and_wicker",

    ANNOUNCE_OFF_SCRIPT = "That wasn't part of our playtime rules!",

    ANNOUNCE_COZY_SLEEP = "Wow! That star-nap made me feel super zoomy and fresh!",

    --
    ANNOUNCE_TOOL_TOOWEAK = "This toy is too weak! I need a stronger smashing-tool!",

    ANNOUNCE_LUNAR_RIFT_MAX = "Whoa... was that a giant night-spark?!",
    ANNOUNCE_SHADOW_RIFT_MAX = "I have a spooky feeling about that dark cloud...",

    ANNOUNCE_SCRAPBOOK_FULL = "I already collected all these magic doodles!",

    ANNOUNCE_CHAIR_ON_FIRE = "Everything is fine! My seat is just... very warm!",

    ANNOUNCE_HEALINGSALVE_ACIDBUFF_DONE = "Uh oh! The anti-melt juice wore off. I need more!",

    ANNOUNCE_COACH = 
    {
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
    },
    ANNOUNCE_WOLFGANG_WIMPY_COACHING = "only_used_by_wolfgang",
    ANNOUNCE_WOLFGANG_MIGHTY_COACHING = "only_used_by_wolfgang",
    ANNOUNCE_WOLFGANG_BEGIN_COACHING = "only_used_by_wolfgang",
    ANNOUNCE_WOLFGANG_END_COACHING = "only_used_by_wolfgang",
    ANNOUNCE_WOLFGANG_NOTEAM = 
    {
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
        "only_used_by_wolfgang",
    },

    ANNOUNCE_YOTD_NOBOATS = "I need to drive my boat closer to the start line!",
    ANNOUNCE_YOTD_NOCHECKPOINTS = "We have to build the flags before the race starts!",
    ANNOUNCE_YOTD_NOTENOUGHBOATS = "There's no room for more friends to join the water-race!",

    ANNOUNCE_OTTERBOAT_OUTOFSHALLOWS = "Uh oh... this little water-toy is going too deep into the big ocean!",
    ANNOUNCE_OTTERBOAT_DENBROKEN = "Breaking that house made the splashy-friends very angry!",

    ANNOUNCE_GATHER_MERM = "The fishy-frogs are doing something weird together.",

    -- rifts 4
    ANNOUNCE_EXIT_GELBLOB = "Yuck! I was trapped in the slimy bad-goop!",
    ANNOUNCE_SHADOWTHRALL_STEALTH = "Ouch! An invisible meanie bit me! Where is it?!",
    ANNOUNCE_RABBITKING_AGGRESSIVE = "Something big and grumpy is digging under my paws!",
    ANNOUNCE_RABBITKING_PASSIVE = "I hear a little scratch-scratch under the dirt.",
    ANNOUNCE_RABBITKING_LUCKY = "What a funny looking bouncy-bunny!",
    ANNOUNCE_RABBITKING_LUCKYCAUGHT = "Gotcha, you sneaky hopper!",
    ANNOUNCE_RABBITKINGHORN_BADSPAWNPOINT = "The giant bunny doesn't want to dig a hole here.",

    -- Hallowed Nights 2024
    ANNOUNCE_NOPUMPKINCARVINGONFIRE = "The wobble-gourd is throwing a fire-tantrum!",

    -- Winter's Feast 2024
    ANNOUNCE_SNOWBALL_TOO_BIG = "The snow-ball is humongous! It won't get any bigger!",
    ANNOUNCE_SNOWBALL_NO_SNOW = "There isn't enough snow to roll a ball!",

    -- Meta 5
    ANNOUNCE_WENDY_BABYSITTER_SET = "only_used_by_wendy", 
    ANNOUNCE_WENDY_BABYSITTER_STOP = "only_used_by_wendy",

    ANNOUNCE_WORTOX_REVIVER_FAILTELEPORT = "Huh? The zoom-magic didn't work. Why am I still here?",

    ANNOUNCE_NO_ABIGAIL_FLOWER = "only_used_by_wendy",

    ANNOUNCE_ELIXIR_BOOSTED = "Wow! This ghost-juice makes me feel super strong!",
    ANNOUNCE_ELIXIR_GHOSTVISION = "My peepers feel all wibbly-wobbly and spooky!",
    ANNOUNCE_ELIXIR_PLAYER_SPEED = "Zoom zoom! I have so much energy I could lift a whole tree!",

    ANNOUNCE_ELIXIR_TOO_SUPER = "Whoa... this magic juice is way too spicy for a star-cub!",

    -- Rift 5

    ANNOUNCE_LUNARGUARDIAN_INCOMING = "Ahhh! The giant space-bully came back to play rough!",
    ANNOUNCE_FLOATER_HELD = "I was sinking, but something squishy saved me!",
    ANNOUNCE_FLOATER_LETGO = "Ahhh! Don't drop me in the splashy-water!",

    -- rifts5.1
    ANNOUNCE_LUNARHAIL_BIRD_SOUNDS = "The sky is making squawky bird noises!",
    ANNOUNCE_LUNARHAIL_BIRD_CORPSES = "Oh no... frozen birdies are falling from the clouds!",
    ANNOUNCE_FLOAT_SWIM_TIRED = "My paws are too tired to paddle anymore...",
    ANOUNCE_MUTATED_BIRD_ATTACK = "Ahhh! Meanie-birds!",

    -- Rift 6
    ANNOUNCE_WEAPON_TOOWEAK = "This toy is broken! I need a bigger poke-stick!",
    ANNOUNCE_VAULT_TELEPORTER_DOES_NOTHING = "Is the magic space-door broken on the other side?",

    -- Rift 6.1
    ANNOUNCE_LIGHTSOUT_SHADOWHAND = "Ahhh! Why are the creepy shadow-hands hiding down here?!",

    -- Hallowed Nights 2025
    ANNOUNCE_MUTATED_BUZZARD_ARRIVAL = "Shoo, you meanie-birds! Wait, why do they look so spooky?!", -- Mutated buzzards arrive to lurk and circle the player

    -- Winter's Feast 2025
    ANNOUNCE_HERMITCRAB_SHELL_BADTELEPORTPOINT = "Huh? The shell-magic didn't whoosh me away!",
    ANNOUNCE_HERMITCRAB_SHELL_ARRIVE = "Whoa... my tummy-nebula feels super dizzy from that whoosh!",

    -- Year of the Clockwork Knight
    ANNOUNCE_YOTH_ONCOOLDOWN = "The ponies must be taking a little nap right now.",

	BATTLECRY =
	{
		GENERIC = "I'm gonna pounce on you! RAWR!",
		PIG = "Stop being a bully, Mr. Piggy!",
		PREY = "I'm gonna catch you! Tag!",
		SPIDER = "Get your many-legs away from me!",
		SPIDER_WARRIOR = "I'm a brave star-knight! Not scared of you!",
		DEER = "You're too grumpy, Mr. Antlers!",
	},
	COMBAT_QUIT =
	{
		GENERIC = "Yeah, you better run! I'm a combat-star!",
		PIG = "I'll let you go. You look like you need a nap.",
		PREY = "He's too fast for my little paws!",
		SPIDER = "He's too gross to chase anyway. Blech.",
		SPIDER_WARRIOR = "Shoo! Go back to your sticky-house!",
	},

	DESCRIBE =
	{
		MULTIPLAYER_PORTAL = "A giant space-donut doorway! Where does it go?",
        MULTIPLAYER_PORTAL_MOONROCK = "It's a sparkly night-door! Is it for me?",
        MOONROCKIDOL = "A night-sculpture! It's so shiny and cold.",
        CONSTRUCTION_PLANS = "Doodles for making new toys! Yay!",

        ANTLION =
        {
            GENERIC = "It looks like a big, grumpy sand-bug-lion. So he's friend!?",
            VERYHAPPY = "He's smiling! Or maybe he's just gassy.",
            UNHAPPY = "Uh oh, someone's in a bad mood.",
        },
        ANTLIONTRINKET = "Maybe a big bug-friend would like this shiny toy!",
        SANDSPIKE = "Yikes! A giant sand-tooth almost poked my tummy!",
        SANDBLOCK = "It's like a big block of itchy sand-sparkles.",
        GLASSSPIKE = "Now it's a shiny spike! Still no poking allowed!",
        GLASSBLOCK = "Science-magic turned the sand into a clear toy-block!",
        ABIGAIL_FLOWER =
        {
            GENERIC ="A ghosty flower! It smells like starlight and cold hugs.",
			LEVEL1 = "Do you need some alone time?",
			LEVEL2 = "I think she's starting to open up to us.",
			LEVEL3 = "Looks like someone's feeling especially spirited today!",

			-- deprecated
            LONG = "It makes my inner-light feel a bit sad.",
            MEDIUM = "It's all wiggly and spooky.",
            SOON = "The flower is waking up! Is it time to play?",
            HAUNTED_POCKET = "My pocket feels like it's full of cold ghost-tickles!",
            HAUNTED_GROUND = "I want to see the magic happen! RAWR!",
        },

        BALLOONS_EMPTY = "Flabby rubber-pancakes! Can I blow them up?",
        BALLOON = "Floating bubbles! Are they full of hydrogen too? I wanna pop one!",
		BALLOONPARTY = "How did he get the smaller balloons inside?",
		BALLOONSPEED =
        {
            DEFLATED = "Now it's just another balloon.",
            GENERIC = "The hole in the center makes it more aerodynamic, that's just physics!",
        },
		BALLOONVEST = "If the bright colors don't attract some horrible creature, the squeaking will.",
		BALLOONHAT = "The static does terrible things to my hair.",

        BERNIE_INACTIVE =
        {
            BROKEN = "Aww, the fuzzy friend popped! Can we fix his boo-boo?",
            GENERIC = "The teddy-friend looks like he had a solar-meltdown! Poor thing.",
        },

        BERNIE_ACTIVE = "A walking teddy bear! Can I have a hug? Pretty please?",
        BERNIE_BIG = "Willow's friend got really big and scary! RAWR! Go get 'em!",

		BOOKSTATION =
        {
            GENERIC = "A giant table full of story-pages and magic secrets!",
            BURNT = "Oh no, the story-table got all burnt and crispy.",
        },
        BOOK_BIRDS = "A picture book of flap-flap friends! Look at all the birdies!",
        BOOK_TENTACLES = "This story has too many wiggly-arms in it. It's a bit scary!",
        BOOK_GARDENING = "A magic book on how to give the plants a yummy snack!",
        BOOK_SILVICULTURE = "A picture book full of giant tree-friends! Can we plant a forest?",
        BOOK_HORTICULTURE = "Magic doodles that make the green-friends grow super fast!",
        BOOK_SLEEP = "Zzz... the words in this book are very sleepy... zzz...",
        BOOK_BRIMSTONE = "Wow! This story is full of boom-sparks and fire! It's like a paper sun!",

        BOOK_FISH = "A splashy book about all the little swimmers in the big water!",
        BOOK_FIRE = "Ouch! The pages in this story feel super hot on my star-paws!",
        BOOK_WEB = "Ew, ew, ew! A whole book about the creepy many-legs! Keep it away!",
        BOOK_TEMPERATURE = "This magic book changes from freezing cold to hot and sweaty!",
        BOOK_LIGHT = "A glowing story filled with captured sun-sparks!",
        BOOK_RAIN = "If I read this out loud, the sky-juice starts pouring down! Splash!",
        BOOK_MOON = "A beautiful story about the giant night-cheese and its sparkly magic.",
        BOOK_BEES = "A tickly book about the buzzy-bugs making sticky sweet-stuff!",
        
        BOOK_HORTICULTURE_UPGRADED = "Super-duper magic doodles! The green-friends are going to be giant!",
        BOOK_RESEARCH_STATION = "The library-lady's special desk! So many big words and magic papers.",
        BOOK_LIGHT_UPGRADED = "Wow! This story shines brighter than a whole galaxy!",

        FIREPEN = "A spicy drawing-stick! It writes with actual fire-sparks!",

        PLAYER =
        {
            GENERIC = "Hi, %s! Do you want to see me sparkle?",
            ATTACKER = "You're being a big meanie-pants, %s!",
            MURDERER = "You have scary shadow-monsters in your eyes!",
            REVIVER = "%s is the master of the sparky-hugs! You brought back a friend!",
            GHOST = "Oh no, %s turned into a cloud! How do we puff you back into a person?",
            FIRESTARTER = "Hey, %s! You're making a supernova without me! That's not nice!",
        },
        WILSON =
        {
            GENERIC = "Hi, Mr. Scientist! Can your science make star-cookies?",
            ATTACKER = "Hey! Put the pointy stick away, Mr. Scientist!",
            MURDERER = "You're using your beakers for meanie-magic, %s!",
            REVIVER = "Mr. Scientist used his beep-boops to bring back a friend!",
            GHOST = "You're a floaty cloud now! Time for a sparky-hug revival!",
            FIRESTARTER = "That's a very big campfire, %s! Is it a land supernova?",
        },
        WOLFGANG =
        {
            GENERIC = "Hi, Mr. Strong-Man! Can you lift a whole nebula?",
            ATTACKER = "Don't use those big muscles for bullying!",
            MURDERER = "The big strong man is being a big meanie-pants!",
            REVIVER = "%s is like a giant, fuzzy, sparky teddy bear.",
            GHOST = "Even the biggest stars go 'poof' sometimes. Don't be sad!",
            FIRESTARTER = "You're fighting the fire? I think the fire is winning, %s!",
        },
        WAXWELL =
        {
            GENERIC = "Mr. Fancy-Suit! Do you have any magic tricks today?",
            ATTACKER = "Mr. Fancy-Suit is being super-grumpy with his hands!",
            MURDERER = "Your shadow-magic is making me feel all shivery, %s!",
            REVIVER = "Mr. Fancy-Suit is using his star-power for good!",
            GHOST = "Don't look so gloomy, Mr. Cloud-Suit! I'll fix you!",
            FIRESTARTER = "You're gonna get your fancy clothes all smoky, %s!",
        },
        WX78 =
        {
            GENERIC = "Hello, Mr. Beep-Boop! Are you made of space-metal?",
            ATTACKER = "Mr. Robot is having a glitchy-tantrum!",
            MURDERER = "You broke the rules of the Robot-Nebula, %s!",
            REVIVER = "I knew Mr. Beep-Boop had a sparkly heart inside!",
            GHOST = "Oh no, Mr. Robot ran out of batteries! We need a recharge!",
            FIRESTARTER = "Are you trying to turn into a toaster, %s?",
        },
        WILLOW =
        {
            GENERIC = "She likes fire almost as much as I do!",
            ATTACKER = "Willow is holding her sparkly-toy too tight...",
            MURDERER = "You're making too many land supernovas, %s! Stop it!",
            REVIVER = "%s is a warm friend to the ghosty-clouds.",
            GHOST = "You're all out of sparks, Willow. Let me help!",
            FIRESTARTER = "Yay! More boom-sparks! ...Wait, was that a mistake?",
        },
        WENDY =
        {
            GENERIC = "Hi, little cloud-girl! Want a star-hug to feel better?",
            ATTACKER = "Don't be a meanie, %s! Put that away!",
            MURDERER = "You have scary shadow-monsters in your eyes!",
            REVIVER = "Wendy knows all the best secrets about ghosty-friends.",
            GHOST = "Double the ghosts! Double the floaty-fun! Let's get you back, %s.",
            FIRESTARTER = "You're making the world extra bright today, %s.",
        },
        WOODIE =
        {
            GENERIC = "Mr. Wood-Chopper! Is Lucy your bestest friend too?",
            ATTACKER = "Stop being a sap, Woodie! No more hitting!",
            MURDERER = "The axe-man is having a very mean tantrum!",
            REVIVER = "Mr. Wood-Chopper saved our bacon-snacks!",
            GHOST = "Are you a ghost-beaver now, %s? How silly!",
            BEAVER = "A giant fuzzy chomper! Can I pet you? RAWR!",
            BEAVERGHOST = "Don't be a beaver-meanie, I'll give you a sparky-hug!",
            MOOSE = "Gadzooks! That's a super-duper big moose!",
            MOOSEGHOST = "The big moose looks like a sad night-cloud.",
            GOOSE = "Look at the big honky-bird! Wheee!",
            GOOSEGHOST = "You're a silly ghost-goose, %s!",
            FIRESTARTER = "Don't burn the whole forest-playground down, %s!",
        },
        WICKERBOTTOM =
        {
            GENERIC = "Grandma Wicker! Read me the story about the birdies again!",
            ATTACKER = "Grandma is gonna throw the big heavy books at me!",
            MURDERER = "Grandma Wicker is being a super-meanie teacher!",
            REVIVER = "Grandma Wicker knows all the best magic-spells.",
            GHOST = "Books don't work when you're a floaty cloud, %s!",
            FIRESTARTER = "I'm sure there's a star-reason for that fire, Grandma.",
        },
        WES =
        {
            GENERIC = "Hi, Quiet-Bubble-Man! Show me a star-balloon!",
            ATTACKER = "%s is being silent... but he's acting like a bully!",
            MURDERER = "Mime a sorry! You're being mean!",
            REVIVER = "%s thinks outside the invisible star-box.",
            GHOST = "How do I say 'I'll fix you' in quiet-mime language?",
            FIRESTARTER = "Wait, don't tell me... you lit a fire with magic?",
        },
        WEBBER =
        {
            GENERIC = "Hi, Spider-Boy! Do your friends bite or just tickle?",
            ATTACKER = "I'm gonna roll up a doodle-paper if you don't stop!",
            MURDERER = "You're a meanie spider-boy! I'm gonna pounce!",
            REVIVER = "%s is playing nice with the other star-cubs.",
            GHOST = "Are you buggin' me for a sparky-hug, %s?",
            FIRESTARTER = "We need to talk about fire-safety in the spider-club!",
        },
        WATHGRITHR =
        {
            GENERIC = "The Brave Star-Knight! Are we going on a quest?",
            ATTACKER = "I don't want to play tag with your pointy stick!",
            MURDERER = "The Knight has gone supernova-mad!",
            REVIVER = "The Brave Knight is the master of the spirits!",
            GHOST = "No Valhalla yet! We have more games to play, %s!",
            FIRESTARTER = "The Knight is making a very hot dragon-fire!",
        },
        WINONA =
        {
            GENERIC = "Fix-it Lady! Can you build me a rocket-ship?",
            ATTACKER = "The Fix-it Lady is a walking safety-oopsie!",
            MURDERER = "No more games, %s! You're being a bully!",
            REVIVER = "You're super handy for fixing broken friends, %s!",
            GHOST = "Looks like someone threw a wrench in your star-gears.",
            FIRESTARTER = "The factory is having a meltdown!",
        },
        WORTOX =
        {
            GENERIC = "Hi, Hoppy-Imp! Do you want to play tag?",
            ATTACKER = "I knew the Hoppy-Imp was a little trickster!",
            MURDERER = "Time to grab the puppy-imp by his horns!",
            REVIVER = "Thanks for the helping claw, Mr. Imp!",
            GHOST = "I don't believe in imps... oh wait, you're a cloud-imp now!",
            FIRESTARTER = "You're being a very naughty imp, %s!",
        },
        WORMWOOD =
        {
            GENERIC = "Leafy-friend! You smell like a happy green planet!",
            ATTACKER = "%s is being extra prickly today! Ouchie!",
            MURDERER = "I'm gonna weed-whack the meanie out of you, %s!",
            REVIVER = "Leafy-friend never lets his stars go out.",
            GHOST = "Do you need a star-hug, little green guy?",
            FIRESTARTER = "I thought you liked the green stuff more than the red fire!",
        },
        WARLY =
        {
            GENERIC = "Mr. Chef! Is the hydrogen snack ready yet?",
            ATTACKER = "This is a recipe for a big boo-boo!",
            MURDERER = "I hope you don't have half-baked plans to pounce on me!",
            REVIVER = "I can always count on Mr. Chef to cook up a rescue!",
            GHOST = "Maybe he ate too many ghost-peppers. Hehe!",
            FIRESTARTER = "He's gonna flambe the whole playground!",
        },

        WURT =
        {
            GENERIC = "Hi, Swamp-Girl! Do you like to swim in starlight ponds?",
            ATTACKER = "Swamp-Girl is looking especially monstrous-grumpy today...",
            MURDERER = "You're just a big murderous mermy-meanie!",
            REVIVER = "Why, thank you, Swamp-Girl!",
            GHOST = "You look even greener as a ghost-cloud, %s.",
            FIRESTARTER = "Didn't anyone teach you that fire is too hot for fishies?!",
        },

        WALTER =
        {
            GENERIC = "Hi %s! Are we playing forest-explorers today?",
            ATTACKER = "Hey %s! That's against the explorer rules! You're being a bully!",
            MURDERER = "Ahhh! %s turned into a giant scary monster! Run away!",
            REVIVER = "Yay! %s woke me up from the forever-nap! You're the best explorer!",
            GHOST = "Oh no, %s is a floaty ghost now! Do you need a magic heart?",
            FIRESTARTER = "Stop playing with the fire-sparks, %s! You're going to burn the forest down!",
        },

        WANDA =
        {
            GENERIC = "Hello %s! Can I play with your tick-tock toys?",
            ATTACKER = "Ouch, %s! Why are you using your tick-tock magic to be a meanie?!",
            MURDERER = "Ahhh! The tick-tock lady went crazy! Time to zoom away!",
            REVIVER = "%s used her magic clocks to wake me from the forever-nap! Thank you!",
            GHOST = "Poor %s! I'll go find a magic heart to fix your broken clock!",
            FIRESTARTER = "%s! Why is your tick-tock magic making fire-tantrums everywhere?!",
        },

        WONKEY =
        {
            GENERIC = "A silly swinging-friend! Ooh ooh ah ah!",
            ATTACKER = "Hey! Stop being a bully, you meanie monkey!",
            MURDERER = "Ahhh! The tail-swinger is playing way too rough! Run!",
            REVIVER = "The funny monkey woke me up from the forever-nap! Thank you!",
            GHOST = "A floaty monkey-ghost! Are you going to steal my bananas now?",
            FIRESTARTER = "Uh oh! The naughty monkey is playing with fire-sparks!",
        },

        -- ===========================================================================
        --                         MOD CHARACTER SECTION
        -- ===========================================================================
        WONE =
        {
            GENERIC = "Hi %s! Are you a fast toy-robot? Can I play with your shiny flipping-coins?",
            ATTACKER = "Hey %s! Stop shooting your loud-toys at everyone! That's mean!",
            MURDERER = "Ahhh! The blue robot went haywire! He's making too many red puddles! Run!",
            REVIVER = "Yay! %s used his beep-boop magic to wake me from the forever-nap! Good robot!",
            GHOST = "Oh no, %s's battery ran out! Do you need a magic heart to reboot?",
            FIRESTARTER = "Uh oh, %s's circuits are making too many fire-sparks! You're going to melt!",
        },
        WONE_TRUSTY_SHOOTER = "A shiny silver pew-pew toy! Does it shoot little stars?",
        WONE_SHOTGUN = "A big heavy boom-stick! It makes my fuzzy ears ring!",
        WONE_TRUSTY_SHOOTER_PROJECTILE = "wone_non_inspectable",
        WONE_SHOTGUN_PROJECTILE = "wone_non_inspectable",
        WONE_NAILGUN = "It spits out sharp little metal claws! Just like mine, but not as warm!",
        WONE_RAILCANNON = "Whoa! A giant tube that shoots a big, bright sun-beam! It's so bright and sparkly!",
        WONE_WEAPONPACK = "only_used_by_wone",
        WONE_HELL = "What is that? It's super duper scary!!",
        WONE_TERMINAL = "I wanna buy shiny toys from the machine too!",

        WILDCHILD =
        {
            GENERIC = "Hi %s! You've got messy hair just like my mane! Are you a wild-cub?",
            ATTACKER = "Hey %s! Stop biting and scratching! That's not how we play tag!",
            MURDERER = "Ahhh! The wild-girl went completely feral! Run away!",
            REVIVER = "Yay! The wild-cub %s shared her forest-magic to wake me up!",
            GHOST = "Oh no, %s is a floaty wild-ghost now! Do you want a magic star-heart?",
            FIRESTARTER = "%s, don't set the forest on fire! Where will we play hide-and-seek?",
        },

        ICE_DEN = "A freezing cold nap-cave! Brrr! My star-paws are shivering!",
        HOUNDPLUSH = "A squishy toy-doggy! It's so soft!",
        WARGPLUSH = "A giant squishy toy-doggy! I want to hug it forever!",
        HOUNDWHISTLE = "A shiny noise-maker! Toot toot! Here doggy!",
        HOUNDMOUND = "A big dirt-castle for the wild doggies!",
        CHEAPBIRDTRAP = "A sneaky little cage for the flap-flap friends.",

        -- ===========================================================================
        --                         MOD CHARACTER SECTION END
        -- ===========================================================================

        MIGRATION_PORTAL =
        {
        --    GENERIC = "If I had any friends, this could take me to them.",
        --    OPEN = "If I step through, will I still be me?",
        --    FULL = "It seems to be popular over there.",
        },
        GLOMMER =
        {
            GENERIC = "A floaty-goop friend! He's so squishy!",
            SLEEPING = "Napping like a little nebula cloud. Zzz...",
        },
        GLOMMERFLOWER =
        {
            GENERIC = "It's a petal-sun! Look at it sparkle!",
            DEAD = "The sparkles are taking a nap. Poor flower.",
        },
        GLOMMERWINGS = "With these, I can be a flying shooting star!",
        GLOMMERFUEL = "Yuck! Floaty-goop has stinky nebula-gas!",
        BELL = "A jingle-toy! Ding-dong-ding!",
        STATUEGLOMMER =
        {
            GENERIC = "A rock-friend that looks like my floaty-goop pal.",
            EMPTY = "Oopsie! I broke the gloomrock with my star-paws!",
        },

        LAVA_POND_ROCK = "It's nice and toasty here! Like a sun-warmed bed.",

		WEBBERSKULL = "Oh no! A spider-cub lost his spark! We should find him a comfy rest.",
		WORMLIGHT = "A glow-berry snack! It's like munching on a teeny star.",
		WORMLIGHT_LESSER = "This star-snack is all wrinkly and sad.",
		WORM =
		{
		    PLANT = "Look! A pretty glow-flower! Is it time to play?",
		    DIRT = "Just a pile of itchy-brown stuff. Or is it...?",
		    WORM = "Aaah! It's a giant wiggle-monster! RAWR!",
		},
        WORMLIGHT_PLANT = "A bait-flower? Is it a trap for a game of tag?",
		MOLE =
		{
			HELD = "I caught a dirt-sniffer! Don't worry, I won't pounce too hard.",
			UNDERGROUND = "A friend is playing hide-and-seek under the grass!",
			ABOVEGROUND = "A pop-up friend! Peek-a-boo!",
		},
		MOLEHILL = "A teeny house in the dirt! Does it have a star-chimney?",
		MOLEHAT = "It's a magic night-vision toy! But it smells like a wet doggie.",

		EEL = "A wiggly water-snack! Full of fusion power.",
		EEL_COOKED = "Hot wiggly-snack! My tummy-nebula is ready.",
		UNAGI = "I hope this snack doesn't make me feel all wobbly-eel!",
		EYETURRET = "A giant star-peeper! Is it watching the game?",
		EYETURRET_ITEM = "The big eye is having a nap. Shhh.",
		MINOTAURHORN = "A giant rock-tooth! I'm glad it didn't poke my tummy.",
		MINOTAURCHEST = "A surprise toy-box! Is there a star inside? Or a meanie?",
		THULECITE_PIECES = "Teeny-tiny chunks of ancient star-metal.",
		POND_ALGAE = "Soggy green pond-hair.",
		GREENSTAFF = "A magic undo-stick! It's very handy for my games.",
		GIFT = "A surprise-package! Is it for the bestest star-cub?",
        GIFTWRAP = "Shiny paper for making surprises!",
		POTTEDFERN = "A leaf-friend in a little dirt-bucket.",
        SUCCULENT_POTTED = "A prickly-friend in a tiny home.",
		SUCCULENT_PLANT = "Aloe there, little green-friend!",
		SUCCULENT_PICKED = "I could munch on this, but my hydrogen-meter is okay for now.",
		SENTRYWARD = "A beep-boop toy for drawing the sky-map!",
        TOWNPORTAL =
        {
			GENERIC = "A sand-pyramid for zoomy travel!",
			ACTIVE = "The pyramid is ready to puff me away!",
		},
        TOWNPORTALTALISMAN =
        {
			GENERIC = "A teeny-tiny zoomy-toy.",
			ACTIVE = "Only silly-billies walk when you can teleport-zoom!",
		},
        WETPAPER = "A soggy doodle-page. It needs to dry off!",
        WETPOUCH = "A soggy pocket-bag. It's falling all apart!",
        MOONROCK_PIECES = "Chunks of the big night-cheese! I can pounce on these.",
        MOONBASE =
        {
            GENERIC = "A night-cradle! It's waiting for a magic-stick.",
            BROKEN = "Oh no! The night-toy is all smashed up!",
            STAFFED = "Now what happens? Is it show-time?",
            WRONGSTAFF = "This stick doesn't fit the night-cradle. Hmph.",
            MOONSTAFF = "The night-stone woke up the magic! Sparkly!",
        },
        MOONDIAL =
        {
			GENERIC = "A bowl of water that talks to the big night-cheese.",
			NIGHT_NEW = "The night-friend is hiding today.",
			NIGHT_WAX = "The night-friend is getting bigger and brighter!",
			NIGHT_FULL = "Look! The big night-cheese is all grown up!",
			NIGHT_WANE = "The night-friend is getting sleepy and small again.",
			CAVE = "I can't see the night-friend in this spooky hole.",
			WEREBEAVER = "only_used_by_woodie", --woodie specific
			GLASSED = "I have the strangest feeling I'm being watched.",
        },
		THULECITE = "Ancient, shiny sky-blocks. Where did they come from?",
		ARMORRUINS = "Magic dress-up clothes! They're light as a nebula.",
		ARMORSKELETON = "I'm wearing a bone-costume! Spooky-rawr!",
		SKELETONHAT = "This hat is full of bad-dream magic. No thank you!",
		RUINS_BAT = "A heavy bonk-stick! It's got a lot of oomph.",
		RUINSHAT = "Does this crown make me look like a solar king? My mane looks great!",
		NIGHTMARE_TIMEPIECE =
		{
            CALM = "All the shadows are being nice right now.",
            WARN = "The magic is getting all tingly and weird.",
            WAXING = "The shadow-meltdown is coming! Watch out!",
            STEADY = "The bad-magic is staying right there.",
            WANING = "The shadows are getting sleepy and going away.",
            DAWN = "The bad-dream is almost over! Yay!",
            NOMAGIC = "No shadow-meanies around here.",
		},
		BISHOP_NIGHTMARE = "A broken shadow-peeper! It's falling apart!",
		ROOK_NIGHTMARE = "A scary shadow-stomper! Run away!!",
		KNIGHT_NIGHTMARE = "It's a knight-mare! Get it? Hehe! ahh!",
		MINOTAUR = "That big cow-meanie looks super-grumpy.",
		SPIDER_DROPPER = "Note to self: Don't look up or the crawlers will pounce!",
		NIGHTMARELIGHT = "A shadow-lamp. I wonder how it glows in the dark.",
		NIGHTSTICK = "A sparky-bonk-stick! ZAP!",
		GREENGEM = "A shiny green space-candy!",
		MULTITOOL_AXE_PICKAXE = "A super-duper-chopper-bonker! It's brilliant!",
		ORANGESTAFF = "This stick lets me zoom-zoom! Way better than walking.",
		YELLOWAMULET = "A warm sun-necklace! It's so cuddly.",
		GREENAMULET = "Every star-base needs a sparkly green charm!",
		SLURPERPELT = "It's just a hairy rug now.",

		SLURPER = "A fuzzy wig-friend! He wants to hug my head!",
		SLURPER_PELT = "Still hairy, but it doesn't wiggle anymore.",
		ARMORSLURPER = "A soggy, fuzzy hug-suit. It keeps my tummy full of hydrogen!",
		ORANGEAMULET = "A zoomy-necklace! Teleport-tag is the best game.",
		YELLOWSTAFF = "A genius toy! A shiny sun-gem on a stick!",
		YELLOWGEM = "A bright yellow space-candy! I really like this one!",
		ORANGEGEM = "An orange star-rock!",
        OPALSTAFF = "Science-magic says gems look better on top of bonk-sticks!",
        OPALPRECIOUSGEM = "This gem is extra-special! It's got a big glow.",
        TELEBASE =
		{
			VALID = "The zoomy-pad is ready for lift-off!",
			GEMS = "It needs more purple space-candies to work.",
		},
		GEMSOCKET =
		{
			VALID = "The gem-hole looks happy.",
			GEMS = "It's hungry for a shiny gem!",
		},
		STAFFLIGHT = "Hello, little friend! You're like a tiny star, what a cozy warmth you give!",
        STAFFCOLDLIGHT = "Brrr! Hello little friend! you're like a tiny icy star, what a chilly sparkle you give!",

        ANCIENT_ALTAR = "A big, old, mysterious magic-table.",

        ANCIENT_ALTAR_BROKEN = "The magic-table has a big boo-boo.",

        ANCIENT_STATUE = "This rock-friend is humming a weird tune.",

        LICHEN = "Yucky green star-moss. It likes the dark-holes.",
		CUTLICHEN = "Hydrogen-moss! It doesn't last long, though.",

		CAVE_BANANA = "A mushy yellow snack. Needs more fusion.",
		CAVE_BANANA_COOKED = "Yum! Hot mushy-snack!",
		CAVE_BANANA_TREE = "A tree that grows snacks in the dark! Magic!",
		ROCKY = "A rock-friend with big scary-claws! Don't pinch!",

		COMPASS =
		{
			GENERIC="Which way to the North Star?",
			N = "North! That's up on the map-doodle.",
			S = "South! Down towards my tail.",
			E = "East! Towards the rising sun.",
			W = "West! Where the sun goes to sleep.",
			NE = "Northeast! A bit up and a bit right.",
			SE = "Southeast! A bit down and a bit right.",
			NW = "Northwest! A bit up and a bit left.",
			SW = "Southwest! A bit down and a bit left.",
		},

        HOUNDSTOOTH = "A pointy tooth from a scary doggy!",
        ARMORSNURTLESHELL = "It's like a heavy backpack for a turtle-friend!",
        BAT = "Eek! A flappy shadow-mouse!",
        BATBAT = "A bonk-stick with wings! Swoosh!",
        BATWING = "Ew, it's all leathery and spooky.",
        BATWING_COOKED = "A crispy flappy-snack! Still kind of gross.",
        BATCAVE = "Shh! The flappy-mice are taking a dark-nap.",
        BEDROLL_FURRY = "As soft as my mane! Zzz...",
        BUNNYMAN = "A giant bunny-friend! Does he prefer gigant carrots?",
        FLOWER_CAVE = "A little light-bulb plant! It has a plant-star inside.",
        GUANO = "Yuck! Flappy-mouse poop!",
        LANTERN = "A land-sun-in-a-jar! Perfect for the Big Dark.",
        LIGHTBULB = "It looks like a yummy glowing berry!",
        MANRABBIT_TAIL = "A soft little puffball! So comforting.",
        MUSHROOMHAT = "Look at me! I'm mush-lion!",
        MUSHROOM_LIGHT2 =
        {
            ON = "It's glowing like a blue star!",
            OFF = "Wake up, little mushy-light!",
            BURNT = "Oopsie... the star burned out.",
        },
        MUSHROOM_LIGHT =
        {
            ON = "Sparkle-shroom!",
            OFF = "It's taking a nap in the dark.",
            BURNT = "All crispy and sad.",
        },
        SLEEPBOMB = "A pocket-sized naptime explosion!",
        MUSHROOMBOMB = "A squishy boom-toy!",
        SHROOM_SKIN = "Ew, froggy-plant skin!",
        TOADSTOOL_CAP =
        {
            EMPTY = "A big grumpy frog-friend left a hole.",
            INGROUND = "Peek-a-boo! I see you!",
            GENERIC = "A giant wobbly bounce-pad!",
        },
        TOADSTOOL =
        {
            GENERIC = "It's a huge mushy-frog! RAWR!",
            RAGE = "Uh oh! The big froggy is having a tantrum!",
        },
        MUSHROOMSPROUT =
        {
            GENERIC = "A baby mushy-friend!",
            BURNT = "A crispy little mistake.",
        },
        MUSHTREE_TALL =
        {
            GENERIC = "A giant tree made of squish!",
            BLOOM = "It's making stinky star-dust.",
            ACIDCOVERED = "It's covered in acid.",
        },
        MUSHTREE_MEDIUM =
        {
            GENERIC = "A perfect umbrella for a star-cub.",
            BLOOM = "Pee-yew! Sparkly but stinky!",
            ACIDCOVERED = "It's covered in acid.",
        },
        MUSHTREE_SMALL =
        {
            GENERIC = "A teeny-tiny glow-tree!",
            BLOOM = "It's sneezing glow-dust everywhere!",
            ACIDCOVERED = "It's covered in acid.",
        },
        MUSHTREE_TALL_WEBBED =
        {
            GENERIC = "The spiders thought this one was important.",
            ACIDCOVERED = "It's covered in acid.",
        },
        SPORE_TALL =
        {
            GENERIC = "A floaty little star-dust!",
            HELD = "A pocket full of starlight!",
        },
        SPORE_MEDIUM =
        {
            GENERIC = "A floaty little star-dust!",
            HELD = "A pocket full of starlight!",
        },
        SPORE_SMALL =
        {
            GENERIC = "A floaty little star-dust!",
            HELD = "A pocket full of starlight!",
        },
        RABBITHOUSE =
        {
            GENERIC = "A giant fake carrot! Do the bunny-friends live here?",
            BURNT = "Oh no, the big carrot had a land supernova.",
        },
        SLURTLE = "A slimy shell-bug. Blech!",
        SLURTLE_SHELLPIECES = "Broken shell toys.",
        SLURTLEHAT = "I'm not putting that slimy bowl on my mane!",
        SLURTLEHOLE = "A stinky mud-house.",
        SLURTLESLIME = "Goop! It's like boogers, but explosive!",
        SNURTLE = "A swirly shell-bug. Still pretty slimy.",
        SPIDER_HIDER = "A shy many-legs! Peek-a-boo!",
        SPIDER_SPITTER = "Ew! Don't spit your sticky-goop at me!",
        SPIDERHOLE = "A spooky sticky-hole.",
        SPIDERHOLE_ROCK = "The sticky-hole has a rock hat.",
        STALAGMITE = "A pointy earth-tooth.",
        STALAGMITE_TALL = "A very tall earth-tooth! Don't trip!",

        TURF_CARPETFLOOR = "A fancy soft floor for my paws!",
        TURF_CHECKERFLOOR = "A game-board for the ground!",
        TURF_DIRT = "A patch of itchy dirt.",
        TURF_FOREST = "A piece of the leaf-playground.",
        TURF_GRASS = "Soft tickle-grass.",
        TURF_MARSH = "Soggy squishy mud.",
        TURF_METEOR = "A piece of the big night-cheese!",
        TURF_PEBBLEBEACH = "Little rocks for skipping!",
        TURF_ROAD = "A zoomy-path!",
        TURF_ROCKY = "Hard bumpy ground.",
        TURF_SAVANNA = "Yellow tickle-grass.",
        TURF_WOODFLOOR = "Smooth tree-planks.",

		TURF_CAVE="Spooky-hole floor.",
		TURF_FUNGUS="Mushy-squishy floor.",
		TURF_FUNGUS_MOON = "Yet another ground type.",
		TURF_ARCHIVE = "Yet another ground type.",
        TURF_VAULT = "Yet another ground type.",
        TURF_VENT = "Yet another ground type.",
		TURF_SINKHOLE="Crumbly hole-floor.",
		TURF_UNDERROCK="Hard cave-floor.",
		TURF_MUD="Messy mud-pie floor!",

		TURF_DECIDUOUS = "Crunchy leaf-floor.",
		TURF_SANDY = "A sandbox for my paws!",
		TURF_BADLANDS = "Grumpy cracked dirt.",
		TURF_DESERTDIRT = "Dry sandy dirt.",
		TURF_FUNGUS_GREEN = "Green mushy-floor.",
		TURF_FUNGUS_RED = "Red mushy-floor.",
		TURF_DRAGONFLY = "Super hot lava-floor! Ouchie!",

        TURF_SHELLBEACH = "A chunk of beach.",

		TURF_RUINSBRICK = "Yet another ground type.",
		TURF_RUINSBRICK_GLOW = "Yet another ground type.",
		TURF_RUINSTILES = "Yet another ground type.",
		TURF_RUINSTILES_GLOW = "Yet another ground type.",
		TURF_RUINSTRIM = "Yet another ground type.",
		TURF_RUINSTRIM_GLOW = "Yet another ground type.",

        TURF_MONKEY_GROUND = "A chunk of sand.",

        TURF_CARPETFLOOR2 = "It's surprisingly soft.",
        TURF_MOSAIC_GREY = "Yet another ground type.",
        TURF_MOSAIC_RED = "Yet another ground type.",
        TURF_MOSAIC_BLUE = "Yet another ground type.",

        TURF_BEARD_RUG = "I made it from my beard!",

		POWCAKE = "A never-ending snack! But it looks yucky.",
        CAVE_ENTRANCE = "A big rock is plugging up the spooky hole!",
        CAVE_ENTRANCE_RUINS = "A very old, very scary plugged hole.",

       	CAVE_ENTRANCE_OPEN =
        {
            GENERIC = "The ground is yawning!",
            OPEN = "A dark tunnel! Should I go play hide-and-seek down there?",
            FULL = "It's full of friends! I'll wait my turn.",
        },
        CAVE_EXIT =
        {
            GENERIC = "I'm not done playing in the dark yet!",
            OPEN = "Time to go back up and see the Sky-friend!",
            FULL = "Too many friends up there! I'll stay here.",
        },

		MAXWELLPHONOGRAPH = "That's where Mr. Fancy-Suit's music comes from!",--single player
		BOOMERANG = "It comes back for a second game of catch!",
		PIGGUARD = "That Mr. Piggy looks like a grumpy bully.",
		ABIGAIL =
		{
            LEVEL1 =
            {
                "Awww, she has a cute little bow.",
                "Awww, she has a cute little bow.",
            },
            LEVEL2 =
            {
                "Awww, she has a cute little bow.",
                "Awww, she has a cute little bow.",
            },
            LEVEL3 =
            {
                "Awww, she has a cute little bow.",
                "Awww, she has a cute little bow.",
            },
        },

		ADVENTURE_PORTAL = "I don't think I want to jump into that spooky space-door again.",
		AMULET = "My mane feels so safe when I wear this shiny star-necklace.",
		ANIMAL_TRACK = "Zoomy-friend footprints! Let's play tag!",
		ARMORGRASS = "A tickle-grass shirt! I hope there are no spiky flies in it.",
		ARMORMARBLE = "That looks too heavy for a little star-cub.",
		ARMORWOOD = "A wooden box to protect my tummy!",
		ARMOR_SANITY = "Wearing that makes my inner light feel all wiggly and weird.",
		ASH =
		{
			GENERIC = "Just sad, grey stardust left from a fire.",
			REMAINS_GLOMMERFLOWER = "The floaty-goop flower had a supernova in the portal!",
			REMAINS_EYE_BONE = "The peeper-bone went poof in the space-door!",
			REMAINS_THINGIE = "There must be a star-magic reason for that.",
		},
		AXE = "A trusty toy for chopping wood-blocks!",
		BABYBEEFALO =
		{
			GENERIC = "A baby fuzzy monster! So cute! RAWR!",
		    SLEEPING = "Sweet dreams, little smelly-puff.",
        },
        BUNDLE = "A secret surprise package!",
        BUNDLEWRAP = "Paper to wrap up shiny gifts!",
		BACKPACK = "I can fit so many toys and space-candies in here!",
		BACONEGGS = "The yummiest breakfast for a growing star-cub!",
		BANDAGE = "A hug for my boo-boos.",
		BASALT = "That rock is too grumpy to break!", --removed
		BEARDHAIR = "Ew! Someone left their itchy mane on the floor!",
		BEARGER = "What a giant fuzzy bully!",
		BEARGERVEST = "A super-warm hug for the cold days!",
		ICEPACK = "A cold-fluff bag for my snacks!",
		BEARGER_FUR = "A big pile of itchy-fluff.",
		BEDROLL_STRAW = "A crunchy bed, but it smells a bit stinky.",
		BEEQUEEN = "Don't poke me, giant spiky-fly queen!",
		BEEQUEENHIVE =
		{
			GENERIC = "It's a giant mountain of yummy-sticky-goop!",
			GROWING = "Is the sticky-mountain getting bigger?",
		},
        BEEQUEENHIVEGROWN = "How did the star-magic make it so humongous?!",
        BEEGUARD = "A grumpy guard for the spiky-queen.",
        HIVEHAT = "My star-head feels much safer inside the goop-hat.",
        MINISIGN =
        {
            GENERIC = "My paw-doodles are way prettier than that!",
            UNDRAWN = "Ooh! A blank canvas for my crayons!",
        },
        MINISIGN_ITEM = "I need to stick it in the ground before I doodle.",
		BEE =
		{
			GENERIC = "A little buzz-fly!",
			HELD = "No poking in my pocket!",
		},
		BEEBOX =
		{
			READY = "It's full of sweet golden star-syrup!",
			FULLHONEY = "It's overflowing with sticky-sweetness!",
			GENERIC = "Buzz-flies in a box!",
			NOHONEY = "No sticky-treats yet.",
			SOMEHONEY = "The buzz-flies are still cooking the treats.",
			BURNT = "Oh no! A land-supernova ruined the treat box!",
		},
		MUSHROOM_FARM =
		{
			STUFFED = "So many mushy-friends!",
			LOTS = "The mushy-friends love their log-house!",
			SOME = "Grow, little squishies, grow!",
			EMPTY = "It needs a little mushy-spark to start.",
			ROTTEN = "The log went to sleep forever. We need a new one.",
			BURNT = "A fire-tantrum got to it.",
			SNOWCOVERED = "Too cold for mushy-friends to come out and play.",
		},
		BEEFALO =
		{
			FOLLOWER = "The fuzzy monster wants to play follow the leader!",
			GENERIC = "A big smelly fuzzy monster!",
			NAKED = "Aww, he lost his mane. Don't be sad!",
			SLEEPING = "Shhh, the big monster is having a deep space-nap.",
            --Domesticated states:
            DOMESTICATED = "This one is my special, slightly-less-smelly friend!",
            ORNERY = "Uh oh, he's having a big grumpy tantrum.",
            RIDER = "He wants to give me a piggyback ride! Yay!",
            PUDGY = "His tummy-nebula is completely full of snacks!",
            MYPARTNER = "We're beef friends forever.",
            DEAD = "It was a tough one.",
            DEAD_MYPARTNER = "I hope we meat again.",
		},

		BEEFALOHAT = "A fake mane! But mine is way more sparkly.",
		BEEFALOWOOL = "It's fuzzy, but it smells like a wet doggie.",
		BEEHAT = "Keeps the spiky-flies away, but it flattens my ears!",
        BEESWAX = "Squishy bug-wax! Great for star-crafts.",
		BEEHIVE = "A busy house for the spiky-flies.",
		BEEMINE = "A surprise toy that buzzes!",
		BEEMINE_MAXWELL = "Mr. Fancy-Suit put angry flies in a jar!",--removed
		BERRIES = "Yummy red star-snacks!",
		BERRIES_COOKED = "Warm mushy snacks.",
        BERRIES_JUICY = "Super splashy star-snacks!",
        BERRIES_JUICY_COOKED = "Gotta munch these warm splashes before they go bad!",
		BERRYBUSH =
		{
			BARREN = "The bush is hungry for poop-snacks.",
			WITHERED = "It's too hot for the snack-plant!",
			GENERIC = "A bush full of little round treats!",
			PICKED = "All the treats are gone! Come back soon!",
			DISEASED = "The plant-friend is feeling yucky.",--removed
			DISEASING = "Uh oh, the bush's star-glow is fading.",--removed
			BURNING = "Ah! The snack-plant is having a supernova!",
		},
		BERRYBUSH_JUICY =
		{
			BARREN = "It needs tummy-food before it makes more splashes.",
			WITHERED = "The sun dried up all the splashy-treats!",
			GENERIC = "Splashy-treats! I'll save them for snack-time.",
			PICKED = "The bush is cooking up more splashy-treats.",
			DISEASED = "The splash-plant caught a boo-boo.",--removed
			DISEASING = "The leaves are acting wobbly and weird.",--removed
			BURNING = "Nooo! My splashy-snacks are burning!",
		},
		BIGFOOT = "A giant stompy-foot! Whoa!",--removed
		BIRDCAGE =
		{
			GENERIC = "A little metal house for a flap-flap friend.",
			OCCUPIED = "Who's a good little flap-flap?",
			SLEEPING = "Zzz... sweet dreams, little birdie.",
			HUNGRY = "The flap-flap is hungry for a seed-snack!",
			STARVING = "Oh no! Your tummy-nebula is completely empty!",
			DEAD = "Little flap-flap... went to sleep forever.",
			SKELETON = "Just a birdie-bone puzzle left.",
		},
		BIRDTRAP = "A sneaky toy for catching flap-flaps!",
		CAVE_BANANA_BURNT = "I didn't make that yellow snack go supernova! I promise!",
		BIRD_EGG = "A little round birdie-seed.",
		BIRD_EGG_COOKED = "Warm, squishy sun-snack!",
		BISHOP = "Go away, you meanie clock-head!",
		BLOWDART_FIRE = "Spitting fire-sparks is against the playground rules!",
		BLOWDART_SLEEP = "A sleepy-puff stick. Don't suck it backwards!",
		BLOWDART_PIPE = "Zoomy-dart! Like blowing out star-candles!",
		BLOWDART_YELLOW = "A super-zap zoomy-dart!",
		BLUEAMULET = "A frosty star-necklace! Brrr!",
		BLUEGEM = "A frozen blue space-candy!",
		BLUEPRINT =
		{
            COMMON = "Doodles for making fun things!",
            RARE = "Super-secret star-magic doodles!",
        },
        SKETCH = "A doodle of a statue! I need a play-table to make it.",
		COOKINGRECIPECARD =
		{
			GENERIC = "Science help me, I can't decipher this handwriting.",
		},
		BLUE_CAP = "A squishy blue snack.",
		BLUE_CAP_COOKED = "A warm squishy blue snack.",
		BLUE_MUSHROOM =
		{
			GENERIC = "A blue mushy-friend.",
			INGROUND = "The blue mush is hiding.",
			PICKED = "I hope it comes back to play later!",
		},
		BOARDS = "Smooth tree-blocks.",
		BONESHARD = "Teeny-tiny puzzle pieces.",
		BONESTEW = "A big yummy bowl of star-fuel!",
		BUGNET = "A swooshy net for catching sky-friends!",
		BUSHHAT = "A tickly hide-and-seek costume!",
		BUTTER = "Squishy yellow slippery-block!",
		BUTTERFLY =
		{
			GENERIC = "A flappy sun-bug! Wheee!",
			HELD = "A flappy-friend in my pocket!",
		},
		BUTTERFLYMUFFIN = "A yummy cupcake made with flappy-magic!",
		BUTTERFLYWINGS = "Beautiful flappy-petals!",
		BUZZARD = "A grumpy bald birdie!",

		SHADOWDIGGER = "Oh no, Mr. Fancy-Suit brought a shadow-twin to play!",
        SHADOWDANCER = "I don't hate this one!",

		CACTUS =
		{
			GENERIC = "A very pokey green snack.",
			PICKED = "A sad, pokey little stump.",
		},
		CACTUS_MEAT_COOKED = "Warm, non-pokey green snack!",
		CACTUS_MEAT = "It looks yummy, but I don't want to poke my nose.",
		CACTUS_FLOWER = "A pretty star on top of a pokey plant.",

		COLDFIRE =
		{
			EMBERS = "The cold-sparks are getting sleepy!",
			GENERIC = "A frosty mini-sun to keep the Big Dark away.",
			HIGH = "Whoa, that's a giant freezing supernova!",
			LOW = "The frosty-light is shrinking.",
			NORMAL = "A perfect, cool star-glow.",
			OUT = "The cold-sparks went poof.",
		},
		CAMPFIRE =
		{
			EMBERS = "The fire-sparks are hungry for wood-blocks!",
			GENERIC = "A cozy land-star to scare the shadows!",
			HIGH = "Too many boom-sparks! It's too hot!",
			LOW = "The land-star is falling asleep.",
			NORMAL = "Just right for a star-cub nap.",
			OUT = "Aww, the land-star went out.",
		},
		CANE = "A zoomy-stick to make my paws go super fast!",
		CATCOON = "A fuzzy tail-friend! Let's pounce!",
		CATCOONDEN =
		{
			GENERIC = "The tail-friend's little wood-house.",
			EMPTY = "The tail-friend went away.",
		},
		CATCOONHAT = "A hat with ears just like mine!",
		COONTAIL = "A soft, swishy tail toy!",
		CARROT = "An orange pointy-snack from the dirt.",
		CARROT_COOKED = "Cutted and warmy pointy-snack.",
		CARROT_PLANTED = "The dirt is growing a pointy-snack.",
		CARROT_SEEDS = "Little bits of orange star-magic.",
		CARTOGRAPHYDESK =
		{
			GENERIC = "Now I can show everyone what I found!",
			BURNING = "So much for that.",
			BURNT = "Nothing but ash now.",
		},
		WATERMELON_SEEDS = "A teeny-tiny water-splash seed!",
		CAVE_FERN = "A leafy-friend hiding in the dark.",
		CHARCOAL = "A burnt little wood-crispy! It makes my paws dirty.",
        CHESSPIECE_PAWN = "A little stone-friend! We can play checkers!",
        CHESSPIECE_ROOK =
        {
            GENERIC = "A giant heavy castle-toy!",
            STRUGGLE = "Whoa! The stone-toys are playing tag by themselves!",
        },
        CHESSPIECE_KNIGHT =
        {
            GENERIC = "A rock-pony! Giddy-up!",
            STRUGGLE = "The rock-pony wants to play!",
        },
        CHESSPIECE_BISHOP =
        {
            GENERIC = "A tall pointy stone-toy.",
            STRUGGLE = "The pointy-toy is getting all wiggly!",
        },
        CHESSPIECE_MUSE = "It looks like a pretty star-lady.",
        CHESSPIECE_FORMAL = "That's a very silly looking crown!",
        CHESSPIECE_HORNUCOPIA = "A stone-basket full of fake snacks! Now I'm hungry.",
        CHESSPIECE_PIPE = "A bubble-blower made of rock? How silly!",
        CHESSPIECE_DEERCLOPS = "Eek! The stone monster is staring at me!",
        CHESSPIECE_BEARGER = "The fuzzy bully turned into a heavy rock!",
        CHESSPIECE_MOOSEGOOSE =
        {
            "Eurgh. It's so lifelike.",
        },
        CHESSPIECE_DRAGONFLY = "A stone fly-dragon! Good thing it can't spit lava anymore.",
		CHESSPIECE_MINOTAUR = "Now you're the one scared stiff!",
        CHESSPIECE_BUTTERFLY = "A giant stone flappy-friend!",
        CHESSPIECE_ANCHOR = "A giant heavy sinky-hook!",
        CHESSPIECE_MOON = "It's a piece of the night-cheese in a fancy shape!",
        CHESSPIECE_CARRAT = "We have a winner!",
        CHESSPIECE_MALBATROSS = "It's not so bad when it isn't trying to kill you.",
        CHESSPIECE_CRABKING = "Still not as crabby as Maxwell.",
        CHESSPIECE_TOADSTOOL = "Not really a great stool though, is it?",
        CHESSPIECE_STALKER = "Exactly as stationary as a skeleton should be.",
        CHESSPIECE_KLAUS = "Can I invoke the \"no holiday decorations\" Klaus?",
        CHESSPIECE_BEEQUEEN = "Very statuesque.",
        CHESSPIECE_ANTLION = "A stagn-antlion.",
        CHESSPIECE_BEEFALO = "This sculpture is pretty beefy.",
		CHESSPIECE_KITCOON = "These ones are much easier to find.",
		CHESSPIECE_CATCOON = "It would probably make a great scratching post.",
        CHESSPIECE_MANRABBIT = "I want to hug it, but the stone chafes.",
        CHESSPIECE_GUARDIANPHASE3 = "I much prefer it this way.",
        CHESSPIECE_EYEOFTERROR = "It's giving me a stony stare.",
        CHESSPIECE_TWINSOFTERROR = "That was a terrible night of very uncomfortable eye contact.",
        CHESSPIECE_DAYWALKER = "Now he's off who-knows-were.",
        CHESSPIECE_DAYWALKER2 = "This belongs in a junkpile!",
        CHESSPIECE_DEERCLOPS_MUTATED = "This sculpture is a bit of an eyesore.",
        CHESSPIECE_WARG_MUTATED = "It's just missing that horrible breath.",
        CHESSPIECE_BEARGER_MUTATED = "Somehow it seems crankier than the real one.",
        CHESSPIECE_SHARKBOI = "There's just some-fin about it.",
        CHESSPIECE_WORMBOSS = "It still shakes me up.",
        CHESSPIECE_YOTS = "I usually try to stay away from gold diggers.",
        CHESSPIECE_WAGBOSS_ROBOT = "Great design, questionable execution.",
        CHESSPIECE_WAGBOSS_LUNAR = "I'm over the night!",
        CHESSPIECE_YOTH = "That was a rough knight.",

        CHESSJUNK1 = "Aww, someone broke the stone toys.",
        CHESSJUNK2 = "More broken toy pieces. So sad.",
        CHESSJUNK3 = "I wish I had some star-glue to fix these.",
		CHESTER = "A bouncy fur-box friend! Yay!",
		CHESTER_EYEBONE =
		{
			GENERIC = "A little peeper on a stick! Peek-a-boo!",
			WAITING = "The peeper closed its eye. Sleepy time.",
		},
		COOKEDMANDRAKE = "Oh no, the noisy root-friend got all crispy.",
		COOKEDMEAT = "Yummy warm meat-snack!",
		COOKEDMONSTERMEAT = "It's warm now, but it still smells like a grumpy monster.",
		COOKEDSMALLMEAT = "A perfectly hot bite-sized snack!",
		COOKPOT =
		{
			COOKING_LONG = "My tummy-nebula is rumbling! Hurry up, food!",
			COOKING_SHORT = "I can smell the yummy star-fuel!",
			DONE = "Snack time! Yay!",
			EMPTY = "I need to put some ingredients in the magic food-bowl!",
			BURNT = "The food-bowl had a land-supernova! All black now.",
		},
		CORN = "A yellow bumpy-snack!",
		CORN_COOKED = "A warm, toasty bumpy-snack! Yum!",
		CORN_SEEDS = "Little yellow nuggets of star-magic.",
        CANARY =
		{
			GENERIC = "A yellow flap-flap! It matches my mane!",
			HELD = "You're safe in my paw, little yellow-friend!",
		},
        CANARY_POISONED = "Oh no! The yellow flap-flap is feeling yucky!",

		CRITTERLAB = "A magic house for making new best friends!",
        CRITTER_GLOMLING = "A baby floaty-goop! So squishy!",
        CRITTER_DRAGONLING = "A teeny fly-dragon! Please don't sneeze fire!",
		CRITTER_LAMB = "A fluffy little baby! Like a mini-cloud!",
        CRITTER_PUPPY = "A zoomy doggie-friend! Let's play fetch!",
        CRITTER_KITTEN = "A little tail-friend! We can pounce together!",
        CRITTER_PERDLING = "A baby gobble-bird! Keep away from my snacks!",
		CRITTER_LUNARMOTHLING = "A little night-bug! She loves my shiny mane.",

		CROW =
		{
			GENERIC = "A dark shadow-birdie!",
			HELD = "Don't peck my paws, shadow-birdie!",
		},
		CUTGRASS = "A bunch of tickle-grass for building toys.",
		CUTREEDS = "Hollow grass-tubes for making things!",
		CUTSTONE = "A perfect, smooth building-block!",
		DEADLYFEAST = "That smells like a tummy-ache waiting to happen!", --unimplemented
		DEER =
		{
			GENERIC = "A bouncy-friend with a funny hat!",
			ANTLER = "A fuzzy-bone hat piece!",
		},
        DEER_ANTLER = "The bouncy-friend dropped his head-toy!",
        DEER_GEMMED = "Oh no! The bouncy-friend has a bad-magic rock in his head!",
		DEERCLOPS = "Ahhh! A giant one-eyed winter bully!",
		DEERCLOPS_EYEBALL = "A giant squishy peeper! Ew ew ew!",
		EYEBRELLAHAT =	"A peeper-umbrella! It looks at the clouds for me.",
		DEPLETED_GRASS =
		{
			GENERIC = "The tickle-grass is all sleepy and sad.",
		},
        GOGGLESHAT = "Funny glasses! Do they give me super star-vision?",
        DESERTHAT = "A hat to keep the itchy sand out of my peepers!",
        ANTLIONHAT = "It's a groundbreaking scientific achievement.",
		DEVTOOL = "A magic super-toy!",
		DEVTOOL_NODEV = "It's too heavy for a little star-cub!",
		DIRTPILE = "A messy dirt-lump! Did a friend hide here?",
		DIVININGROD =
		{
			COLD = "The beep-boop stick is very quiet.", --singleplayer
			GENERIC = "A magic beep-boop stick for finding hidden toys!", --singleplayer
			HOT = "Beep beep beep! It's having a noisy tantrum!", --singleplayer
			WARM = "It's humming a happy little song!", --singleplayer
			WARMER = "The hum is getting louder! We're close!", --singleplayer
		},
		DIVININGRODBASE =
		{
			GENERIC = "A strange magic-stand.", --singleplayer
			READY = "It wants me to plug in the beep-boop stick!", --singleplayer
			UNLOCKED = "Yay! The magic machine woke up!", --singleplayer
		},
		DIVININGRODSTART = "Ooh, a shiny beep-boop toy!", --singleplayer
		DRAGONFLY = "A giant angry lava-bug! RAWR!",
		ARMORDRAGONFLY = "A tough fiery shirt! I'm a lava-knight!",
		DRAGON_SCALES = "Shiny hot flakes from the lava-bug!",
		DRAGONFLYCHEST =
		{
			GENERIC = "Next best thing to a lockbox!",
            UPGRADED_STACKSIZE = "The amount of storage is off the scale!",
		},
		DRAGONFLYFURNACE =
		{
			HAMMERED = "Oopsie, the hot-box got squished.",
			GENERIC = "A cozy hot-box for warming my paws.", --no gems
			NORMAL = "It's glowing like a happy little star!", --one gem
			HIGH = "It's having a mega-hot supernova! Back up!", --two gems
		},

        HUTCH = "A bouncy fishy-box! Hi, friend!",
        HUTCH_FISHBOWL =
        {
            GENERIC = "A tiny water-home for a fishy!",
            WAITING = "The fishy wants a shiny toy to play with.",
        },
		LAVASPIT =
		{
			HOT = "Spicy lava-puddle! Don't step on it!",
			COOL = "The lava-puddle went to sleep and got hard.",
		},
		LAVA_POND = "A giant puddle of hot liquid sunshine!",
		LAVAE = "A speedy little lava-worm! Zoom!",
		LAVAE_COCOON = "The lava-worm is taking a frosty nap.",
		LAVAE_PET =
		{
			STARVING = "Oh no! The little hot-worm needs snacks right now!",
			HUNGRY = "I hear a tiny rumble in its fiery tummy!",
			CONTENT = "A happy, warm little friend!",
			GENERIC = "Who's a good fiery zoomy-bug?",
		},
		LAVAE_EGG =
		{
			GENERIC = "A warm, glowing bounce-egg!",
		},
		LAVAE_EGG_CRACKED =
		{
			COLD = "The bounce-egg is shivering! Needs more fire-hugs!",
			COMFY = "A perfectly warm, happy little egg.",
		},
		LAVAE_TOOTH = "A teeny-tiny fire-tooth!",

		DRAGONFRUIT = "A red bumpy-snack! So pretty!",
		DRAGONFRUIT_COOKED = "A warm red bumpy-snack!",
		DRAGONFRUIT_SEEDS = "Little magic seeds for growing pink snacks.",
		DRAGONPIE = "A delicious red dragon-pie! My favorite!",
		DRUMSTICK = "A flappy-friend's leg! Looks like a good chew-toy.",
		DRUMSTICK_COOKED = "A warm, yummy chew-toy snack!",
		DUG_BERRYBUSH = "A sleepy snack-plant. I can carry it to my base!",
		DUG_BERRYBUSH_JUICY = "A sleepy splash-plant. Let's find it a new dirt-bed.",
		DUG_GRASS = "Sleepy tickle-grass for my pocket.",
		DUG_MARSH_BUSH = "A sleepy spiky-bush. Handle with care!",
		DUG_SAPLING = "A sleepy little stick-tree.",
		DURIAN = "Ew, it smells like a grumpy monster's armpit!",
		DURIAN_COOKED = "Now it's a hot, stinky monster armpit! Blech!",
		DURIAN_SEEDS = "Seeds for growing stinky-snacks.",
		EARMUFFSHAT = "Fuzzy hug-muffs for my ears!",
		EGGPLANT = "A purple wobbly-snack!",
		EGGPLANT_COOKED = "A warm, mushy purple snack.",
		EGGPLANT_SEEDS = "Seeds for growing wobbly purple things.",

		ENDTABLE =
		{
			BURNT = "Aww, the pretty table went supernova.",
			GENERIC = "A fancy little table for displaying toys!",
			EMPTY = "It needs a pretty flower or a shiny gem!",
			WILTED = "The flower-friend is feeling droopy.",
			FRESHLIGHT = "A happy little star-lamp!",
			OLDLIGHT = "The light is getting sleepy.", -- will be wilted soon, light radius will be very small at this point
		},
		DECIDUOUSTREE =
		{
			BURNING = "The colorful tree is having a fire-tantrum!",
			BURNT = "A sad, crispy stick.",
			CHOPPED = "TIMBER! Watch your head!",
			POISON = "Uh oh! The tree-friend is a giant monster now! RAWR!",
			GENERIC = "A big tree with colorful hair!",
		},
		ACORN = "A little nut-ball! I wonder what's inside?",
        ACORN_SAPLING = "A baby colorful tree!",
		ACORN_COOKED = "A warm, crunchy nut-snack!",
		BIRCHNUTDRAKE = "Eek! The nut-ball grew angry legs!",
		EVERGREEN =
		{
			BURNING = "The pointy tree is on fire!",
			BURNT = "Just black stardust now.",
			CHOPPED = "Down goes the pointy giant!",
			GENERIC = "A big green pointy-tree.",
		},
		EVERGREEN_SPARSE =
		{
			BURNING = "Fire in the sad tree!",
			BURNT = "All burnt up.",
			CHOPPED = "Timber!",
			GENERIC = "This tree looks like it needs a star-hug.",
		},
		TWIGGYTREE =
		{
			BURNING = "The stick-tree is burning!",
			BURNT = "Crispy twigs.",
			CHOPPED = "Yay, building sticks!",
			GENERIC = "A tree made of lots of little zoomy-sticks.",
			DISEASED = "The stick-tree is feeling yucky.", --unimplemented
		},
		TWIGGY_NUT_SAPLING = "A baby stick-tree sprouting up!",
        TWIGGY_OLD = "The stick-tree is getting very old and wobbly.",
		TWIGGY_NUT = "A funny little stick-seed.",
		EYEPLANT = "Ew! slimy ground-peeper! Don't look at me!",
		INSPECTSELF = "My mane is perfectly sparkly today! RAWR!",
		FARMPLOT =
		{
			GENERIC = "A little dirt-bed for growing snacks!",
			GROWING = "Grow, little green-friends, grow!",
			NEEDSFERTILIZER = "The dirt is hungry for a poop-snack.",
			BURNT = "Aww, the dirt got all crispy. No snacks will grow here now.",
		},
		FEATHERHAT = "I'm a flappy-bird lion now! Tweet tweet!",
		FEATHER_CROW = "A feather from the shadow-birdie.",
		FEATHER_ROBIN = "A pretty red flappy-feather.",
		FEATHER_ROBIN_WINTER = "A fluffy snow-birdie feather.",
		FEATHER_CANARY = "A yellow feather that matches my mane!",
		FEATHERPENCIL = "A tickly doodle-stick for drawing star-maps!",
        COOKBOOK = "I've always been hungry for knowledge.",
		FEM_PUPPET = "Oh no, she's stuck! We have to help her!", --single player
		FIREFLIES =
		{
			GENERIC = "Little floating star-bugs! I wanna play tag with them!",
			HELD = "I have a pocket full of tiny stars!",
		},
		FIREHOUND = "A grumpy doggie made of fire!",
		FIREPIT =
		{
			EMBERS = "The land-star is hungry for more wood-blocks!",
			GENERIC = "A happy fire-circle to keep the Big Dark away.",
			HIGH = "Whoa! It's doing a mini-supernova!",
			LOW = "The fire-sparks are getting very sleepy.",
			NORMAL = "Nice and warm, like a sunbeam.",
			OUT = "The land-star went to sleep.",
		},
		COLDFIREPIT =
		{
			EMBERS = "The frosty-sparks need more fuel!",
			GENERIC = "A chilly star-circle for hot days.",
			HIGH = "A giant freezing supernova! Brrr!",
			LOW = "The cold-sparks are fading.",
			NORMAL = "Perfectly cool and sparkly.",
			OUT = "The frosty-star melted away.",
		},
		FIRESTAFF = "A magic stick that shoots boom-sparks!",
		FIRESUPPRESSOR =
		{
			ON = "The snowball-machine is awake! Yay!",
			OFF = "The snowball-machine is taking a nap.",
			LOWFUEL = "The snowball-machine's tummy is almost empty.",
		},

		FISH = "A wiggly water-snack!",
		FISHINGROD = "A stringy-stick for catching water-friends!",
		FISHSTICKS = "Crispy water-snack sticks!",
		FISHTACOS = "A crunchy folded star-snack!",
		FISH_COOKED = "Warm and squishy water-snack.",
		FLINT = "A pointy grey rock. Ouchie!",
		FLOWER =
		{
            GENERIC = "A pretty little ground-star!",
            ROSE = "A red pointy-flower! Smells nice, but it bites.",
        },
        FLOWER_WITHERED = "The ground-star is all droopy and sad.",
		FLOWERHAT = "A crown of ground-stars for a star king!",
		FLOWER_EVIL = "A spooky shadow-flower! It gives me the shivers.",
		FOLIAGE = "Just a bunch of green leaves.",
		FOOTBALLHAT = "A funny helmet made from a piggy's bottom!",
        FOSSIL_PIECE = "Old spooky bones! Like a giant puzzle.",
        FOSSIL_STALKER =
        {
			GENERIC = "The bone-puzzle isn't finished yet.",
			FUNNY = "Oopsie! I put the bones together all wrong!",
			COMPLETE = "A giant bone-monster! Good thing it's just a statue.",
        },
        STALKER = "Ahhh! The bad-magic woke up the bone-monster!",
        STALKER_ATRIUM = "It's the king of the bone-bullies!",
        STALKER_MINION = "Little bone-biters! Shoo!",
        THURIBLE = "A stinky smoke-lamp.",
        ATRIUM_OVERGROWTH = "Spooky shadow-doodles. I don't like them.",
		FROG =
		{
			DEAD = "The bouncy-green friend stopped bouncing.",
			GENERIC = "A bouncy green hop-frog! Boing!",
			SLEEPING = "Shh, the hop-frog is dreaming of flies.",
		},
		FROGGLEBUNWICH = "A bouncy-leg sandwich!",
		FROGLEGS = "Squishy frog-legs. Kind of gross.",
		FROGLEGS_COOKED = "Warm and crispy bouncy-legs.",
		FRUITMEDLEY = "A bowl full of splashy star-snacks!",
		FURTUFT = "A little puff of fuzzy monster hair.",
		GEARS = "Spinny metal toys from the clock-bullies!",
		GHOST = "Eek! A floaty cloud-meanie!",
		GOLDENAXE = "A shiny gold chopper-toy!",
		GOLDENPICKAXE = "A sparkly toy for breaking rocks!",
		GOLDENPITCHFORK = "A fancy gold fork for the dirt!",
		GOLDENSHOVEL = "A shiny toy for digging treasure!",
		GOLDNUGGET = "Shiny! It looks like a piece of my solar mane!",
		GRASS =
		{
			BARREN = "The tickle-grass is hungry for a stinky-snack.",
			WITHERED = "The sun-friend made the tickle-grass too hot!",
			BURNING = "The tickle-grass is having a fiery tantrum!",
			GENERIC = "A bunch of yellow tickle-grass.",
			PICKED = "I gave the grass a haircut!",
			DISEASED = "The grass caught a yucky bug.", --unimplemented
			DISEASING = "The grass is looking a bit wobbly.", --unimplemented
		},
		GRASSGEKKO =
		{
			GENERIC = "A zoomy leaf-lizard! Tag, you're it!",
			DISEASED = "The zoomy-lizard is feeling yucky.", --unimplemented
		},
		GREEN_CAP = "A green mushy-squish. smells weird!.",
		GREEN_CAP_COOKED = "A warm green mushy-squish. smells nice!",
		GREEN_MUSHROOM =
		{
			GENERIC = "A green mushy-friend.",
			INGROUND = "The green mush is hiding.",
			PICKED = "I hope the green mush comes back to play.",
		},
		GUNPOWDER = "Explodey-dust! Keep away from sparks!",
		HAMBAT = "A squishy meat-bonker! So silly!",
		HAMMER = "A heavy bonk-toy for smashing things!",
		HEALINGSALVE = "Magic star-goo to fix my boo-boos!",
		HEATROCK =
		{
			FROZEN = "It's a freezing popsic-rock! Brrr!",
			COLD = "The cuddle-rock is a bit chilly.",
			GENERIC = "A heavy cuddle-rock.",
			WARM = "A warm and snuggly cuddle-rock!",
			HOT = "It's glowing like a little sun! So toasty!",
		},
		HOME = "A little house! Is anyone home?",
		HOMESIGN =
		{
			GENERIC = "A wooden doodle-board!",
            UNWRITTEN = "It needs a pretty star-doodle!",
			BURNT = "Aww, the doodle-board got burnt.",
		},
		ARROWSIGN_POST =
		{
			GENERIC = "A pointy wooden stick showing the way!",
            UNWRITTEN = "Which way do we go, pointy stick?",
			BURNT = "The pointy stick went supernova.",
		},
		ARROWSIGN_PANEL =
		{
			GENERIC = "A pointy doodle-board!",
            UNWRITTEN = "Where should I point it?",
			BURNT = "No more pointing for this crispy board.",
		},
		HONEY = "Sticky, sweet golden star-syrup!",
		HONEYCOMB = "A sticky-block from the buzz-flies' house.",
		HONEYHAM = "A giant, sticky, yummy meat-snack!",
		HONEYNUGGETS = "Sticky little meat-bites! Yum!",
		HORN = "A fuzzy monster's tooter! TOOT TOOT!",
		HOUND = "A scary bad-doggie! Go away!",
		HOUNDCORPSE =
		{
			GENERIC = "Pee-yew! The bad-doggie smells terrible.",
			BURNING = "The bad-doggie is getting all crispy.",
			REVIVING = "Oh no! The bad-doggie is waking up again!",
		},
		HOUNDBONE = "A bone from a bad-doggie.",
		HOUNDMOUND = "A dirt-house for the bad-doggies.",
		ICEBOX = "A frosty magic box to keep my snacks cold!",
		ICEHAT = "A giant ice-cube for my head! It's so chilly!",
		ICEHOUND = "A frosty bad-doggie! Brrr!",
		INSANITYROCK =
		{
			ACTIVE = "Scary shadow-rock! It's giving me the wibbly-wobblies!",
			INACTIVE = "weird pointy rock is taking a nap.",
		},
		JAMMYPRESERVES = "Squishy berry-jam! It gets all over my paws!",

		KABOBS = "A star-snack on a stick!",
		KILLERBEE =
		{
			GENERIC = "A super-grumpy red spiky-fly! Run!",
			HELD = "It's very angry in my pocket!",
		},
		KNIGHT = "A grumpy clock-pony!",
		KOALEFANT_SUMMER = "A big snorty-friend with a funny nose!",
		KOALEFANT_WINTER = "A fuzzy snorty-friend! Let's cuddle!",
		KOALEFANT_CARCASS = "Adorably dead.",
		KRAMPUS = "A meanie goat-thief! Give me back my toys!",
		KRAMPUS_SACK = "just like my sunny bag! Wait... sunny bag?",
		LEIF = "The tree-friend grew arms and legs! And he's mad!",
		LEIF_SPARSE = "A giant grumpy tree-monster!",
		LIGHTER  = "Willow's favorite tiny fire-toy.",
		LIGHTNING_ROD =
		{
			CHARGED = "It caught a sky-spark! So pretty!",
			GENERIC = "A metal stick to catch the scary sky-sparks.",
		},
		LIGHTNINGGOAT =
		{
			GENERIC = "A bouncy goat-friend!",
			CHARGED = "The goat-friend is full of zoomy sky-sparks!",
		},
		LIGHTNINGGOATHORN = "A pointy spark-horn!",
		GOATMILK = "Buzzy, tingly goat-juice!",
		LITTLE_WALRUS = "A baby snorty-walrus! He's kind of cute.",
		LIVINGLOG = "A magical wood-block with a face!",
		LOG =
		{
			BURNING = "The wood-block is having a mini-supernova!",
			GENERIC = "A heavy wood-block for building.",
		},
		LUCY = "Mr. Wood-Chopper's talking sharp toy!",
		LUREPLANT = "A sneaky trap-flower!",
		LUREPLANTBULB = "A seed to grow my very own trap-flower.",
		MALE_PUPPET = "Oh no! The poor friend is stuck in a bad-magic chair!", --single player

		MANDRAKE_ACTIVE = "Stop being so noisy, little root-friend!",
		MANDRAKE_PLANTED = "I think a noisy-plant is hiding in the dirt.",
		MANDRAKE = "A little root-baby! It has weird star-magic.",

        MANDRAKESOUP = "Oh no... the root-baby went to sleep forever in my tummy-bowl.",
        MANDRAKE_COOKED = "It's warm and quiet now...",
        MAPSCROLL = "A doodle-paper with no doodles! How boring.",
        MARBLE = "A heavy, shiny stone block!",
        MARBLEBEAN = "I traded a shiny stone for a magic stone-seed! Wow!",
        MARBLEBEAN_SAPLING = "A baby stone-tree! It's so stiff.",
        MARBLESHRUB = "A bush made of heavy rocks? Stone magic is silly.",
        MARBLEPILLAR = "A giant stone stick! Maybe a giant dropped his toy.",
        MARBLETREE = "A tree made of rocks! My chopper-toy won't like this.",
        MARSH_BUSH =
        {
			BURNT = "The pointy-bush had a supernova. Yay! No more pokies.",
            BURNING = "Fire in the pointy-bush! Wheee!",
            GENERIC = "A very grumpy, pointy bush. Don't touch!",
            PICKED = "Ouchie! It gave me a poke!",
        },
        BURNT_MARSH_BUSH = "All crispy and safe to step on.",
        MARSH_PLANT = "Just a soggy little green-friend.",
        MARSH_TREE =
        {
            BURNING = "The spiky tree is having a fire-tantrum!",
            BURNT = "Crispy and black, but still a little bit spiky.",
            CHOPPED = "I chopped down the giant pokey-stick!",
            GENERIC = "A tall tree covered in meanie-spikes!",
        },
        MAXWELL = "Mr. Fancy-Suit! I don't like his shadow-magic.",--single player
        MAXWELLHEAD = "A giant, spooky Mr. Fancy-Suit head! Eek!",--removed
        MAXWELLLIGHT = "A shadow-lamp. Where's the star inside?",--single player
        MAXWELLLOCK = "A spooky hole waiting for a magic key-toy.",--single player
        MAXWELLTHRONE = "That chair looks super un-comfy. Like a bad-magic timeout seat.",--single player
        MEAT = "A squishy meat-snack. It smells a bit wild.",
        MEATBALLS = "A giant, yummy ball of star-fuel!",
        MEATRACK =
        {
            DONE = "Yay! The chewy-snacks are ready!",
            DRYING = "The meat-snack is taking a long sun-nap.",
            DRYINGINRAIN = "The sky-juice is making the snack-nap take forever!",
            GENERIC = "A hanging-toy for making chewy snacks.",
            BURNT = "Oh no, my snack-hanger went poof!",
            DONE_NOTMEAT = "It's all dry and crispy now!",
            DRYING_NOTMEAT = "Drying things out is serious star-business.",
            DRYINGINRAIN_NOTMEAT = "Sky-juice, go away! My toys are getting soggy!",
        },
        MEAT_DRIED = "A tough and yummy chewy-snack!",
        MERM = "A fishy-frog meanie! Pee-yew!",
        MERMHEAD =
        {
            GENERIC = "The stinkiest stick-toy ever! Blech!",
            BURNT = "A crispy stinky stick. Still yucky.",
        },
        MERMHOUSE =
        {
            GENERIC = "A wobbly mud-house for the fishy-frogs.",
            BURNT = "The fishy-house had a fiery supernova.",
        },
        MINERHAT = "A hat with a tiny sun on it! Perfect for the Big Dark.",
        MONKEY = "A sneaky little tail-friend! Are you gonna steal my toys?",
        MONKEYBARREL = "A barrel full of sneaky tail-friends! I heard a squeak!",
        MONSTERLASAGNA = "A yucky layered cake of monster parts. Gross!",
        FLOWERSALAD = "A bowl full of pretty ground-stars!",
        ICECREAM = "A frozen sweet star-snack! so yummy!",
        WATERMELONICLE = "A chilly splash-snack on a stick! Brrr-yum!",
        TRAILMIX = "Crunchy bits of forest-magic in a bowl.",
        HOTCHILI = "Spicy fire-snack! It makes my mouth do a supernova!",
        GUACAMOLE = "Squishy green dip for my snacks!",
        MONSTERMEAT = "Ew! Grumpy monster meat. It looks sick.",
        MONSTERMEAT_DRIED = "A chewy-snack, but it still smells like a bully.",
        MOOSE = "A giant honk-bird-moose! What a silly mix-up!",
        MOOSE_NESTING_GROUND = "A giant bed of twigs for the honk-bird babies.",
        MOOSEEGG = "A giant bouncy egg! It's zapping with sky-sparks!",
        MOSSLING = "A fluffy little spinny-bird! Wheee!",
        FEATHERFAN = "A giant flappy-toy to blow the hot air away!",
        MINIFAN = "A little spinny-toy to keep my mane cool.",
        GOOSE_FEATHER = "A giant, fluffy cloud-feather!",
        STAFF_TORNADO = "A magic stick that makes a super-spinny wind!",
        MOSQUITO =
        {
            GENERIC = "A meanie poke-fly! Go away!",
            HELD = "Stop trying to drink my star-juice!",
        },
        MOSQUITOSACK = "Ew! A bag of yucky bug-juice.",
        MOUND =
        {
            DUG = "I dug up a secret hiding spot!",
            GENERIC = "A dirt-bump! Is there a hidden toy inside?",
        },
        NIGHTLIGHT = "A dark-sun that eats bad-magic to glow. wait...",
        NIGHTMAREFUEL = "It looks like a tiny nightmare in a jar. So spooky!",
        NIGHTSWORD = "A pointy sword made of bad dreams. I don't like it.",
        NITRE = "A sparkly sun rock that goes BOOM!",
        ONEMANBAND = "A super-noisy music suit! Toot toot bang!",
        OASISLAKE =
		{
			GENERIC = "The giant water-puddle in the middle of the sand-box!",
			EMPTY = "Oh no, the big puddle went completely dry.",
		},
        PANDORASCHEST = "A magic box! Is it a happy surprise or a spooky surprise?",
        PANFLUTE = "The instrument that little imp loves so much! Its twinkly tunes make everyone sooo sleepy... *yaaawn!*",
        PAPYRUS = "Smooth doodle-paper!",
        WAXPAPER = "Shiny paper for wrapping up special treats.",
        PENGUIN = "Funny little slidey-birds! They love the cold.",
        PERD = "A sneaky gobble-bird! Stop eating my star-snacks!",
        PEROGIES = "Warm, squishy little tummy-pillows!",
        PETALS = "Pretty flower pieces for crafting toys.",
        PETALS_EVIL = "Spooky shadow-petals. They smell like bad dreams.",
        PHLEGM = "Super-sticky, salty monster-boogers. Ew ew ew!",
        PICKAXE = "A heavy pointy-toy for smashing rocks!",
        PIGGYBACK = "A backpack made out of a meanie-pig! It's spooky, but at least he can't hit me now.",
        PIGHEAD =
        {
            GENERIC = "A meanie-pig head on a stick! It gives me the shivers.",
            BURNT = "A crispy burnt stick. It's way less scary now!",
        },
        PIGHOUSE =
        {
            FULL = "There's a grumpy snout in the window! I better stay away.",
            GENERIC = "A little wooden house where the oink-bullies live.",
            LIGHTSOUT = "The meanie is taking a dark-nap. Shhh, don't wake him up!",
            BURNT = "The bully's house had a giant fire-tantrum.",
        },
        PIGKING = "The giant boss of all the bullies! He's super greedy for shiny rocks.",
        PIGMAN =
        {
            DEAD = "The grumpy oink-meanie took a forever-nap.",
            FOLLOWER = "He's following me... is he playing tag, or is he going to bite my tail?",
            GENERIC = "A walking piggy! But he's a big bully and always tries to hit me.",
            GUARD = "A super-grumpy piggy-guard. He really doesn't like star-cubs!",
            WEREPIG = "Ahhh! The meanie-piggy turned into a giant hairy monster-bully! Run!",
        },
        PIGSKIN = "A piece of a piggy's coat. It still has the curly tail!",
        PIGTENT = "A stinky mud-tent for a fishy-frog.",
        PIGTORCH = "A big fire-stick for the piggy guards.",
        PINECONE = "A baby pointy-tree wrapped in a crunchy shell.",
        PINECONE_SAPLING = "A teeny-tiny pointy tree!",
        LUMPY_SAPLING = "A baby tree that looks like a bumpy potato.",
        PITCHFORK = "A giant fork for scratching the dirt!",
        PLANTMEAT = "A weird leafy meat-snack. Is it a plant or a monster?",
        PLANTMEAT_COOKED = "A warm, weird leafy snack.",
        PLANT_NORMAL =
        {
            GENERIC = "A happy little green-friend!",
            GROWING = "Grow faster, little plant! I want a snack!",
            READY = "Yay! The star-snack is ready to pick!",
            WITHERED = "Oh no, the sun-friend was too hot for it.",
        },
        POMEGRANATE = "A bumpy red fruit full of tiny squishy seeds.",
        POMEGRANATE_COOKED = "A warm, sweet and bumpy snack!",
        POMEGRANATE_SEEDS = "Magic seeds to grow bumpy red fruits.",
        POND = "A giant puddle full of splashy-friends!",
        POOP = "Ew! Stinky monster-poop! But the plants like it.",
        FERTILIZER = "A whole bucket of super-stinky plant-food!",
        PUMPKIN = "A giant orange wobble-gourd!",
        PUMPKINCOOKIE = "A yummy cookie made of orange star-magic!",
        PUMPKIN_COOKED = "Warm and mushy orange snack.",
        PUMPKIN_LANTERN = "A glowing orange face! Spooky-rawr!",
        PUMPKIN_SEEDS = "Little seeds for growing giant orange heads.",
        PURPLEAMULET = "A spooky star-necklace. It whispers weird things.",
        PURPLEGEM = "A glowing purple space-candy. Very mysterious.",
        RABBIT =
        {
            GENERIC = "A little bunny-friend! Hop hop!",
            HELD = "A soft little hopper in my pocket!",
        },
        RABBITHOLE =
        {
            GENERIC = "I bet all the bouncy-bunnies are having a secret dirt-party down there!",
            SPRING = "The bouncy-bunny tunnel is flooded with splashy-water!",
        },
        RAINOMETER =
        {
            GENERIC = "This spinny-toy points at the clouds to see if sky-juice is coming!",
            BURNT = "Oh no, the sky-juice meter got all crispy and broke.",
        },
        RAINCOAT = "Keeps my sparkly mane perfectly dry from the sky-juice!",
        RAINHAT = "My head feels squished, but at least it's not soggy.",
        RATATOUILLE = "A big bowl of squishy cooked green-friends!",
        RAZOR = "A sharp scraping rock. Keep it away from my fur!",
        REDGEM = "Warm and sparkly! It glows like a tiny red star.",
        RED_CAP = "Pee-yew! This red mushy-friend smells like bad medicine.",
        RED_CAP_COOKED = "The fire changed its smell. Still not eating it!",
        RED_MUSHROOM =
        {
            GENERIC = "A squishy red umbrella-plant.",
            INGROUND = "The little red umbrella is hiding in the dirt.",
            PICKED = "I took the umbrella! Will it grow another one?",
        },
        REEDS =
        {
            BURNING = "The tickle-grass is having a fire-tantrum!",
            GENERIC = "Tall, squeaky tickle-grass.",
            PICKED = "I pulled all the good squeaky-strings out.",
        },
        RELIC = "Funny old cups and plates from a long time ago.",
        RUINS_RUBBLE = "A messy pile of rocks. I think I can fix it!",
        RUBBLE = "Just broken little pieces of heavy stones.",
        RESEARCHLAB =
        {
            GENERIC = "A magical science-table to teach me new tricks!",
            BURNT = "Oh no! The learning-table had a supernova!",
        },
        RESEARCHLAB2 =
        {
            GENERIC = "A super-smart beep-boop machine! It knows everything!",
            BURNT = "All the smartness got burnt up into ash.",
        },
        RESEARCHLAB3 =
        {
            GENERIC = "Ahhh! What kind of spooky bad-magic did I just build?!",
            BURNT = "The spooky-table is just crispy ash now.",
        },
        RESEARCHLAB4 =
        {
            GENERIC = "Mr. Scientist gives his toys the silliest names!",
            BURNT = "The fire-tantrum ruined the silly-named toy.",
        },
        RESURRECTIONSTATUE =
        {
            GENERIC = "That wooden statue looks exactly like Mr. Scientist!",
            BURNT = "Mr. Scientist got extra crispy.",
        },
        RESURRECTIONSTONE = "A magic piggy-rock! It brings friends back from the forever-nap.",
        ROBIN =
        {
            GENERIC = "A pretty little red flappy-bird!",
            HELD = "It feels so soft and warm in my paws.",
        },
        ROBIN_WINTER =
        {
            GENERIC = "A fluffy white snow-bird!",
            HELD = "Such a soft little winter-friend.",
        },
        ROBOT_PUPPET = "Oh no, Mr. Robot is trapped in that spooky chair!", --single player
        ROCK_LIGHT =
        {
            GENERIC = "A hot, crusty puddle of fire-mud.",--removed
            OUT = "The fire-mud went to sleep.",--removed
            LOW = "The fiery glow is getting super tired.",--removed
            NORMAL = "Warm and cozy like a tummy-hug.",--removed
        },
        CAVEIN_BOULDER =
        {
            GENERIC = "I bet I'm strong enough to roll this giant rock!",
            RAISED = "It's stuck up there like a stubborn star.",
        },
        ROCK = "Too heavy to fit in my pocket!",
        PETRIFIED_TREE = "The tree got scared and turned into stone!",
        ROCK_PETRIFIED_TREE = "The tree got scared and turned into stone!",
        ROCK_PETRIFIED_TREE_OLD = "The tree got scared and turned into stone!",
        ROCK_ICE =
        {
            GENERIC = "A freezing popsic-rock! Brrr!",
            MELTED = "The popsic-rock melted into a sad little puddle.",
        },
        ROCK_ICE_MELTED = "The popsic-rock melted into a sad little puddle.",
        ICE = "Cold and slippery popsic-cubes!",
        ROCKS = "Heavy little throwing-toys. We can build stuff with these!",
        ROOK = "A giant stompy castle-monster! Rawr!",
        ROPE = "Scratchy grass strings tied together.",
        ROTTENEGG = "Pee-yew! The baby bird egg went bad and stinks!",
        ROYAL_JELLY = "Glowing sweet-goo from the boss buzzy-bug!",
        JELLYBEAN = "Bouncy little sweet-snacks! Yay!",
        SADDLE_BASIC = "A cozy seat for riding the fuzzy monsters!",
        SADDLE_RACE = "A zoomy-seat! We're going to go super fast!",
        SADDLE_WAR = "A spiky, tough seat for battling bullies!",
        SADDLEHORN = "This stick pops the seat right off the monster!",
        SALTLICK = "A giant block of salty-dust for the fuzzy monsters to lick!",
        BRUSH = "A scratchy comb to make the fuzzy monsters purr.",
        SANITYROCK =
        {
            ACTIVE = "Whoa... the giant rock is glowing with spooky brain-magic!",
            INACTIVE = "The spooky rock sunk into the dirt.",
        },
        SAPLING =
        {
            BURNING = "The baby stick-tree is crying fire!",
            WITHERED = "The baby stick is too hot and thirsty.",
            GENERIC = "A baby stick trying to grow up!",
            PICKED = "I snapped off its stick. Sorry, little plant!",
            DISEASED = "The baby stick is feeling yucky.", --removed
            DISEASING = "The baby stick looks wobbly and sick.", --removed
        },
        SCARECROW =
        {
            GENERIC = "A funny fake-man to scare the honk-birds away!",
            BURNING = "The fake-man is throwing a giant fire-tantrum!",
            BURNT = "Just a crispy stick now.",
        },
        SCULPTINGTABLE=
        {
            EMPTY = "A big heavy table for carving toys out of rocks!",
            BLOCK = "A giant rock waiting to be a pretty toy.",
            SCULPTURE = "Look what I made! I'm a star-artist!",
            BURNT = "The carving table got all burnt up.",
        },
        SCULPTURE_KNIGHTHEAD = "A broken stone pony head! Where's the body?",
        SCULPTURE_KNIGHTBODY =
        {
            COVERED = "A bumpy rock covered in mystery.",
            UNCOVERED = "It's a broken stone pony-toy.",
            FINISHED = "I fixed the pony-toy with star-glue!",
            READY = "Ahhh! The stone pony is wiggling!",
        },
        SCULPTURE_BISHOPHEAD = "A funny pointy stone head.",
        SCULPTURE_BISHOPBODY =
        {
            COVERED = "A mystery rock covered in spooky dust.",
            UNCOVERED = "A tall stone man, but he's missing his head!",
            FINISHED = "All patched up and looking fancy.",
            READY = "Yikes! The stone man is waking up!",
        },
        SCULPTURE_ROOKNOSE = "A giant stone rhino-nose!",
        SCULPTURE_ROOKBODY =
        {
            COVERED = "A giant heavy rock waiting to be cleaned.",
            UNCOVERED = "A giant castle-monster with a broken face.",
            FINISHED = "I put all the heavy pieces back together!",
            READY = "Oh no... the giant stone monster is alive!",
        },
        GARGOYLE_HOUND = "Stop staring at me, spooky stone-doggie!",
        GARGOYLE_WEREPIG = "The giant stone piggy looks like it could wake up any second!",
        SEEDS = "Tiny little magic specks! I wonder what they grow into.",
        SEEDS_COOKED = "Crispy little seed-snacks! They won't grow anymore.",
        SEWING_KIT = "Ouch! The little needle poked my star-paws!",
        SEWING_TAPE = "Sticky tape to fix my torn toys!",
        SHOVEL = "A giant digging-spoon for making dirt holes!",
        SILK = "Soft white string... wait, did this come from a many-legs? Gross!",
        SKELETON = "Spooky bones! I hope they aren't from a friend...",
        SCORCHED_SKELETON = "Crispy spooky bones! Ahhh!",
        SKELETON_NOTPLAYER = "Those bones belong to a weird-looking monster.",
        SKULLCHEST = "A spooky bone-box! Is it going to bite me if I open it?", --removed
        SMALLBIRD =
        {
            GENERIC = "What a cute little fuzz-ball!",
            HUNGRY = "The little fuzz-ball is doing a hungry peep!",
            STARVING = "Oh no! The baby bird is throwing a tummy-tantrum!",
            SLEEPING = "Shh, the fuzz-ball is taking a star-nap.",
        },
        SMALLMEAT = "A tiny bite-sized meat-snack.",
        SMALLMEAT_DRIED = "A chewy little meat-snack!",
        SPAT = "Ew! What is that grumpy crusty-monster?",
        SPEAR = "A super pointy stick for poking the bullies!",
        SPEAR_WATHGRITHR = "The brave knight's golden poke-stick!",
        WATHGRITHRHAT = "A shiny knight helmet with flappy wings!",
        SPIDER =
        {
            DEAD = "Yuck! Squished many-legs!",
            GENERIC = "Ahhh! Keep away, you creepy many-legs!",
            SLEEPING = "The creepy bug is asleep. Let's sneak past it!",
        },
        SPIDERDEN = "A giant sticky booger-house! So gross!",
        SPIDEREGGSACK = "A bag full of baby many-legs! I don't want to hold it!",
        SPIDERGLAND = "Stinky bug-juice that magically fixes boo-boos.",
        SPIDERHAT = "I am NOT putting a bug-head on my sparkly mane! Never!",
        SPIDERQUEEN = "Ahhhhh! It's the giant boss of all the many-legs! Run away!",
        SPIDER_WARRIOR =
        {
            DEAD = "No more jumping for you, meanie-bug!",
            GENERIC = "That many-legs is yellow and looks super grumpy!",
            SLEEPING = "Don't wake the grumpy jumping-bug!",
        },
        SPOILED_FOOD = "Pee-yew! The snack got all fuzzy and yucky.",
        STAGEHAND =
        {
            AWAKE = "Ahhh! A creepy shadow-hand is crawling around!",
            HIDING = "Why is that little table wiggling?",
        },
        STATUE_MARBLE =
        {
            GENERIC = "A big fancy stone toy.",
            TYPE1 = "Oh no, the stone-man lost his head!",
            TYPE2 = "A fancy stone lady holding a bowl.",
            TYPE3 = "A stone bowl for the birds to take a splash-bath!", --bird bath type statue
        },
        STATUEHARP = "Somebody broke the stone-man's head off! How mean.",
        STATUEMAXWELL = "It's a statue of Mr. Fancy-Suit!",
        STEELWOOL = "Scratchy metal fuzz. It tickles my paws!",
        STINGER = "A pointy bug-sword! Ouchie!",
        STRAWHAT = "A floppy sun-hat to protect my peepers from the bright sky!",
        STUFFEDEGGPLANT = "A squishy purple vegetable filled with yummy treats!",
        SWEATERVEST = "A fancy sweater with a little pattern! I look so smart.",
        REFLECTIVEVEST = "This shiny jacket bounces the hot sun right off me!",
        HAWAIIANSHIRT = "A silly flower-shirt for a beach party!",
        TAFFY = "Super sticky sweet-snack! My teeth are glued together!",
        TALLBIRD = "Whoa! That giant honk-bird has legs like stilts!",
        TALLBIRDEGG = "A giant blue egg! Is there a baby honk-bird inside?",
        TALLBIRDEGG_COOKED = "The biggest, yummiest cooked egg ever!",
        TALLBIRDEGG_CRACKED =
        {
            COLD = "Brrr! The baby bird is freezing inside there!",
            GENERIC = "Look! The egg is wiggling! It's waking up!",
            HOT = "Oh no, the egg is getting way too hot! It's sweating!",
            LONG = "Taking a forever-nap before it hatches.",
            SHORT = "Almost time to say hello to the baby bird!",
        },
        TALLBIRDNEST =
        {
            GENERIC = "A giant stick-bed for the giant blue egg!",
            PICKED = "Just an empty stick-bed now.",
        },
        TEENBIRD =
        {
            GENERIC = "The fuzz-ball is growing up into a grumpy honk-bird!",
            HUNGRY = "It's squawking for a tummy-snack!",
            STARVING = "Ahhh! The hungry teenager is trying to bite me!",
            SLEEPING = "The grumpy teenager is finally asleep.",
        },
        TELEPORTATO_BASE =
        {
            ACTIVE = "The magic space-door is ready to zoom us away!", --single player
            GENERIC = "A big broken beep-boop circle.", --single player
            LOCKED = "It needs more puzzle pieces to work!", --single player
            PARTIAL = "We're almost done building the magic space-door!", --single player
        },
        TELEPORTATO_BOX = "A little metal box full of space-magic.", --single player
        TELEPORTATO_CRANK = "A clicky-crank for the space-door.", --single player
        TELEPORTATO_POTATO = "A metal dirt-apple? Science is so silly.", --single player
        TELEPORTATO_RING = "A giant metal donut for the space-door.", --single player
        TELESTAFF = "A super magic stick that makes you zoom across the world!",
        TENT =
        {
            GENERIC = "A cozy little sleep-fort to hide from the Big Dark.",
            BURNT = "My sleep-fort got all burnt up!",
        },
        SIESTAHUT =
        {
            GENERIC = "A shady little house for a cool afternoon star-nap.",
            BURNT = "No more cool naps in the burnt-up house.",
        },
        TENTACLE = "Ahhh! A spiky purple swamp-whip! Don't let it smack you!",
        TENTACLESPIKE = "A slimy, spiky piece of the swamp-whip. Gross but pointy!",
        TENTACLESPOTS = "Ew ew ew! Slimy spotted purple skin!",
        TENTACLE_PILLAR = "A giant, giant swamp-whip! It's so big!",
        TENTACLE_PILLAR_HOLE = "A spooky muddy hole. Did the giant whip go down there?",
        TENTACLE_PILLAR_ARM = "Tiny little baby swamp-whips!",
        TENTACLE_GARDEN = "More of those sneaky purple whips hiding in the mud!",
        TOPHAT = "A super tall fancy-hat! Do I look like a magician?",
        TORCH = "A little fire-stick to keep the scary Big Dark away!",
        TRANSISTOR = "A buzzy little beep-boop piece for science toys!",
        TRAP = "A little grass-jail for catching bouncy-bunnies.",
        TRAP_TEETH = "A snappy-trap! Don't step on it with your bare star-paws!",
        TRAP_TEETH_MAXWELL = "Mr. Fancy-Suit left a snappy-trap to hurt my toes!", --single player
        TREASURECHEST =
        {
            GENERIC = "A wooden toy-box for all my stuff!",
            BURNT = "The toy-box had a supernova! All my stuff is gone!",
            UPGRADED_STACKSIZE = "Wow! Magic puzzle-pieces made the toy-box hold so much more!",
        },
		TREASURECHEST_TRAP = "A surprise toy-box! ...Wait, is it a trick?",
        CHESTUPGRADE_STACKSIZE = "Magic puzzle pieces to make the toy-box even bigger!", -- Describes the kit upgrade item.
        COLLAPSEDCHEST = "The toy-box got squished flat like a pancake!",
        SACRED_CHEST =
        {
            GENERIC = "A spooky toy-box... it's whispering secrets to me.",
            LOCKED = "The spooky box is thinking if it wants my toys or not.",
        },
        TREECLUMP = "A giant wall of trees! We can't go that way.", --removed

        TRINKET_1 = "A bunch of melty glass balls. Did someone play with fire?", --Melted Marbles
        TRINKET_2 = "A silly toot-toot toy!", --Fake Kazoo
        TRINKET_3 = "This string-puzzle is too hard. It won't untie!", --Gord's Knot
        TRINKET_4 = "A little grumpy garden-man toy.", --Gnome
        TRINKET_5 = "A tiny zoom-ship! I wish I could fly in it.", --Toy Rocketship
        TRINKET_6 = "Broken sparkly-wires. No more zaps for them.", --Frazzled Wires
        TRINKET_7 = "A bouncy-ball game! I'm super good at this.", --Ball and Cup
        TRINKET_8 = "A squishy rubber plug.", --Rubber Bung
        TRINKET_9 = "A bunch of little clicky circles.", --Mismatched Buttons
        TRINKET_10 = "Fake teeth! So silly and kind of gross.", --Dentures
        TRINKET_11 = "A little beep-boop toy that tells me funny stories.", --Lying Robot
        TRINKET_12 = "Ew! A crispy purple swamp-whip.", --Dessicated Tentacle
        TRINKET_13 = "A little garden-lady toy.", --Gnomette
        TRINKET_14 = "A broken tummy-cup. It leaks all the juice out!", --Leaky Teacup
        TRINKET_15 = "Mr. Fancy-Suit left his little stone toys everywhere.", --Pawn
        TRINKET_16 = "Mr. Fancy-Suit left his little stone toys everywhere.", --Pawn
        TRINKET_17 = "A spoon and a fork squished together! So weird.", --Bent Spork
        TRINKET_18 = "A little wooden horse-toy on wheels!", --Trojan Horse
        TRINKET_19 = "This spinny-top is wobbly and falls over too fast.", --Unbalanced Top
        TRINKET_20 = "The brave knight keeps poking me with this scratchy-stick!", --Backscratcher
        TRINKET_21 = "A metal mixy-toy, but it's all bent.", --Egg Beater
        TRINKET_22 = "A messy ball of fuzzy string.", --Frayed Yarn
        TRINKET_23 = "A funny spoon for putting on foot-gloves.", --Shoehorn
        TRINKET_24 = "A lucky kitty-jar! It's so cute.", --Lucky Cat Jar
        TRINKET_25 = "A little tree that smells like old dust.", --Air Unfreshener
        TRINKET_26 = "A cup made out of a dirt-apple! So silly.", --Potato Cup
        TRINKET_27 = "A twisty wire for hanging clothes up.", --Coat Hanger
        TRINKET_28 = "A heavy stone castle-toy.", --Rook
        TRINKET_29 = "A heavy stone castle-toy.", --Rook
        TRINKET_30 = "A little stone pony-toy. Neigh!", --Knight
        TRINKET_31 = "A little stone pony-toy. Neigh!", --Knight
        TRINKET_32 = "A super shiny gem-ball! I want to play catch with it.", --Cubic Zirconia Ball
        TRINKET_33 = "Ahhh! A many-legs ring! Keep it away!", --Spider Ring
        TRINKET_34 = "A spooky monkey hand... I don't want to hold it.", --Monkey Paw
        TRINKET_35 = "A tiny empty bottle for magic potions.", --Empty Elixir
        TRINKET_36 = "Fake bitey-teeth for playing monster! Rawr!", --Faux fangs
        TRINKET_37 = "A broken pointy-stick. Looks like it fought a monster.", --Broken Stake
        TRINKET_38 = "Double-glasses for seeing things super far away!", -- Binoculars Griftlands trinket
        TRINKET_39 = "Someone lost their paw-glove.", -- Lone Glove Griftlands trinket
        TRINKET_40 = "A giant crunchy snail shell!", -- Snail Scale Griftlands trinket
        TRINKET_41 = "A hot metal can... what's inside?", -- Goop Canister Hot Lava trinket
        TRINKET_42 = "A wiggly snake-toy!", -- Toy Cobra Hot Lava trinket
        TRINKET_43 = "A little snappy-monster toy.", -- Crocodile Toy Hot Lava trinket
        TRINKET_44 = "A broken glass-ball with a little plant inside.", -- Broken Terrarium ONI trinket
        TRINKET_45 = "A weird beep-boop box with an antenna.", -- Odd Radio ONI trinket
        TRINKET_46 = "A noisy wind-blower toy!", -- Hairdryer ONI trinket

        -- The numbers align with the trinket numbers above.
        LOST_TOY_1  = "I found a lost toy! Can I keep it?",
        LOST_TOY_2  = "I found a lost toy! Can I keep it?",
        LOST_TOY_7  = "I found a lost toy! Can I keep it?",
        LOST_TOY_10 = "I found a lost toy! Can I keep it?",
        LOST_TOY_11 = "I found a lost toy! Can I keep it?",
        LOST_TOY_14 = "I found a lost toy! Can I keep it?",
        LOST_TOY_18 = "I found a lost toy! Can I keep it?",
        LOST_TOY_19 = "I found a lost toy! Can I keep it?",
        LOST_TOY_42 = "I found a lost toy! Can I keep it?",
        LOST_TOY_43 = "I found a lost toy! Can I keep it?",

        HALLOWEENCANDY_1 = "Yummy red apple covered in sweet sugar!",
        HALLOWEENCANDY_2 = "A spooky candy-eye! It's staring at me.",
        HALLOWEENCANDY_3 = "Sweet yellow corn-candy!",
        HALLOWEENCANDY_4 = "Squishy sugar-worms! They wiggle in my tummy.",
        HALLOWEENCANDY_5 = "Sticky sweet-snack! My teeth are going to fall out.",
        HALLOWEENCANDY_6 = "Ew! Sugar-spider! I don't want to eat that.",
        HALLOWEENCANDY_7 = "A little box of sweet dried grapes.",
        HALLOWEENCANDY_8 = "A ghostly sweet-stick! Boo!",
        HALLOWEENCANDY_9 = "Super sticky orange candy! My jaw is stuck!",
        HALLOWEENCANDY_10 = "A swirl of sweet colors on a stick!",
        HALLOWEENCANDY_11 = "Chocolate bugs! Way better than real bugs.",
        HALLOWEENCANDY_12 = "Did this bug-candy just wiggle?", --ONI meal lice candy
        HALLOWEENCANDY_13 = "Ouch! This rock-candy is way too hard.", --Griftlands themed candy
        HALLOWEENCANDY_14 = "Fire-candy! It burns my tongue! Ahhh!", --Hot Lava pepper candy
        CANDYBAG = "A super special bag just for holding all my sweet-snacks!",

        HALLOWEEN_ORNAMENT_1 = "A spooky little ghost-toy for the tree!",
        HALLOWEEN_ORNAMENT_2 = "A flappy-bat decoration!",
        HALLOWEEN_ORNAMENT_3 = "A little wooden spooky-face.",
        HALLOWEEN_ORNAMENT_4 = "A squishy purple tentacle-toy.",
        HALLOWEEN_ORNAMENT_5 = "A spooky many-legs decoration. Yuck.",
        HALLOWEEN_ORNAMENT_6 = "A little black flappy-bird ornament.",

        HALLOWEENPOTION_DRINKS_WEAK = "A tiny sip of magic juice.",
        HALLOWEENPOTION_DRINKS_POTENT = "A super strong magic potion!",
        HALLOWEENPOTION_BRAVERY = "Brave-juice! It makes me feel like a giant lion!",
        HALLOWEENPOTION_MOON = "Night-spark potion! It's so pretty and glowing.",
        HALLOWEENPOTION_FIRE_FX = "Fiery orange magic juice!",
        MADSCIENCE_LAB = "A spooky table for making crazy magic potions!",
        LIVINGTREE_ROOT = "Ahhh! The tree has grabby-hands under the dirt!",
        LIVINGTREE_SAPLING = "A baby scary-tree trying to grow up.",

        DRAGONHEADHAT = "A giant dragon head! Rawr! Who wants to be the tail?",
        DRAGONBODYHAT = "The middle part of the dragon costume. Kind of boring.",
        DRAGONTAILHAT = "A long swishy dragon tail!",
        PERDSHRINE =
        {
            GENERIC = "A big statue of the greedy turkey!",
            EMPTY = "The turkey statue wants a yummy red snack.",
            BURNT = "The turkey statue is all crispy now.",
        },
        REDLANTERN = "A pretty red paper-star!",
        LUCKY_GOLDNUGGET = "A super shiny lucky coin!",
        FIRECRACKERS = "Noisy boom-strings! Pop pop pop!",
        PERDFAN = "A giant fan made of turkey feathers! Swoosh!",
        REDPOUCH = "A little red present! Is there a toy inside?",
        WARGSHRINE =
        {
            GENERIC = "A statue of a bad-doggie! But this one is nice.",
            EMPTY = "The doggie statue wants a warm torch to hold.",
            BURNING = "The doggie statue is glowing and happy!", --for willow to override
            BURNT = "The doggie statue had a fire-tantrum.",
        },
        CLAYWARG =
        {
            GENERIC = "A giant heavy dirt-doggie!",
            STATUE = "The dirt-doggie is taking a nap as a statue.",
        },
        CLAYHOUND =
        {
            GENERIC = "A bouncy dirt-puppy! Run away!",
            STATUE = "The dirt-puppy is pretending to be a rock.",
        },
        HOUNDWHISTLE = "A loud toot-toot to call the bad-doggies!",
        CHESSPIECE_CLAYHOUND = "A heavy stone puppy-toy.",
        CHESSPIECE_CLAYWARG = "A giant stone doggie-toy.",

        PIGSHRINE =
        {
            GENERIC = "A fancy statue for the piggies!",
            EMPTY = "The piggy statue is hungry for a yummy snack.",
            BURNT = "The piggy statue got all burnt up.",
        },
        PIG_TOKEN = "A shiny piggy-coin!",
        PIG_COIN = "A super special lucky piggy-coin!",
        YOTP_FOOD1 = "A giant, yummy feast just for me! Yay!",
        YOTP_FOOD2 = "A messy, squishy snack for a hungry cub.",
        YOTP_FOOD3 = "Just a little snack. Not very fancy.",

        PIGELITE1 = "Why are you staring at me, Mr. Piggy?", --BLUE
        PIGELITE2 = "That piggy loves shiny gold coins!", --RED
        PIGELITE3 = "Don't throw mud at me, piggy!", --WHITE
        PIGELITE4 = "Go bother someone else, you grumpy pig!", --GREEN

        PIGELITEFIGHTER1 = "A tough piggy guard!", --BLUE
        PIGELITEFIGHTER2 = "This piggy guard is super greedy!", --RED
        PIGELITEFIGHTER3 = "A muddy piggy guard!", --WHITE
        PIGELITEFIGHTER4 = "A grumpy piggy guard looking for a fight!", --GREEN

        CARRAT_GHOSTRACER = "A spooky ghost-snack is running around! Ahhh!",

        YOTC_CARRAT_RACE_START = "The starting line! Ready, set, go!",
        YOTC_CARRAT_RACE_CHECKPOINT = "A little flag for the race!",
        YOTC_CARRAT_RACE_FINISH =
        {
            GENERIC = "The finish line! The race is over!",
            BURNT = "The finish line caught on fire!",
            I_WON = "Yay! I'm the winner! I'm the fastest star-cub!",
            SOMEONE_ELSE_WON = "Aww... good job, {winner}. Next time I'll win!",
        },

        YOTC_CARRAT_RACE_START_ITEM = "Toys to build a starting line.",
        YOTC_CARRAT_RACE_CHECKPOINT_ITEM = "Toys to make a race-flag.",
        YOTC_CARRAT_RACE_FINISH_ITEM = "Toys to build the finish line.",

        YOTC_SEEDPACKET = "A bag full of secret seeds!",
        YOTC_SEEDPACKET_RARE = "A bag of super rare magic seeds!",

        MINIBOATLANTERN = "A little floating light-bug for the boat!",

        YOTC_CARRATSHRINE =
        {
            GENERIC = "A big statue of the bouncy pointy-snack!",
            EMPTY = "The pointy-snack statue is hungry for a yummy orange bite.",
            BURNT = "The pointy-snack statue got roasted.",
        },

        YOTC_CARRAT_GYM_DIRECTION =
        {
            GENERIC = "A little toy to teach the pointy-snack which way to run!",
            RAT = "Look at the little snack go! Zoom!",
            BURNT = "The learning-toy got all crispy.",
        },
        YOTC_CARRAT_GYM_SPEED =
        {
            GENERIC = "A spinny wheel to make the pointy-snack super fast!",
            RAT = "Run faster, little snack! Faster!",
            BURNT = "The spinny wheel had a supernova.",
        },
        YOTC_CARRAT_GYM_REACTION =
        {
            GENERIC = "A pop-up game for the pointy-snack to play!",
            RAT = "Boop! The snack is so fast at booping the game!",
            BURNT = "The pop-up game broke.",
        },
        YOTC_CARRAT_GYM_STAMINA =
        {
            GENERIC = "A heavy pulling-toy to make the pointy-snack super strong!",
            RAT = "Pull, little snack, pull! You can do it!",
            BURNT = "The pulling-toy got ruined.",
        },

        YOTC_CARRAT_GYM_DIRECTION_ITEM = "Pieces for a pointy-snack learning toy.",
        YOTC_CARRAT_GYM_SPEED_ITEM = "Pieces for a spinny running toy.",
        YOTC_CARRAT_GYM_STAMINA_ITEM = "Pieces for a heavy pulling toy.",
        YOTC_CARRAT_GYM_REACTION_ITEM = "Pieces for a pop-up reaction toy.",

        YOTC_CARRAT_SCALE_ITEM = "A tiny weighing-toy for the pointy-snacks.",
        YOTC_CARRAT_SCALE =
        {
            GENERIC = "Let's see how heavy my bouncy pointy-snack is!",
            CARRAT = "It's a very heavy pointy-snack!",
            CARRAT_GOOD = "This pointy-snack is super heavy and ready to race!",
            BURNT = "The weighing-toy is all burnt up.",
        },

        YOTB_BEEFALOSHRINE =
        {
            GENERIC = "A big statue of a fuzzy monster!",
            EMPTY = "The fuzzy monster statue needs a wooly rug.",
            BURNT = "The monster statue had a fire-tantrum.",
        },

        BEEFALO_GROOMER =
        {
            GENERIC = "A fancy dressing-room for the fuzzy monsters!",
            OCCUPIED = "Look at the fuzzy monster getting all dressed up! So pretty!",
            BURNT = "The dressing-room caught on fire. No more dress-up games.",
        },
        BEEFALO_GROOMER_ITEM = "Toys to build a monster dressing-room.",

        YOTR_RABBITSHRINE =
        {
            GENERIC = "A giant statue of a bouncy-bunny!",
            EMPTY = "The bunny statue wants a yummy orange snack.",
            BURNT = "The bunny statue got all crispy and black.",
        },

        NIGHTCAPHAT = "A long sleepy-hat for my star-naps! Zzz...",

        YOTR_FOOD1 = "Yummy sweet orange snacks! Hop hop hop!",
        YOTR_FOOD2 = "A pretty blue sweet-snack!",
        YOTR_FOOD3 = "A wiggly, jiggly sweet-treat!",
        YOTR_FOOD4 = "Bunny-hop right into my tummy-nebula!",

        YOTR_TOKEN = "A shiny bunny-coin for playing games!",

        COZY_BUNNYMAN = "A big fuzzy bunny wearing a warm sweater! So cute!",

        HANDPILLOW_BEEFALOWOOL = "A soft hand-pillow... but it smells like a wet fuzzy monster.",
        HANDPILLOW_KELP = "A squishy, soggy green hand-pillow.",
        HANDPILLOW_PETALS = "A soft flower-pillow! It smells so pretty.",
        HANDPILLOW_STEELWOOL = "A scratchy metal pillow! Ouchie for my paws!",

        BODYPILLOW_BEEFALOWOOL = "A giant body-pillow... but it smells super stinky.",
        BODYPILLOW_KELP = "A giant soggy green pillow.",
        BODYPILLOW_PETALS = "A giant pretty flower-pillow! Perfect for a star-nap.",
        BODYPILLOW_STEELWOOL = "A giant scratchy metal pillow! No thank you!",

		BISHOP_CHARGE_HIT = "Ouchie! Spark-zap!",
		TRUNKVEST_SUMMER = "A breezy hug-suit made from a snorty-nose!",
		TRUNKVEST_WINTER = "A super-warm, fuzzy snorty-nose jacket!",
		TRUNK_COOKED = "A warm, chewy snorty-snack.",
		TRUNK_SUMMER = "A red snorty-nose!",
		TRUNK_WINTER = "A fuzzy, warm snorty-nose!",
		TUMBLEWEED = "A roll-y grass ball! Let's chase it!",
		TURKEYDINNER = "A giant yummy gobble-feast! My favorite!",
		TWIGS = "Little wooden zoomy-sticks for making toys.",
		UMBRELLA = "A piggy-roof to keep my mane dry from the sky-juice!",
		GRASS_UMBRELLA = "A tickle-grass umbrella! It's a bit leaky.",
		UNIMPLEMENTED = "It's a broken toy! Be careful!",
		WAFFLES = "Sweet grid-cakes! They need more star-syrup!",
		WALL_HAY =
		{
			GENERIC = "A scratchy tickle-grass wall.",
			BURNT = "A crispy black wall.",
		},
		WALL_HAY_ITEM = "A roll of tickle-grass wall.",
		WALL_STONE = "A strong rock-wall to keep the bullies out!",
		WALL_STONE_ITEM = "Heavy building blocks!",
		WALL_RUINS = "A spooky old magic-wall.",
		WALL_RUINS_ITEM = "A piece of spooky ancient rock.",
		WALL_WOOD =
		{
			GENERIC = "A pointy wood-wall!",
			BURNT = "A crispy burned wall.",
		},
		WALL_WOOD_ITEM = "Pointy pickets for building!",
		WALL_MOONROCK = "A sparkly night-cheese wall!",
		WALL_MOONROCK_ITEM = "Pieces of the night-friend for building!",
		WALL_DREADSTONE = "I feel so... safe?",
		WALL_DREADSTONE_ITEM = "What could go wrong?",
        WALL_SCRAP = "It's made of garbage.",
        WALL_SCRAP_ITEM = "It's like a bundle wrap, of scrap.",
		FENCE = "A little stick-fence.",
        FENCE_ITEM = "Toys to build a stick-fence.",
        FENCE_GATE = "A little stick-door! Creak!",
        FENCE_GATE_ITEM = "Toys to make a stick-door.",
		WALRUS = "A grumpy snorty-walrus! He has a pointy stick!",
		WALRUSHAT = "A fuzzy walrus hat! It smells like fish.",
		WALRUS_CAMP =
		{
			EMPTY = "An empty snow-house.",
			GENERIC = "A cozy little snow-house! Is there a fire inside?",
		},
		WALRUS_TUSK = "A giant walrus tooth! For making zoomy-sticks!",
		WARDROBE =
		{
			GENERIC = "A magic dress-up box! What should I wear?",
            BURNING = "The dress-up box is having a supernova!",
			BURNT = "A crispy black box.",
		},
		WARG = "A super-giant bad-doggie! RAWR! I'm not scared!",
        WARGLET = "It's going to be one of those days...",

		WASPHIVE = "A house for the angry yellow spiky-flies!",
		WATERBALLOON = "A splash-bomb! Incoming!",
		WATERMELON = "A giant splashy green-snack!",
		WATERMELON_COOKED = "Warm and splashy!",
		WATERMELONHAT = "A splash-snack hat! It's making my mane sticky.",
		WAXWELLJOURNAL =
		{
			GENERIC = "Spooky.",
			NEEDSFUEL = "only_used_by_waxwell",
		},
		WETGOOP = "Yucky soggy food-mistake. Bleh!",
        WHIP = "A snappy-string toy! Crack!",
		WINTERHAT = "A fuzzy poof-hat for chilly days!",
		WINTEROMETER =
		{
			GENERIC = "It tells me if my paws will freeze!",
			BURNT = "The cold-teller went supernova.",
		},

        WINTER_TREE =
        {
            BURNT = "Aww, the happy-tree got crispy.",
            BURNING = "The happy-tree is having a fire-tantrum!",
            CANDECORATE = "A sparkly happy-tree for the Feast!",
            YOUNG = "A baby happy-tree!",
        },
		WINTER_TREESTAND =
		{
			GENERIC = "A little pot for a happy-tree!",
            BURNT = "The little pot is all burnt.",
		},
        WINTER_ORNAMENT = "A pretty shiny star-toy for the tree!",
        WINTER_ORNAMENTLIGHT = "A tiny little glowing star-bulb!",
        WINTER_ORNAMENTBOSS = "A super-fancy boss-toy for the tree!",
		WINTER_ORNAMENTFORGE = "A hot lava-toy for the tree!",
		WINTER_ORNAMENTGORGE = "A tummy-snack toy for the tree!",
        WINTER_ORNAMENTPEARL = "Really fine work considering she has claws.",

        WINTER_FOOD1 = "A little cookie-friend! I'm gonna eat his head!", --gingerbread cookie
        WINTER_FOOD2 = "A yummy star-shaped sugar-snack!", --sugar cookie
        WINTER_FOOD3 = "A peppermint hook-snack!", --candy cane
        WINTER_FOOD4 = "A brick made of squishy fruit-candies.", --fruitcake
        WINTER_FOOD5 = "A chocolate log-snack! So sweet!", --yule log cake
        WINTER_FOOD6 = "A squishy plum-snack bowl!", --plum pudding
        WINTER_FOOD7 = "Warm apple-juice! It warms up my tummy-nebula.", --apple cider
        WINTER_FOOD8 = "Hot chocolate-water with little cloud-snacks on top!", --hot cocoa
        WINTER_FOOD9 = "Thick creamy star-drink!", --eggnog

		WINTERSFEASTOVEN =
        {
            GENERIC = "A happy hot-box for cooking winter party snacks!",
            COOKING = "The hot-box is making warm magic happen!",
            ALMOST_DONE_COOKING = "I can smell the yummy snacks! Hurry up!",
            DISH_READY = "Ding ding! Tummy-snack time!",
        },
        BERRYSAUCE = "Sweet and squishy red splash-sauce!",
        BIBINGKA = "It's just like eating a warm, squishy cloud!",
        CABBAGEROLLS = "Little meat-snacks hiding in green sleeping bags!",
        FESTIVEFISH = "A super fancy cooked splashy-friend!",
        GRAVY = "Warm brown puddle-sauce for dipping!",
        LATKES = "Crispy dirt-apple pancakes! Yum!",
        LUTEFISK = "A wobbly, smelly fish-snack. I don't want to touch it.",
        MULLEDDRINK = "Warm red fruit-water! It makes my nose tickle.",
        PANETTONE = "A giant fluffy cake with sweet star-berries inside!",
        PAVLOVA = "A big crunchy cloud covered in colorful fruit!",
        PICKLEDHERRING = "Sour little fish-bites! They make my face scrunch up.",
        POLISHCOOKIE = "Star-shaped sweet-snacks! Can I eat the whole plate?",
        PUMPKINPIE = "A whole wobble-gourd pie just for my tummy-nebula!",
        ROASTTURKEY = "A giant cooked honk-bird! I call the biggest leg!",
        STUFFING = "A big pile of messy, yummy mush!",
        SWEETPOTATO = "A dirt-apple that tastes like candy! Science is the best!",
        TAMALES = "Warm corn-pockets! They're wearing little leaf-jackets.",
        TOURTIERE = "A super heavy meat-pie! It's going to make me so full.",

        TABLE_WINTERS_FEAST =
        {
            GENERIC = "A giant party-table waiting for all my friends!",
            HAS_FOOD = "So many yummy snacks! Let's eat! Yay!",
            WRONG_TYPE = "That snack doesn't belong at the winter party!",
            BURNT = "Oh no! The party-table had a fire-tantrum.",
        },

        GINGERBREADWARG = "Ahhh! A giant bad-doggie made entirely of cookies!",
        GINGERBREADHOUSE = "A house made of sweet-snacks! Can I take a bite out of the roof?",
        GINGERBREADPIG = "A running cookie-piggy! Come back here, snack! Zoom!",
        CRUMBS = "Little cookie-pieces! I'm going to follow the trail.",
        WINTERSFEASTFUEL = "Happy little party-sparks!",

        KLAUS = "A giant two-headed goat bully! Ahhh!",
        KLAUS_SACK = "A giant magic toy-bag! I want to look inside!",
		KLAUSSACKKEY = "A sparkly bone-key for the toy-bag!",
		WORMHOLE =
		{
			GENERIC = "A squishy space-donut mouth!",
			OPEN = "Wheee! A trip through the ground-mouth!",
		},
		WORMHOLE_LIMITED = "The space-donut looks very sick and pale.",
		ACCOMPLISHMENT_SHRINE = "A shiny machine that says I'm the best star-cub!", --single player
		LIVINGTREE = "The tree has eyes! Peek-a-boo!",
		ICESTAFF = "A freezing popsic-stick! Brrr!",
		REVIVER = "A magic star-heart to fix my floaty cloud-friends!",
		SHADOWHEART = "A creepy shadow-heart. It gives me the shivers!",
        ATRIUM_RUBBLE =
        {
			LINE_1 = "Spooky doodles about scared, hungry people.",
			LINE_2 = "This doodle-rock is too scratchy to read.",
			LINE_3 = "The Big Dark is eating the doodle-city!",
			LINE_4 = "The doodle-people are turning into shadow-monsters!",
			LINE_5 = "A doodle of a giant, glowing star-city.",
		},
        ATRIUM_STATUE = "A spooky shadow-statue.",
        ATRIUM_LIGHT =
        {
			ON = "A spooky lamp that makes bad-magic.",
			OFF = "The spooky lamp is taking a nap.",
		},
        ATRIUM_GATE =
        {
			ON = "The giant spooky door is awake!",
			OFF = "The spooky door is missing some bad-magic.",
			CHARGING = "It's eating all the magic to open!",
			DESTABILIZING = "The door is getting all wobbly! Ahhh!",
			COOLDOWN = "The door is tired from so much magic.",
        },
        ATRIUM_KEY = "A spooky key made of shadows.",
		LIFEINJECTOR = "A magic star-juice shot! Instant health!",
		SKELETON_PLAYER =
		{
			MALE = "Oh no, %s had a bad accident and turned into bones!",
			FEMALE = "Oh no, %s had a bad accident and turned into bones!",
			ROBOT = "Oh no, %s had a bad accident and turned into bones!",
			DEFAULT = "Oh no, %s had a bad accident and turned into bones!",
		},
		HUMANMEAT = "Yuck! Friend-meat! That's super against the rules!",
		HUMANMEAT_COOKED = "Warm friend-meat... still super gross!",
		HUMANMEAT_DRIED = "Chewy friend-meat. I'm still not eating that!",
		ROCK_MOON = "A chunk of the night-friend!",
		MOONROCKNUGGET = "A little piece of the night-friend!",
		MOONROCKCRATER = "A night-rock with a missing puzzle-piece.",
		MOONROCKSEED = "There's a little spark inside this night-rock!",

        REDMOONEYE = "A glowing red night-peeper!",
        PURPLEMOONEYE = "A purple night-peeper! Stop staring at me!",
        GREENMOONEYE = "A green night-peeper!",
        ORANGEMOONEYE = "An orange night-peeper!",
        YELLOWMOONEYE = "A bright yellow night-peeper!",
        BLUEMOONEYE = "A blue night-peeper!",

        --Arena Event
        LAVAARENA_BOARLORD = "The giant piggy-boss! He looks super mean!",
        BOARRIOR = "A super-big lava-piggy!",
        BOARON = "I can pounce on this lava-piggy!",
        PEGHOOK = "A grumpy spit-bird!",
        TRAILS = "He's a very stompy stone-bully.",
        TURTILLUS = "A spiky lava-turtle! Don't touch!",
        SNAPPER = "A snappy turtle-friend... wait, not friend! Bully!",
		RHINODRILL = "A pointy nose-driller monster!",
		BEETLETAUR = "A giant stinky bug-bully!",

        LAVAARENA_PORTAL =
        {
            ON = "Time to zoom-zoom out of here!",
            GENERIC = "A big glowing space-door!",
        },
        LAVAARENA_KEYHOLE = "It needs a special shiny key.",
		LAVAARENA_KEYHOLE_FULL = "The key fits! Yay!",
        LAVAARENA_BATTLESTANDARD = "Smash the bully-flag! Go go go!",
        LAVAARENA_SPAWNER = "This is where the meanies come from!",

        HEALINGSTAFF = "A magic stick that gives star-hugs!",
        FIREBALLSTAFF = "A stick that drops mini-suns from the sky!",
        HAMMER_MJOLNIR = "A super heavy bonk-toy!",
        SPEAR_GUNGNIR = "A zoomy-poke stick!",
        BLOWDART_LAVA = "A spicy-fire zoomy-dart!",
        BLOWDART_LAVA2 = "A super strong wind-dart!",
        LAVAARENA_LUCY = "Mr. Wood-Chopper's flying red toy!",
        WEBBER_SPIDER_MINION = "The multi-legs are playing on our team today!",
        BOOK_FOSSIL = "A magic story that traps the meanies!",
		LAVAARENA_BERNIE = "The giant teddy-friend is helping us fight!",
		SPEAR_LANCE = "A very long poke-stick!",
		BOOK_ELEMENTAL = "I can't read these star-doodles.",
		LAVAARENA_ELEMENTAL = "A friendly rock-monster!",

   		LAVAARENA_ARMORLIGHT = "A light hug-suit for running fast!",
		LAVAARENA_ARMORLIGHTSPEED = "A super zoom-zoom suit!",
		LAVAARENA_ARMORMEDIUM = "A strong hug-suit for tough star-cubs.",
		LAVAARENA_ARMORMEDIUMDAMAGER = "This suit makes my pounces extra strong!",
		LAVAARENA_ARMORMEDIUMRECHARGER = "This suit gives me extra star-energy!",
		LAVAARENA_ARMORHEAVY = "A super-heavy shell to keep me safe!",
		LAVAARENA_ARMOREXTRAHEAVY = "A giant stone shell! I'm a turtle-lion!",

		LAVAARENA_FEATHERCROWNHAT = "A flappy-bird hat! Tweet tweet!",
        LAVAARENA_HEALINGFLOWERHAT = "A pretty flower-crown for giving star-hugs.",
        LAVAARENA_LIGHTDAMAGERHAT = "A spiky hat for stronger pounces!",
        LAVAARENA_STRONGDAMAGERHAT = "A super-spiky hat! Don't headbutt me!",
        LAVAARENA_TIARAFLOWERPETALSHAT = "A magic tiara for the bestest healer!",
        LAVAARENA_EYECIRCLETHAT = "A hat with a smart peeper on it.",
        LAVAARENA_RECHARGERHAT = "A crystal crown to make my magic go zoom!",
        LAVAARENA_HEALINGGARLANDHAT = "A magic leaf-crown to fix my boo-boos.",
        LAVAARENA_CROWNDAMAGERHAT = "A big heavy crown for a boss-pouncer!",

		LAVAARENA_ARMOR_HP = "This suit gives me lots of extra star-life!",

		LAVAARENA_FIREBOMB = "A spicy explodey-toy!",
		LAVAARENA_HEAVYBLADE = "A giant, sharp chopper-sword!",

        --Quagmire
        QUAGMIRE_ALTAR =
        {
            GENERIC = "We need to make yummy tummy-snacks for the big mouth!",
            FULL = "The big mouth is munching on our snacks!",
        },
        QUAGMIRE_ALTAR_STATUE1 = "An old grumpy stone-man.",
        QUAGMIRE_PARK_FOUNTAIN = "A pretty splash-pool with no splashes.",

        QUAGMIRE_HOE = "A scratchy-tool for the dirt-bed.",

        QUAGMIRE_TURNIP = "A raw snappy-snack.",
        QUAGMIRE_TURNIP_COOKED = "A warm, soft snappy-snack!",
        QUAGMIRE_TURNIP_SEEDS = "Magic seeds for snappy-snacks.",

        QUAGMIRE_GARLIC = "A spicy-smell snack! Stinky!",
        QUAGMIRE_GARLIC_COOKED = "A warm, toasty stinky-snack.",
        QUAGMIRE_GARLIC_SEEDS = "Seeds for stinky-snacks.",

        QUAGMIRE_ONION = "The snack that makes my eyes cry!",
        QUAGMIRE_ONION_COOKED = "A sweet, non-crying snack now.",
        QUAGMIRE_ONION_SEEDS = "Seeds for cry-snacks.",

        QUAGMIRE_POTATO = "A bumpy dirt-apple!",
        QUAGMIRE_POTATO_COOKED = "A warm, mushy dirt-apple!",
        QUAGMIRE_POTATO_SEEDS = "Seeds for bumpy dirt-apples.",

        QUAGMIRE_TOMATO = "A red, squishy splat-snack!",
        QUAGMIRE_TOMATO_COOKED = "A hot, mushy splat-snack.",
        QUAGMIRE_TOMATO_SEEDS = "Seeds for red splat-snacks.",

        QUAGMIRE_FLOUR = "Soft, white star-dust for baking!",
        QUAGMIRE_WHEAT = "Scratchy golden tickle-grass.",
        QUAGMIRE_WHEAT_SEEDS = "Seeds for golden tickle-grass.",
        --NOTE: raw/cooked carrot uses regular carrot strings
        QUAGMIRE_CARROT_SEEDS = "Seeds for orange pointy-snacks.",

        QUAGMIRE_ROTTEN_CROP = "Ew! The big mouth won't want this yucky mess.",

        QUAGMIRE_SALMON = "A fresh pink water-friend!",
        QUAGMIRE_SALMON_COOKED = "A yummy hot fishy-snack!",
        QUAGMIRE_CRABMEAT = "A snappy-crab snack!",
        QUAGMIRE_CRABMEAT_COOKED = "A warm, yummy snappy-crab!",
        QUAGMIRE_SUGARWOODTREE =
        {
            GENERIC = "A tree full of sweet star-syrup!",
            STUMP = "Aww, the syrup-tree is gone.",
            TAPPED_EMPTY = "Come on, sweet syrup, come out!",
            TAPPED_READY = "A bucket full of golden star-sweetness!",
            TAPPED_BUGS = "Shoo! The spiky-flies are eating the syrup!",
            WOUNDED = "The tree is feeling yucky.",
        },
        QUAGMIRE_SPOTSPICE_SHRUB =
        {
            GENERIC = "A bush that looks like baby wiggle-whips.",
            PICKED = "No more spicy-leaves here.",
        },
        QUAGMIRE_SPOTSPICE_SPRIG = "A spicy little leaf.",
        QUAGMIRE_SPOTSPICE_GROUND = "Spicy star-dust for my snacks!",
        QUAGMIRE_SAPBUCKET = "A little metal cup for catching syrup.",
        QUAGMIRE_SAP = "Sweet, sticky star-juice!",
        QUAGMIRE_SALT_RACK =
        {
            READY = "Yay! The salty star-dust is ready!",
            GENERIC = "Waiting for the salty puddles to dry.",
        },

        QUAGMIRE_POND_SALT = "A salty little water-puddle.",
        QUAGMIRE_SALT_RACK_ITEM = "A drying-toy for the salty puddle.",

        QUAGMIRE_SAFE =
        {
            GENERIC = "A super-strong metal toy-box.",
            LOCKED = "I need the magic key-toy to open it!",
        },

        QUAGMIRE_KEY = "A shiny key for a locked door!",
        QUAGMIRE_KEY_PARK = "A special key for the park gate!",
        QUAGMIRE_PORTAL_KEY = "A magic space-key!",


        QUAGMIRE_MUSHROOMSTUMP =
        {
            GENERIC = "A little log where the mushy-friends sit.",
            PICKED = "The mushy-friends went away.",
        },
        QUAGMIRE_MUSHROOMS = "Yummy mushy-snacks!",
        QUAGMIRE_MEALINGSTONE = "A rock-toy for squishing things into star-dust.",
        QUAGMIRE_PEBBLECRAB = "A little snappy-crab hiding in a rock!",


        QUAGMIRE_RUBBLE_CARRIAGE = "A broken rolling-toy.",
        QUAGMIRE_RUBBLE_CLOCK = "A broken giant tick-tock machine.",
        QUAGMIRE_RUBBLE_CATHEDRAL = "A broken giant house.",
        QUAGMIRE_RUBBLE_PUBDOOR = "A broken wooden door.",
        QUAGMIRE_RUBBLE_ROOF = "A broken roof. The sky-juice will get in!",
        QUAGMIRE_RUBBLE_CLOCKTOWER = "The big tick-tock tower fell down.",
        QUAGMIRE_RUBBLE_BIKE = "A broken zoomy-wheel toy.",
        QUAGMIRE_RUBBLE_HOUSE =
        {
            "Where did everybody go? It's all empty.",
            "A giant meanie stomped on all the houses!",
            "Did the big altar-mouth throw a tantrum?",
        },
        QUAGMIRE_RUBBLE_CHIMNEY = "A broken smoke-tube.",
        QUAGMIRE_RUBBLE_CHIMNEY2 = "Another broken smoke-tube.",
        QUAGMIRE_MERMHOUSE = "A little mud-house for the fishy-frogs.",
        QUAGMIRE_SWAMPIG_HOUSE = "A muddy piggy-house.",
        QUAGMIRE_SWAMPIG_HOUSE_RUBBLE = "The muddy piggy-house fell down.",
        QUAGMIRE_SWAMPIGELDER =
        {
            GENERIC = "A very old, grumpy Mr. Piggy.",
            SLEEPING = "Shh, the old piggy is dreaming of mud.",
        },
        QUAGMIRE_SWAMPIG = "A super hairy, muddy Mr. Piggy!",

        QUAGMIRE_PORTAL = "A broken space-door.",
        QUAGMIRE_SALTROCK = "A giant block of salty rock!",
        QUAGMIRE_SALT = "Salty star-dust for making food yummy!",
        --food--
        QUAGMIRE_FOOD_BURNT = "Oopsie! I made a crispy black hole instead of a snack.",
        QUAGMIRE_FOOD =
        {
            GENERIC = "A yummy snack for the big altar mouth!",
            MISMATCH = "The big mouth doesn't want to eat this one.",
            MATCH = "Yay! The big mouth loves this star-snack!",
            MATCH_BUT_SNACK = "It's just a teeny-tiny snack for the big mouth.",
        },

        QUAGMIRE_FERN = "A healthy green leaf-snack.",
        QUAGMIRE_FOLIAGE_COOKED = "Warm green leaf-snacks.",
        QUAGMIRE_COIN1 = "A little shiny star-coin!",
        QUAGMIRE_COIN2 = "Some shiny star-coins!",
        QUAGMIRE_COIN3 = "A big pile of shiny star-coins! Yay!",
        QUAGMIRE_COIN4 = "Super special magic coins!",
        QUAGMIRE_GOATMILK = "Buzzy, tingly goat-juice!",
        QUAGMIRE_SYRUP = "Sweet golden star-syrup!",
        QUAGMIRE_SAP_SPOILED = "Ew, the sweet juice went bad.",
        QUAGMIRE_SEEDPACKET = "A little paper bag full of magic seeds!",

        QUAGMIRE_POT = "A big tummy-bowl for cooking!",
        QUAGMIRE_POT_SMALL = "A little tummy-bowl for making snacks!",
        QUAGMIRE_POT_SYRUP = "I need to put sweet syrup in the bowl!",
        QUAGMIRE_POT_HANGER = "A metal swing-set for the cooking bowls.",
        QUAGMIRE_POT_HANGER_ITEM = "A toy for making the bowl swing-set.",
        QUAGMIRE_GRILL = "A hot iron-bed for cooking snacks!",
        QUAGMIRE_GRILL_ITEM = "A toy to make the hot iron-bed.",
        QUAGMIRE_GRILL_SMALL = "A little hot iron-bed for tiny snacks.",
        QUAGMIRE_GRILL_SMALL_ITEM = "A toy to make the little hot bed.",
        QUAGMIRE_OVEN = "A hot stone-house for baking treats!",
        QUAGMIRE_OVEN_ITEM = "A toy to make the hot stone-house.",
        QUAGMIRE_CASSEROLEDISH = "A fancy bowl for mixing yummy things.",
        QUAGMIRE_CASSEROLEDISH_SMALL = "A tiny fancy bowl.",
        QUAGMIRE_PLATE_SILVER = "A super shiny silver plate!",
        QUAGMIRE_BOWL_SILVER = "A super shiny silver bowl!",
        QUAGMIRE_CRATE = "A wooden box full of cooking toys.",

        QUAGMIRE_MERM_CART1 = "A rolling-box full of funny science toys!", --sammy's wagon
        QUAGMIRE_MERM_CART2 = "A rolling-box full of seeds and things!", --pipton's cart
        QUAGMIRE_PARK_ANGEL = "A stone lady with flappy-wings!",
        QUAGMIRE_PARK_ANGEL2 = "She looks like she wants to fly away.",
        QUAGMIRE_PARK_URN = "A fancy stone flower-pot.",
        QUAGMIRE_PARK_OBELISK = "A giant pointy stone-stick.",
        QUAGMIRE_PARK_GATE =
        {
            GENERIC = "I used the magic key to open the door!",
            LOCKED = "The door is being a meanie and won't open.",
        },
        QUAGMIRE_PARKSPIKE = "A pointy metal stick. Don't touch!",
        QUAGMIRE_CRABTRAP = "A cage for catching snappy-crabs.",
        QUAGMIRE_TRADER_MERM = "A friendly fishy-frog! Will you trade toys?",
        QUAGMIRE_TRADER_MERM2 = "Another friendly fishy-frog!",

        QUAGMIRE_GOATMUM = "A nice goat-lady! Will she make me a star-snack?",
        QUAGMIRE_GOATKID = "A baby bouncy-goat! Let's play!",
        QUAGMIRE_PIGEON =
        {
            DEAD = "The little flappy-bird went to sleep forever.",
            GENERIC = "A little grey flappy-friend!",
            SLEEPING = "Shh, the flappy-friend is napping.",
        },
        QUAGMIRE_LAMP_POST = "A tall star-lamp to light the way!",

        QUAGMIRE_BEEFALO = "A fuzzy monster! But he looks a bit pale.",
        QUAGMIRE_SLAUGHTERTOOL = "Scary sharp tools for making meat-snacks.",

        QUAGMIRE_SAPLING = "A baby stick-tree. I took all its sticks.",
        QUAGMIRE_BERRYBUSH = "No more splashy-snacks here.",

        QUAGMIRE_ALTAR_STATUE2 = "A grumpy rock-man staring at me.",
        QUAGMIRE_ALTAR_QUEEN = "A giant fancy stone-lady.",
        QUAGMIRE_ALTAR_BOLLARD = "A little stone bump.",
        QUAGMIRE_ALTAR_IVY = "Leafy-friends giving the stone a hug.",

        QUAGMIRE_LAMP_SHORT = "A little star-lamp! So cute!",

        --v2 Winona
        WINONA_CATAPULT =
        {
            GENERIC = "The Fix-it Lady made a giant rock-throwing toy!",
            OFF = "It's out of spark-juice.",
            BURNING = "The throwing-toy is on fire!",
            BURNT = "It's all crispy and black now.",
            SLEEP = "The throwing-toy is taking a little nap until the bullies come back.",
        },
        WINONA_SPOTLIGHT =
        {
            GENERIC = "A giant stage-light for my sparkle-show!",
            OFF = "The light went to sleep.",
            BURNING = "Ah! Fiery light!",
            BURNT = "No more sparkle-shows for now.",
            SLEEP = "It's resting its bright eye.",
        },
        WINONA_BATTERY_LOW =
        {
            GENERIC = "A hummy-box full of sparks!",
            LOWPOWER = "The sparks are getting very tired.",
            OFF = "It needs a new magic rock to wake up.",
            BURNING = "The spark-box is doing a supernova!",
            BURNT = "Just a burnt box now.",
        },
        WINONA_BATTERY_HIGH =
        {
            GENERIC = "Wow! A shiny magic gem-box!",
            LOWPOWER = "The magic is running out.",
            OFF = "It needs more shiny gems to hum.",
            BURNING = "Oh no! Fire!",
            BURNT = "All black and sad.",
            OVERLOADED = "Ahhh! The magic gem-box has too many sparks and wants to pop!",
        },
        --v3 Winona
        WINONA_REMOTE =
        {
            GENERIC = "A clicky-button toy! What does it do if I push it?",
            OFF = "The clicky-toy is out of spark-juice.",
            CHARGING = "It's drinking up the sky-sparks!",
            CHARGED = "All full of sparks and ready to click!",
        },
        WINONA_TELEBRELLA =
        {
            GENERIC = "A magic umbrella that makes you go whoosh!",
            MISSINGSKILL = "only_used_by_winona",
            OFF = "The whoosh-umbrella needs more spark-juice.",
            CHARGING = "The umbrella is catching all the sparks!",
            CHARGED = "Ready for a magic whoosh-trip!",
        },
        WINONA_TELEPORT_PAD_ITEM =
        {
            GENERIC = "A puzzle piece for making a magic whoosh-door!",
            MISSINGSKILL = "only_used_by_winona",
            OFF = "The whoosh-door is asleep without any sparks.",
            BURNING = "Ahhh! The whoosh-door is throwing a fire-tantrum!",
            BURNT = "No more magic trips on this crispy pad.",
        },
        WINONA_STORAGE_ROBOT =
        {
            GENERIC = "A walking toy-box! Will you carry my snacks?",
            OFF = "The box-bot is taking a nap.",
            SLEEP = "Shh, the box-bot is dreaming of gears.",
            CHARGING = "It's eating sparks so it can carry more toys!",
            CHARGED = "The box-bot is full of energy and ready to zoom!",
        },
        INSPECTACLESBOX = "only_used_by_winona",
        INSPECTACLESBOX2 = "only_used_by_winona",
        INSPECTACLESHAT = 
        {
            GENERIC = "Funny looking spy-glasses! Do they see secret magic?",
            MISSINGSKILL = "only_used_by_winona",
        },
        ROSEGLASSESHAT =
        {
            GENERIC = "Pretty flower-glasses! The scary lady left them behind.",
            MISSINGSKILL = "only_used_by_winona",
        },
        CHARLIERESIDUE = "only_used_by_winona",
        CHARLIEROSE = "only_used_by_winona",
        WINONA_MACHINEPARTS_1 = "only_used_by_winona",
        WINONA_MACHINEPARTS_2 = "only_used_by_winona",
        WINONA_RECIPESCANNER = "only_used_by_winona",
        WINONA_HOLOTELEPAD = "only_used_by_winona",
        WINONA_HOLOTELEBRELLA = "only_used_by_winona",

        --Wormwood
        COMPOSTWRAP = "Leafy-friend wanted to share, but it smelled like stinky-dirt!",
        ARMOR_BRAMBLE = "A tickly, scratchy hug-suit!",
        TRAP_BRAMBLE = "A very meanie surprise for barefoot paws!",

        BOATFRAGMENT03 = "Just some broken water-toys.",
        BOATFRAGMENT04 = "Just some broken water-toys.",
        BOATFRAGMENT05 = "Just some broken water-toys.",
        BOAT_LEAK = "Oh no! The boat is drinking the ocean!",
        MAST = "A giant wind-catcher toy!",
        SEASTACK = "A giant water-rock!",
        FISHINGNET = "A swooshy net for catching water-snacks.", --unimplemented
        ANTCHOVIES = "Ew! Salty little bug-fishes!", --unimplemented
        STEERINGWHEEL = "A spinny-wheel for driving the boat!",
        ANCHOR = "A heavy sinky-toy to keep us from floating away.",
        BOATPATCH = "A sticky band-aid for the boat!",
        DRIFTWOOD_TREE =
        {
            BURNING = "The salty tree is having a fire-tantrum!",
            BURNT = "Crispy salty sticks.",
            CHOPPED = "TIMBER! Down goes the white tree!",
            GENERIC = "A white, salty tree-friend.",
        },

        DRIFTWOOD_LOG = "A floaty salty wood-block.",

        MOON_TREE =
        {
            BURNING = "The night-cheese tree is burning!",
            BURNT = "A crispy night-stick.",
            CHOPPED = "Yay, night-blocks!",
            GENERIC = "A tree from the big night-cheese!",
        },
        MOON_TREE_BLOSSOM = "A pretty little night-petal!",

        MOONBUTTERFLY =
        {
            GENERIC = "A pretty flappy-night-bug! Wheee!",
            HELD = "You're safe in my paws, little bug!",
        },
        MOONBUTTERFLYWINGS = "Soft little night-petals!",
        MOONBUTTERFLY_SAPLING = "A bug turned into a baby tree! Star-magic is so silly!",
        ROCK_AVOCADO_FRUIT = "A super hard rock-snack! Ouchie for my teeth.",
        ROCK_AVOCADO_FRUIT_RIPE = "I need to smash the rock off first!",
        ROCK_AVOCADO_FRUIT_RIPE_COOKED = "Warm and mushy rock-snack!",
        ROCK_AVOCADO_FRUIT_SPROUT = "A baby rock-snack popping up.",
        ROCK_AVOCADO_BUSH =
        {
            BARREN = "The night-bush is sleepy and needs a snack.",
            WITHERED = "The sun-friend is making it too thirsty.",
            GENERIC = "A bush from the night friend! It grows rocks!",
            PICKED = "I picked all the rock-snacks.",
            DISEASED = "The night-bush is feeling yucky.", --unimplemented
            DISEASING = "The night-bush looks wobbly and sick.", --unimplemented
            BURNING = "Ahhh! Moon-bush supernova!",
        },
        DEAD_SEA_BONES = "Scary salty bones! Don't look!",
        HOTSPRING =
        {
            GENERIC = "A warm, bubbly bath for a star-cub!",
            BOMBED = "Bubbly fizz-magic!",
            GLASS = "The bath water turned into shiny glass!",
            EMPTY = "Aww, the bath water ran away.",
        },
        MOONGLASS = "Shiny, sharp night-glass. Don't touch the pointy bits!",
        MOONGLASS_CHARGED = "The night-glass is buzzing with sky-sparks! I better play with it quick!",
        MOONGLASS_ROCK = "A shiny mirror-rock! Who's that handsome lion?",
        BATHBOMB = "A fizzy-pop ball for the water!",
        TRAP_STARFISH =
        {
            GENERIC = "A pretty little star-friend!",
            CLOSED = "Yikes! The star-friend has a snappy mouth!",
        },
        DUG_TRAP_STARFISH = "A sleepy snappy-star.",
        SPIDER_MOON =
        {
            GENERIC = "Ahhh! A creepy night multi-legs!",
            SLEEPING = "Shh, the creepy bug is taking a night-nap.",
            DEAD = "The spooky bug went to sleep forever.",
        },
        MOONSPIDERDEN = "A giant, sparkly booger-house! Still gross.",
        FRUITDRAGON =
        {
            GENERIC = "A little spicy-friend! But not ready to play.",
            RIPE = "It's bright red and ready to hop!",
            SLEEPING = "Shhh, it's dreaming of fire.",
        },
        PUFFIN =
        {
            GENERIC = "A funny little honk-bird!",
            HELD = "A fluffy friend for my pocket!",
            SLEEPING = "Zzz... sweet dreams, honk-bird.",
        },

        MOONGLASSAXE = "A super-sharp, shiny night-chopper!",
        GLASSCUTTER = "This nightsword makes me feel brave!",

        ICEBERG =
        {
            GENERIC = "A giant floating popsic-rock! Brrr!", --unimplemented
            MELTED = "The popsic-rock turned into water.", --unimplemented
        },
        ICEBERG_MELTED = "The popsic-rock turned into water.", --unimplemented

        MINIFLARE = "A little shooting star to call my friends!",
        MEGAFLARE = "This giant shooting star will tell everyone exactly where I am!",

        MOON_FISSURE =
        {
            GENERIC = "A glowing crack in the ground! Is the earth smiling?",
            NOLIGHT = "The glowing smile went away.",
        },
        MOON_ALTAR =
        {
            MOON_ALTAR_WIP = "It's waiting for more magic puzzle pieces.",
            GENERIC = "A strange, humming night-table.",
        },

        MOON_ALTAR_IDOL = "A heavy night-toy for the table.",
        MOON_ALTAR_GLASS = "A shiny night-glass toy for the table.",
        MOON_ALTAR_SEED = "A little night-spark toy for the table.",

        MOON_ALTAR_ROCK_IDOL = "There's a secret toy trapped in the rock!",
        MOON_ALTAR_ROCK_GLASS = "There's a secret toy trapped in the rock!",
        MOON_ALTAR_ROCK_SEED = "There's a secret toy trapped in the rock!",

        MOON_ALTAR_CROWN = "A shiny puzzle-piece from the splashy-water! Where does it go?",
        MOON_ALTAR_COSMIC = "This magic night-toy looks like it wants to connect to something.",

        MOON_ALTAR_ASTRAL = "It's a giant puzzle piece for the humming night-table!",
        MOON_ALTAR_ICON = "I know exactly where to put this puzzle piece!",
        MOON_ALTAR_WARD = "This rock-toy is lonely without its other puzzle friends.",

        SEAFARING_PROTOTYPER =
        {
            GENERIC = "A magic think-machine for water toys!",
            BURNT = "Oh no, the water think-machine got burnt.",
        },
        BOAT_ITEM = "A big wooden water-toy in my pocket!",
        BOAT_GRASS_ITEM = "A squishy boat made of grass! Will it really float?",
        STEERINGWHEEL_ITEM = "A spinny wheel toy waiting to be built.",
        ANCHOR_ITEM = "A heavy sinky-toy to hold the boat.",
        MAST_ITEM = "A giant stick-toy to catch the wind.",
        MUTATEDHOUND =
        {
            DEAD = "Phew, the night-bully is gone.",
            GENERIC = "Ahhh! A spooky night-doggie!",
            SLEEPING = "Shh, the bad doggie is sleeping. Don't wake it!",
        },

        MUTATED_PENGUIN =
        {
            DEAD = "No more spooky bird.",
            GENERIC = "Ahhh! A spooky night slidey-bird!",
            SLEEPING = "Sleepy slidey-bird.",
        },
        CARRAT =
        {
            DEAD = "Aww, the snack stopped moving.",
            GENERIC = "A bouncy pointy-snack! So silly!",
            HELD = "It's wiggling in my paws!",
            SLEEPING = "The snack is taking a nap.",
        },

        BULLKELP_PLANT =
        {
            GENERIC = "A soggy green water-whip.",
            PICKED = "I pulled the water-whip!",
        },
        BULLKELP_ROOT = "A sleepy water-whip for planting.",
        KELPHAT = "A soggy, floppy hat. It drips on my nose. Bleh.",
        KELP = "Soggy green water-strings.",
        KELP_COOKED = "Warm green water-strings.",
        KELP_DRIED = "Salty, chewy string-snack.",

        GESTALT = "A floaty night-ghost! Does it want to play tag?",
        GESTALT_GUARD = "Those big night-ghosts look super grumpy... I shouldn't poke them.",

        COOKIECUTTER = "A little snappy-bug! Don't eat my boat!",
        COOKIECUTTERSHELL = "An empty snappy-bug shell.",
        COOKIECUTTERHAT = "A funny shell-hat! Snap snap!",
        SALTSTACK =
        {
            GENERIC = "A giant pillar of salty rock!",
            MINED_OUT = "I smashed it all up into little salty-bites!",
            GROWING = "It's growing like a salty tree.",
        },
        SALTROCK = "A salty white space-rock!",
        SALTBOX = "A magic box to keep my snacks salty and fresh!",

        TACKLESTATION = "A special table to make new toys for my fishing string!",
        TACKLESKETCH = "A doodle-paper showing me how to make cool fishing toys!",

        MALBATROSS = "A giant, grumpy water-bird! Incoming!",
        MALBATROSS_FEATHER = "A giant water-bird feather!",
        MALBATROSS_BEAK = "A big fishy-smelling beak. Pee-yew!",
        MAST_MALBATROSS_ITEM = "A stick with a water-bird feather on it.",
        MAST_MALBATROSS = "A big sail made of bird-feathers! Swoosh!",
        MALBATROSS_FEATHERED_WEAVE = "A soft blanket of feathers!",

        GNARWAIL =
        {
            GENERIC = "A giant splash-puppy with a pointy head-sword!",
            BROKENHORN = "Oh no, the splash-puppy lost its pointy sword!",
            FOLLOWER = "The pointy splash-puppy wants to play follow-the-leader!",
            BROKENHORN_FOLLOWER = "You're still a good puppy, even without your pointy sword!",
        },
        GNARWAIL_HORN = "A giant pointy sword from the splash-puppy!",

        WALKINGPLANK = "Splash! I want to jump off the diving board!",
        WALKINGPLANK_GRASS = "Is this safe? The grass looks super slippery for my paws.",
        OAR = "Row, row, row the boat with the splashy-stick!",
        OAR_DRIFTWOOD = "A salty old splashy-stick from the beach!",

        OCEANFISHINGROD = "A super long string-toy to play tag with the fishies!",
        OCEANFISHINGBOBBER_NONE = "It needs a little floaty-ball so I know when the fishy bites!",
        OCEANFISHINGBOBBER_BALL = "A bouncy round floaty-toy for the fishing string.",
        OCEANFISHINGBOBBER_OVAL = "This floaty-toy looks like a little egg!",
        OCEANFISHINGBOBBER_CROW = "Black bird-feathers to trick the splashy-friends.",
        OCEANFISHINGBOBBER_ROBIN = "Pretty red feathers! The fish will definitely see this.",
        OCEANFISHINGBOBBER_ROBIN_WINTER = "Fluffy winter feathers to keep my fishing string frosty.",
        OCEANFISHINGBOBBER_CANARY = "Bright yellow feathers! It looks like a little sun-ray.",
        OCEANFISHINGBOBBER_GOOSE = "Honk-feathers! Will it make the fish honk too?",
        OCEANFISHINGBOBBER_MALBATROSS = "Giant scary-bird feathers for catching giant fishies!",

        OCEANFISHINGLURE_SPINNER_RED = "A shiny red fake bug! Come here, fishies!",
        OCEANFISHINGLURE_SPINNER_GREEN = "Look at this shiny green spinny-toy!",
        OCEANFISHINGLURE_SPINNER_BLUE = "A blue fake bug to match the splashy-water.",
        OCEANFISHINGLURE_SPOON_RED = "A little red spoon-toy to trick the tiny fish.",
        OCEANFISHINGLURE_SPOON_GREEN = "The fishies will think this green spoon is a yummy leaf!",
        OCEANFISHINGLURE_SPOON_BLUE = "A sparkly blue spoon-toy!",
        OCEANFISHINGLURE_HERMIT_RAIN = "A heavy rain-lure! It drops like a rock.",
        OCEANFISHINGLURE_HERMIT_SNOW = "Frosty snow-lure! The fish won't even see it coming.",
        OCEANFISHINGLURE_HERMIT_DROWSY = "This heavy lure makes me feel a little sleepy just looking at it.",
        OCEANFISHINGLURE_HERMIT_HEAVY = "Super heavy star-metal! Splash!",

        OCEANFISH_SMALL_1 = "A tiny little splash-friend! You're so small!",
        OCEANFISH_SMALL_2 = "What a funny looking little swimmer.",
        OCEANFISH_SMALL_3 = "Are you lost, little fishy? Let's put you in my pocket.",
        OCEANFISH_SMALL_4 = "You're too tiny to fill my tummy-nebula!",
        OCEANFISH_SMALL_5 = "A little spiky fish! Ouch, don't poke me!",
        OCEANFISH_SMALL_6 = "Wow! You look exactly like a falling leaf!",
        OCEANFISH_SMALL_7 = "A beautiful flower-fish! I love your petals.",
        OCEANFISH_SMALL_8 = "This little swimmer feels super hot to the touch!",
        OCEANFISH_SMALL_9 = "Stop spitting splashy-water at me, you silly fish!",

        OCEANFISH_MEDIUM_1 = "A big muddy fish! You need a bath.",
        OCEANFISH_MEDIUM_2 = "Look at this fancy patterned swimmer!",
        OCEANFISH_MEDIUM_3 = "Roar! This fish has a mane just like mine! Are we cousins?",
        OCEANFISH_MEDIUM_4 = "A pretty fish with giant flappy fins!",
        OCEANFISH_MEDIUM_5 = "Is this a fish or a swimming corn-cob? So weird!",
        OCEANFISH_MEDIUM_6 = "A beautiful orange and white splash-friend!",
        OCEANFISH_MEDIUM_7 = "Another pretty patterned swimmer!",
        OCEANFISH_MEDIUM_8 = "Brrr! This big fish is made of freezing ice!",
        OCEANFISH_MEDIUM_9 = "Pee-yew! This one smells like an old boot.",

        PONDFISH = "A fresh little swimmer from the pond!",
        PONDEEL = "A wiggly water-snake! Stop squirming!",

        FISHMEAT = "A big piece of chewy water-snack.",
        FISHMEAT_COOKED = "Yummy grilled water-snack! So warm.",
        FISHMEAT_SMALL = "A tiny bite-sized piece of fishy.",
        FISHMEAT_SMALL_COOKED = "A warm, tiny fishy-bite.",
        SPOILED_FISH = "Yuck! The water-snack went bad and smells terrible!",

        FISH_BOX = "A whole box packed with smelly swimmers!",
        POCKET_SCALE = "A tiny weighing-toy I can keep in my pocket!",

        TACKLECONTAINER = "A special box just for my fishing toys!",
        SUPERTACKLECONTAINER = "A super fancy shell-box for all my shiny lures!",

        TROPHYSCALE_FISH =
        {
            GENERIC = "Let's see how heavy my splashy-friends are!",
            HAS_ITEM = "Weight: {weight}\nCaught by: {owner}\nLook at this heavy swimmer!",
            HAS_ITEM_HEAVY = "Weight: {weight}\nCaught by: {owner}\nWow! I caught a giant sea-monster!",
            BURNING = "Uh oh, the measuring-toy is throwing a fire-tantrum!",
            BURNT = "All burnt up! Now I can't measure my fishies.",
            OWNER = "I caught this one all by myself!\nWeight: {weight}\nCaught by: {owner}",
            OWNER_HEAVY = "Weight: {weight}\nCaught by: {owner}\nThe heaviest splashy-friend in the whole ocean!",
        },

        OCEANFISHABLEFLOTSAM = "Just a bunch of soggy grass-strings.",

        CALIFORNIAROLL = "Little rice wheels! Can I just eat them with my paws?",
        SEAFOODGUMBO = "A giant bowl of messy splashy-soup! Yum!",
        SURFNTURF = "Meat and fishy-meat together! The best of both worlds!",

        WOBSTER_SHELLER = "A snappy sea-bug! Watch out for those claws!",
        WOBSTER_DEN = "The snappy bugs live inside this bubbly rock.",
        WOBSTER_SHELLER_DEAD = "The snappy bug is taking a forever nap.",
        WOBSTER_SHELLER_DEAD_COOKED = "Wow, the fire turned the snappy bug bright red!",

        LOBSTERBISQUE = "Warm snappy-bug soup! It smells delicious.",
        LOBSTERDINNER = "A super fancy snappy-bug meal! Do I need a napkin?",

        WOBSTER_MOONGLASS = "A glowing night-spark snappy bug!",
        MOONGLASS_WOBSTER_DEN = "The night-spark bugs hide in this shiny glass rock.",

        TRIDENT = "A giant three-pointy stick! I'm the king of the splashy-water! Rawr!",

        WINCH =
        {
            GENERIC = "A big cranky-toy for pulling up heavy things!",
            RETRIEVING_ITEM = "Crank, crank, crank! Pulling up secrets from the deep!",
            HOLDING_ITEM = "Look what I fished out of the splashy-water!",
        },

        HERMITHOUSE = {
            GENERIC = "A sad, empty shell-house. Where is the lady?",
            BUILTUP = "We fixed the shell-lady's house! It looks so pretty now.",
        },

        SHELL_CLUSTER = "A pile of musical sea-rocks! I want to play with them.",
        --
        SINGINGSHELL_OCTAVE3 =
        {
            GENERIC = "This musical rock makes a deep, rumbly sound!",
        },
        SINGINGSHELL_OCTAVE4 =
        {
            GENERIC = "A happy, bouncy tune from a sea-rock!",
        },
        SINGINGSHELL_OCTAVE5 =
        {
            GENERIC = "This one sings super high like a little bird! Tweet!",
        },

        CHUM = "Stinky fish-mush! It brings all the swimmers to the boat.",

        SUNKENCHEST =
        {
            GENERIC = "A wet treasure box! What kind of toys are inside?",
            LOCKED = "The treasure box is being a meanie and won't open!",
        },

        HERMIT_BUNDLE = "The shell-lady gave me a present! I love opening presents!",
        HERMIT_BUNDLE_SHELLS = "A present full of musical sea-rocks! Yay!",

        RESKIN_TOOL = "A magic sweepy-broom! It changes how my toys look with a swoosh!",
        MOON_FISSURE_PLUGGED = "We shoved a rock in the glowing hole so it stops leaking magic!",


		----------------------- ROT STRINGS GO ABOVE HERE ------------------

		-- Walter
        WOBYBIG =
        {
            "Wow! The fuzzy-doggie ate a supernova and got humongous!",
            "Look at how big she got! Is there a galaxy in her tummy?",
        },
        WOBYSMALL =
        {
            "Who's a good little fuzzy-doggie? I want to pet you all day!",
            "Giving the puppy a star-hug always makes me feel happy!",
        },
        WALTERHAT = "A silly hat for pretending to be a forest-explorer!",
        SLINGSHOT =
        {
            GENERIC = "A zoomy-shooter! Pew pew!",
            NOT_MINE = "only_used_by_walter",
        },
        SLINGSHOTAMMO_ROCK = "Little zoomy-rocks for the shooter!",
        SLINGSHOTAMMO_MARBLE = "Heavy white zoomies! They pack a big punch!",
        SLINGSHOTAMMO_THULECITE = "Magic star-rocks for super-duper zooming!",
        SLINGSHOTAMMO_GOLD = "Shiny gold zoomies! It feels like throwing treasure!",
        SLINGSHOTAMMO_HONEY = "Sticky sweet zoomies! Splat!",
        SLINGSHOTAMMO_SLOW = "Freezing frosty zoomies. Brrr!",
        SLINGSHOTAMMO_FREEZE = "Ice-cube zoomies! Freeze, bullies!",
        SLINGSHOTAMMO_POOP = "Ew! Stinky-zoomies! I don't want to touch these.",
        SLINGSHOTAMMO_STINGER = "Ouchie pointy zoomies! Watch out!",
        SLINGSHOTAMMO_MOONGLASS = "Sharp night-glass zoomies! Careful, they're pointy!",
        SLINGSHOTAMMO_GELBLOB = "Squishy goop-zoomies! Splat!",
        SLINGSHOTAMMO_SCRAPFEATHER = "Flappy-zoomies made of junk!",
        SLINGSHOTAMMO_DREADSTONE = "Scary bad-magic zoomies.",
        SLINGSHOTAMMO_GUNPOWDER = "Boom-zoomies! They make a fiery splat!",
        SLINGSHOTAMMO_LUNARPLANTHUSK = "Scratchy leaf-zoomies!",
        SLINGSHOTAMMO_PUREBRILLIANCE = "Super bright star-zoomies! My absolute favorite!",
        SLINGSHOTAMMO_HORRORFUEL = "Yuck, bad-magic zoomies. They give me the shivers.",
        PORTABLETENT = "A cozy little sleep-fort to take a star-nap anywhere!",
        PORTABLETENT_ITEM = "Puzzle pieces to build a rolling sleep-fort.",

        -- Wigfrid
        BATTLESONG_DURABILITY = "Singing this song makes my star-suit feel super tough!",
        BATTLESONG_HEALTHGAIN = "A happy singing-spell to heal all my boo-boos!",
        BATTLESONG_SANITYGAIN = "The brave knight's song chases the scary shadows away!",
        BATTLESONG_SANITYAURA = "Singing together makes everyone feel brave and happy!",
        BATTLESONG_FIRERESISTANCE = "This cool song stops the hot fire from hurting!",
        BATTLESONG_INSTANT_TAUNT = "Hey, you big meanies! Listen to my loud song!",
        BATTLESONG_INSTANT_PANIC = "A super scary song to make the bullies run away! Boo!",

        -- Webber
        MUTATOR_WARRIOR = "Wow, Webber! That yellow mush looks... very interesting! You can have my share!",
        MUTATOR_DROPPER = "I think my tummy-nebula is too full for bug-snacks today, Webber. Maybe your friends want it?",
        MUTATOR_HIDER = "A rock-bug snack? That's so cool! But I think I'll stick to star-berries.",
        MUTATOR_SPITTER = "You're so brave for eating that, Webber! I'll just watch you enjoy it.",
        MUTATOR_MOON = "Night-spark mush! It glows so pretty. Your bug-friends will love it, Webber!",
        MUTATOR_HEALER = "Healing mush! You take such good care of your many-legs friends, Webber.",
        SPIDER_WHISTLE = "Toot toot! Are we calling your fuzzy friends over to play a game?",
        SPIDERDEN_BEDAZZLER = "Wow! You made your bug-house all sparkly and pretty, Webber! Great job!",
        SPIDER_HEALER = "A nurse-bug! Will your friend heal my boo-boos too?",
        SPIDER_REPELLENT = "This smelly spray keeps the meanie bugs away so we can play safely!",
        SPIDER_HEALER_ITEM = "I'll keep this safe until we find a nice home for your nurse-bug friend!",

        -- Wendy
        GHOSTLYELIXIR_SLOWREGEN = "A bubbly ghost-potion to help the floaty-friend heal!",
        GHOSTLYELIXIR_FASTREGEN = "Super zoomy healing-juice for the ghost-girl!",
        GHOSTLYELIXIR_SHIELD = "A magic shield-potion! Nobody can hurt the floaty-friend now.",
        GHOSTLYELIXIR_ATTACK = "Spicy ghost-juice to make her hit super hard! Pow!",
        GHOSTLYELIXIR_SPEED = "Zoom-zoom potion! The ghost-friend is going to fly so fast!",
        GHOSTLYELIXIR_RETALIATION = "Bouncy-juice! If the bullies hit her, they get hurt back!",
        GHOSTLYELIXIR_REVIVE = "A wake-up potion for the sleepy ghost!",
        SISTURN =
        {
            GENERIC = "A spooky sad-jar. It needs some happy petals.",
            SOME_FLOWERS = "Just a few more petals to make it pretty!",
            LOTS_OF_FLOWERS = "Look at all the pretty flowers! The floaty-friend must be so happy!",
            LOTS_OF_FLOWERS_EVIL = "Uh oh, the magic flowers are making me feel wibbly-wobbly.",
            LOTS_OF_FLOWERS_BLOSSOM = "The jar is humming a spooky night-song.",   
        },

        --Wortox
        WORTOX_SOUL = "only_used_by_wortox", --only wortox can inspect souls
        --WORTOX_DECOY is not needed because it uses the default WORTOX inspection.
        WORTOX_NABBAG = "The little red-friend has a spooky monster-bag!",
        WORTOX_REVIVER = "Healing monster-fluff! It brings friends back from the forever-nap.",
        WORTOX_SOULJAR = "A glass trap for the bouncy little souls! Let them out to play!",

        PORTABLECOOKPOT_ITEM =
        {
            GENERIC = "Mr. Chef's magic pot! We can make yummy treats anywhere!",
            DONE = "Ding! The snacks are ready! Yum!",

            COOKING_LONG = "My tummy-nebula is rumbling! Hurry up!",
            COOKING_SHORT = "Zoom-zoom cooking! Almost done!",
            EMPTY = "It needs yummy ingredients to do its magic.",
        },

        PORTABLEBLENDER_ITEM = "Spin, spin, spin! This noisy machine mixes the best snacks!",
        PORTABLESPICER_ITEM =
        {
            GENERIC = "Mr. Chef uses this to make the food extra tingly and fun!",
            DONE = "Spicy and ready for my tummy-nebula!",
        },
        SPICEPACK = "So much tasty star-dust hidden in this backpack!",
        SPICE_GARLIC = "Stinky dust! Perfect for keeping the space-bullies away.",
        SPICE_SUGAR = "Yummy sweet star-dust! Can I eat it plain?",
        SPICE_CHILI = "Hot hot fire-dust! It makes my tongue do a little dance!",
        SPICE_SALT = "Salty star-dust! Just a tiny pinch is enough.",
        MONSTERTARTARE = "Yuck! I don't want to eat a grumpy monster-snack.",
        FRESHFRUITCREPES = "Sweet fruit roll-ups! This is the absolute bestest breakfast!",
        FROGFISHBOWL = "Look! Mr. Chef put bouncy-frogs in a fish-bowl! He is so silly.",
        POTATOTORNADO = "Zoom! It's a spinny twister made entirely of dirt-apples!",
        DRAGONCHILISALAD = "Fire breath! RAWR! This green snack is super-duper spicy!",
        GLOWBERRYMOUSSE = "Wow... glowing star-pudding! It's too pretty to eat, but I'm going to anyway!",
        VOLTGOATJELLY = "Zap zap! This wiggly jelly-snack tickles my tongue!",
        NIGHTMAREPIE = "Spooky bad-dream pie... I have to close my eyes before I take a bite.",
        BONESOUP = "Slurp! A yummy bowl of star-fuel with giant bones inside!",
        MASHEDPOTATOES = "Someone squashed all the dirt-apples! They're super squishy now.",
        POTATOSOUFFLE = "It looks like a fluffy dirt-apple cloud! So soft.",
        MOQUECA = "Mr. Chef made a super fancy, extra messy fish-snack.",
        GAZPACHO = "Brrr! This splashy red soup is freezing cold!",
        ASPARAGUSSOUP = "Warm soup made entirely of green sticks.",
        VEGSTINGER = "Gulp! This celery-stick drink has a spicy kick to it!",
        BANANAPOP = "Brain freeze! The yellow mush-snack is freezing cold!",
        CEVICHE = "Ooh, my face scrunches up when I eat this sour fishy-bowl.",
        SALSA = "Water, please! This splat-sauce is super-duper spicy!",
        PEPPERPOPPER = "Hot, hot, hot! My mouth is doing a supernova!",

        TURNIP = "Crunch! This snappy-snack is super raw.",
        TURNIP_COOKED = "The fire made the snappy-snack nice and soft!",
        TURNIP_SEEDS = "Little magic seeds to grow more snappy-snacks.",

        GARLIC = "Stinky breath power! The bullies won't come near me now.",
        GARLIC_COOKED = "Toasty and warm, but it still smells really strong!",
        GARLIC_SEEDS = "I'm going to plant these and grow the stinkiest snacks.",

        ONION = "Why is this bumpy snack making my peepers leak?!",
        ONION_COOKED = "Yay! The fire cooked the cry-magic right out of it.",
        ONION_SEEDS = "Tiny seeds that grow into tears.",

        POTATO = "Look at this funny bumpy dirt-apple!",
        POTATO_COOKED = "Hot and mushy! Perfect for my tummy-nebula.",
        POTATO_SEEDS = "Baby dirt-apples waiting for the soil.",

        TOMATO = "Splat! This red snack is so squishy.",
        TOMATO_COOKED = "Careful, the mushy splat-snack is super hot!",
        TOMATO_SEEDS = "These little seeds will grow into red splatters.",

        ASPARAGUS = "I can use this green stick-snack as a tiny sword!",
        ASPARAGUS_COOKED = "Mr. Scientist says cooked green sticks make cubs grow big and strong!",
        ASPARAGUS_SEEDS = "Planting tiny swords in the garden.",

        PEPPER = "Danger! This little red bite is hiding fire inside!",
        PEPPER_COOKED = "Even after cooking, it makes my tongue do a fire-dance!",
        PEPPER_SEEDS = "I have to be careful not to burn my paws planting these fire-seeds.",

        WEREITEM_BEAVER = "Where did Mr. Wood-Chopper go? He left his fuzzy beaver-toy behind!",
        WEREITEM_GOOSE = "Honk honk! This silly bird-toy makes me laugh.",
        WEREITEM_MOOSE = "Wow! A heavy monster-toy with giant antlers!",

        MERMHAT = "A stinky fishy-frog hat! It smells like a swamp! Bleh!",        
        MERMTHRONE =
        {
            GENERIC = "A fancy mud-chair for the fishy-frog king!",
            BURNT = "The big mud-chair got all crispy.",
        },
        MOSQUITOMUSK = "Smelly bug-juice so the biters leave me alone!",
        MOSQUITOBOMB = "A bouncy bug-bomb! I want to throw it right now!",
        MOSQUITOFERTILIZER = "Yuck! The green-friends actually like eating this gross bug-stuff?",
        MOSQUITOMERMSALVE = "Healing-goo from the biters. The fishy-frogs love it!",

        MERMTHRONE_CONSTRUCTION =
        {
            GENERIC = "They are building a giant mud-chair!",
            BURNT = "The half-built mud-chair had a supernova.",
        },
        MERMHOUSE_CRAFTED =
        {
            GENERIC = "A little mud-castle for the frogs. Cute!",
            BURNT = "Pee-yew! Burnt frog-house stinks!",
        },

        MERMWATCHTOWER_REGULAR = "A tall mud-tower for the guards.",
        MERMWATCHTOWER_NOKING = "A lonely guard tower with no king to watch.",
        MERMKING = "The giant king of the fishy-frogs! Bow down!",
        MERMGUARD = "A grumpy frog-guard. He has a pointy stick!",
        MERM_PRINCE = "A little frog-prince! Hello there!",

        SQUID = "A squishy water-puddle with eyes! Can I poke it?",

        GHOSTFLOWER = "Spooky-flowers! They look like they're made of sad-magic.",
        SMALLGHOST = "Aww, a tiny floaty-friend! Did you get a boo-boo?",

        CRABKING =
        {
            GENERIC = "Oh no! The giant snappy-crab looks super grumpy!",
            INERT = "The big sleepy rock-crab needs some pretty gems to wake up.",
        },
        CRABKING_CLAW = "Giant snappy-claws! Don't pinch my tail!",

        MESSAGEBOTTLE = "A floating glass toy with a secret paper inside!",
        MESSAGEBOTTLEEMPTY = "Just an empty bottle-star now.",

        MEATRACK_HERMIT =
        {
            DONE = "Chewy-snack time! Yay!",
            DRYING = "The snack is taking a long sun-nap.",
            DRYINGINRAIN = "Sky-juice makes the snack-nap take forever!",
            GENERIC = "A hanging-toy for making chewy treats.",
            BURNT = "Oh no, my snack-hanger had a supernova!",
            DONE_NOTMEAT = "It's all crispy and ready to munch!",
            DRYING_NOTMEAT = "Drying out leaves is serious star-business.",
            DRYINGINRAIN_NOTMEAT = "Go away, sky-juice! My snacks are getting soggy!",
        },
        BEEBOX_HERMIT =
        {
            READY = "Full of sticky sweet-stuff! Yum!",
            FULLHONEY = "So much sticky sweet-stuff!",
            GENERIC = "A wooden house for the buzzy-bugs.",
            NOHONEY = "No sweet-stuff today. The bugs are resting.",
            SOMEHONEY = "The buzzy-bugs are still cooking the sweet-stuff.",
            BURNT = "Oh no! The buzzy-bug house had a big fire-tantrum!",
        },

        HERMITCRAB = "The little shell-lady lives all alone by the splashy-water.",

        HERMIT_PEARL = "A giant shiny night-pearl! I'll keep it super safe.",
        HERMIT_CRACKED_PEARL = "Uh oh... the shiny night-pearl got a big boo-boo.",

        -- DSEAS
        WATERPLANT = "Big splashy-plants! Don't make them mad or they'll spit at us!",
        WATERPLANT_BOMB = "Incoming! The splashy-plants are throwing spit-balls!",
        WATERPLANT_BABY = "A tiny baby splash-plant!",
        WATERPLANT_PLANTER = "They like sleeping on the big water-rocks.",

        SHARK = "Ahhh! A giant bitey-fish is chasing us!",

        MASTUPGRADE_LAMP_ITEM = "A shiny sky-star to put on the boat!",
        MASTUPGRADE_LIGHTNINGROD_ITEM = "A magic stick to catch all the sky-sparks!",

        WATERPUMP = "A splashy-shooter! Perfect for putting out the bad fire-tantrums.",

        BARNACLE = "Hard little rocks that grow on the water-plants.",
        BARNACLE_COOKED = "A warm, crunchy rock-snack!",

        BARNACLEPITA = "Crunchy rock-snacks wrapped in a yummy blanket!",
        BARNACLESUSHI = "Bite-sized sea-snacks rolled up with soggy-strings!",
        BARNACLINGUINE = "Curly noodles with crunchy sea-rocks!",
        BARNACLESTUFFEDFISHHEAD = "A whole fishy-head? Gross! But... my tummy-nebula is rumbling...",

        LEAFLOAF = "A loaf of bread made of scratchy-meat. Weird.",
        LEAFYMEATBURGER = "A squishy burger made out of a plant-monster!",
        LEAFYMEATSOUFFLE = "Fancy fluffy food made from scratchy-meat!",
        MEATYSALAD = "A salad that tastes like a steak! Science is amazing!",

        -- GROTTO

        MOLEBAT = "A flappy blind squeaker! So weird.",
        MOLEBATHILL = "What kind of toys do the squeakers hide in that messy dirt-pile?",

        BATNOSE = "Ew! A squishy pink snout! Keep it away from me.",
        BATNOSE_COOKED = "Cooking it didn't make it any less gross!",
        BATNOSEHAT = "Wearing a giant nose on my head? No thank you!",

        MUSHGNOME = "Watch out for the grumpy walking-shroom!",

        SPORE_MOON = "Pretty floating night-sparks! They make the dark less scary.",

        MOON_CAP = "A squishy glowing umbrella-plant.",
        MOON_CAP_COOKED = "Warm and sleepy glowing snacks.",

        MUSHTREE_MOON = "Look at this giant glowing umbrella-tree! It's super bright.",

        LIGHTFLIER = "Holding this buzzy little star-bug makes me feel floaty!",

        GROTTO_POOL_BIG = "A puddle of magic star-water making shiny glass! Amazing!",
        GROTTO_POOL_SMALL = "Sparkly night-water turning into shiny rocks!",

        DUSTMOTH = "What a cute little flutter-bug! It cleans up all the mess.",

        DUSTMOTHDEN = "The flutter-bugs made a cozy little house in the rocks.",

        ARCHIVE_LOCKBOX = "A shiny metal puzzle-box! What's inside?",
        ARCHIVE_CENTIPEDE = "Ahhh! A giant metal many-legs! Run away!",
        ARCHIVE_CENTIPEDE_HUSK = "Just some broken beep-boop bug pieces.",

        ARCHIVE_COOKPOT =
        {
            COOKING_LONG = "This metal tummy is taking forever to cook my snack.",
            COOKING_SHORT = "Almost done! My tummy-nebula is rumbling.",
            DONE = "Yay! The yummy food is finally ready!",
            EMPTY = "Let's put some fun ingredients in this old cooking-toy.",
            BURNT = "Oh no, the shiny pot threw a fire-tantrum.",
        },

        ARCHIVE_MOON_STATUE = "Pretty statues glowing with night-sparks!",
        ARCHIVE_RUNE_STATUE =
        {
            LINE_1 = "Funny doodles on a big rock!",
            LINE_2 = "I don't know how to read this ancient star-language.",
            LINE_3 = "Secret squiggles! What do they mean?",
            LINE_4 = "These rock-doodles look super different from the others.",
            LINE_5 = "Maybe if I stare at the squiggles long enough, I'll understand them.",
        },
        VAULT_RUNE = "Just a bunch of glowing squiggles.",
        VAULT_STATUE =
        {
            LORE1 = "Spooky story-rocks... they give me the shivers.",
            LORE2 = "This rock-story is all about giant bugs. Yuck!",
            LORE3 = "A very pointy story-statue.",
        },

        ARCHIVE_RESONATOR = {
            GENERIC = "A giant beep-boop toy for finding secrets!",
            IDLE = "The secret-finder is resting its brain.",
        },

        ARCHIVE_RESONATOR_ITEM = "A heavy puzzle piece for building the secret-finder.",

        ARCHIVE_LOCKBOX_DISPENCER = {
          POWEROFF = "The toy-box machine is fast asleep.",
          GENERIC =  "I want to push all the buttons to see what comes out!",
        },

        ARCHIVE_SECURITY_DESK = {
            POWEROFF = "A big broken table with sleepy lights.",
            GENERIC = "I'm going to sit here and pretend to be the boss!",
        },

        ARCHIVE_SECURITY_PULSE = "Where are you zooming off to, little spark?",

        ARCHIVE_SWITCH = {
            VALID = "The shiny gems woke the beep-boops up!",
            GEMS = "This clicky-switch is hungry for a shiny gem.",
        },

        ARCHIVE_PORTAL = {
            POWEROFF = "A giant sleepy metal ring.",
            GENERIC = "Why won't the space-door open? I want to go through!",
        },

        WALL_STONE_2 = "A wall of heavy grey blocks.",
        WALL_RUINS_2 = "A super old block from the deep dark.",

        REFINED_DUST = "Ah-choo! Tickly sparkly star-dust!",
        DUSTMERINGUE = "A fluffy cloud-cookie! But it tastes like... dirt.",

        SHROOMCAKE = "A squishy cake made of bouncy mushrooms!",
        SHROOMBAIT = "Smells like a sleepy-time snack for the bugs.",

        NIGHTMAREGROWTH = "Ahhh! Bad-magic crystals are growing everywhere! Keep away!",

        TURFCRAFTINGSTATION = "A special table for making puzzle-floor pieces!",

        MOON_ALTAR_LINK = "The magic rock is humming a happy little star-tune!",

        -- FARMING
        COMPOSTINGBIN =
        {
            GENERIC = "Pee-yew! That barrel smells like a giant stinky burp!",
            WET = "Yuck, it's all goopy and soggy inside.",
            DRY = "It needs a drink of splashy-water to get perfectly stinky.",
            BALANCED = "The perfect amount of stinky science!",
            BURNT = "Oh no! The stinky-barrel had a supernova!",
        },
        COMPOST = "Stinky-dirt for making the green-friends grow tall!",
        SOIL_AMENDER =
        {
            GENERIC = "Magic potion for the dirt!",
            STALE = "It's starting to smell like a proper science experiment!",
            SPOILED = "Pee-yew! The plants are going to love this stinky treat!",
        },

        SOIL_AMENDER_FERMENTED = "Super-stinky dirt potion! Science is gross sometimes.",

        WATERINGCAN =
        {
            GENERIC = "Time to give the green-friends a splashy drink!",
            EMPTY = "I need to fill its tummy with more sky-juice.",
        },
        PREMIUMWATERINGCAN =
        {
            GENERIC = "A super splashy-can made with flappy-bird magic!",
            EMPTY = "The super splashy-can is all thirsty now.",
        },

        FARM_PLOW = "Big clicky-toys for drawing straight lines in the dirt.",
        FARM_PLOW_ITEM = "Where should I draw the lines for my star-garden?",
        FARM_HOE = "Scratch, scratch! Making a cozy bed for the little seeds.",
        GOLDEN_FARM_HOE = "Look at this shiny gold scratcher! I feel like a royal gardener!",
        NUTRIENTSGOGGLESHAT = "Magic glasses to see the secret star-dust hiding in the dirt!",
        PLANTREGISTRYHAT = "If I wear this leafy crown, maybe the plants will tell me their secrets!",

        FARM_SOIL_DEBRIS = "Shoo! Get out of my garden, you messy junk!",

        FIRENETTLES = "Ouchie! Those meanie-leaves gave my paws a hot poke!",
        FORGETMELOTS = "Pretty little blue ground-stars! Wait... what was I doing again?",
        SWEETTEA = "Warm sweet-water to make my tummy-nebula happy!",
        TILLWEED = "You're a bully-weed! Leave my green-friends alone!",
        TILLWEEDSALVE = "Magic gooey-stuff to fix my scratches.",
        WEED_IVY = "Hey! You're not supposed to grow here, you sneaky string-weed!",
        IVY_SNARE = "Ahhh! The sneaky string-weed tried to grab my paws!",

        TROPHYSCALE_OVERSIZEDVEGGIES =
        {
            GENERIC = "Let's see how heavy the giant green-friends are!",
            HAS_ITEM = "Weight: {weight}\nHarvested on day: {day}\nLook at that big heavy snack!",
            HAS_ITEM_HEAVY = "Weight: {weight}\nHarvested on day: {day}\nWhoa! It's as heavy as a meteor!",
            HAS_ITEM_LIGHT = "This snack is too tiny to even move the scale. So silly!",
            BURNING = "Uh oh, the giant snack is having a fire-tantrum!",
            BURNT = "Crispy charcoal is not a yummy snack.",
        },

        CARROT_OVERSIZED = "What a giant pointy-snack! Is there a giant bunny around?",
        CORN_OVERSIZED = "Look at all those yellow teeth! It's taller than me!",
        PUMPKIN_OVERSIZED = "A massive wobble-gourd! Can I carve a spooky face on it?",
        EGGPLANT_OVERSIZED = "This giant purple balloon-plant is so squishy!",
        DURIAN_OVERSIZED = "Pee-yew! The stinky-fruit is as big as a boulder!",
        POMEGRANATE_OVERSIZED = "It's bursting with giant red star-seeds!",
        DRAGONFRUIT_OVERSIZED = "Wow, a giant pink spicy-fruit! Does it breathe fire now?",
        WATERMELON_OVERSIZED = "A super heavy splash-melon! I want to jump on it!",
        TOMATO_OVERSIZED = "One giant red squish-ball! Splat!",
        POTATO_OVERSIZED = "The biggest bumpy dirt-apple in the whole galaxy!",
        ASPARAGUS_OVERSIZED = "A giant green spear! I can use it for jousting games!",
        ONION_OVERSIZED = "My eyes! The giant cry-bulb is making tears shoot out of my peepers!",
        GARLIC_OVERSIZED = "A huge stinky-clove! It'll keep all the space-bullies away!",
        PEPPER_OVERSIZED = "A massive fire-snack! My mouth feels hot just looking at it.",

        VEGGIE_OVERSIZED_ROTTEN = "Ew! The giant snack turned into a giant pile of mush!",

        FARM_PLANT =
        {
            GENERIC = "Hello there, little green-friend!",
            SEED = "Sleep tight, little seed! Grow up strong!",
            GROWING = "Reach for the stars, little plant! You can do it!",
            FULL = "Yay! The green-friend made a yummy snack for me!",
            ROTTEN = "Oh no... the green-friend lost its spark and got all mushy.",
            FULL_OVERSIZED = "Wow! Star-magic made the green-friend grow super humongous!",
            ROTTEN_OVERSIZED = "A giant mountain of yucky mush! Gross!",
            FULL_WEED = "Aha! You're a sneaky bully-weed hiding in my garden!",

            BURNING = "Ahhh! Fire is bad for the green-friends! Stop!",
        },

        FRUITFLY = "Shoo! Go away, you buzzy little pest!",
        LORDFRUITFLY = "The giant bully-bug is trying to hurt my green-friends! Rawr!",
        FRIENDLYFRUITFLY = "A happy little floaty-bug! Thanks for helping my garden!",
        FRUITFLYFRUIT = "A magic bug-fruit! Now the floaty-bug plays follow-the-leader with me!",

        SEEDPOUCH = "A tiny backpack just for carrying my little star-seeds!",

		-- Crow Carnival
        CARNIVAL_HOST = "That funny bird-man is wearing a really fancy suit!",
        CARNIVAL_CROWKID = "Hello there, little flappy-friend! Are we playing a game?",
        CARNIVAL_GAMETOKEN = "A shiny gold coin for playing games! Yay!",
        CARNIVAL_PRIZETICKET =
        {
            GENERIC = "A winning paper! I'm going to save it.",
            GENERIC_SMALLSTACK = "A tiny pile of winning papers!",
            GENERIC_LARGESTACK = "So many winning papers! I'm going to get the biggest toy!",
        },

        CARNIVALGAME_FEEDCHICKS_NEST = "A tiny hidden door for the baby birdies!",
        CARNIVALGAME_FEEDCHICKS_STATION =
        {
            GENERIC = "The game is sleeping until I feed it a shiny coin.",
            PLAYING = "Time to feed the baby birdies! Zoom zoom!",
        },
        CARNIVALGAME_FEEDCHICKS_KIT = "Pieces to build a hungry-birdie game!",
        CARNIVALGAME_FEEDCHICKS_FOOD = "Squishy bug-snacks for the baby birds! Yuck!",

        CARNIVALGAME_MEMORY_KIT = "Puzzle pieces for a thinking game!",
        CARNIVALGAME_MEMORY_STATION =
        {
            GENERIC = "I need to drop a shiny coin to wake the memory game up.",
            PLAYING = "I'm super good at remembering things! My star-brain is the best!",
        },
        CARNIVALGAME_MEMORY_CARD =
        {
            GENERIC = "A little flippy-door!",
            PLAYING = "Flipping the cards to find a match! Where did the other one go?",
        },

        CARNIVALGAME_HERDING_KIT = "A box full of run-around game pieces!",
        CARNIVALGAME_HERDING_STATION =
        {
            GENERIC = "The game wants a shiny coin to start the fun.",
            PLAYING = "Those little eggs have tiny legs! How silly!",
        },
        CARNIVALGAME_HERDING_CHICK = "Stop running away, you silly egg-legs!",

        CARNIVALGAME_SHOOTING_KIT = "Toys to build a zoomy-shooter game!",
        CARNIVALGAME_SHOOTING_STATION =
        {
            GENERIC = "Where does the shiny coin go to start the pew-pew?",
            PLAYING = "Pew! Pew! I'm gonna hit all the targets!",
        },
        CARNIVALGAME_SHOOTING_TARGET =
        {
            GENERIC = "A little target waiting to be hit.",
            PLAYING = "Gotcha! You can't hide from my zoomy shots!",
        },

        CARNIVALGAME_SHOOTING_BUTTON =
        {
            GENERIC = "This button is super hungry for a shiny coin.",
            PLAYING = "Push the big red button for a boom! Pow!",
        },

        CARNIVALGAME_WHEELSPIN_KIT = "Parts for a super spinny wheel!",
        CARNIVALGAME_WHEELSPIN_STATION =
        {
            GENERIC = "A shiny coin makes the big wheel go round!",
            PLAYING = "Spin, spin, spin! Where will it stop?",
        },

        CARNIVALGAME_PUCKDROP_KIT = "A drop-the-ball game waiting to be built!",
        CARNIVALGAME_PUCKDROP_STATION =
        {
            GENERIC = "I have to pay a shiny coin to watch the ball go plink-plonk.",
            PLAYING = "Plink, plink, plonk! Fall in the middle hole!",
        },

        CARNIVAL_PRIZEBOOTH_KIT = "A big tent where I can trade my winning papers for toys!",
        CARNIVAL_PRIZEBOOTH =
        {
            GENERIC = "Look at all those shiny toys! I want that one! And that one!",
        },

        CARNIVALCANNON_KIT = "Pieces for a giant party-boom shooter!",
        CARNIVALCANNON =
        {
            GENERIC = "This cannon shoots happy sparks instead of scary rocks!",
            COOLDOWN = "Wow! Did you see all the pretty colors?",
        },

        CARNIVAL_PLAZA_KIT = "A big tree for the carnival party!",
        CARNIVAL_PLAZA =
        {
            GENERIC = "This tree needs way more sparkly things on it!",
            LEVEL_2 = "It's getting prettier, but it still needs more party-stuff!",
            LEVEL_3 = "The most beautiful party-tree in the whole galaxy!",
        },

        CARNIVALDECOR_EGGRIDE_KIT = "Toys to build a bouncy egg ride!",
        CARNIVALDECOR_EGGRIDE = "Wheee! Look at the little egg go up and down!",

        CARNIVALDECOR_LAMP_KIT = "Pieces to make a pretty party-light.",
        CARNIVALDECOR_LAMP = "A happy little light for the carnival games.",
        CARNIVALDECOR_PLANT_KIT = "A fake bush in a box.",
        CARNIVALDECOR_PLANT = "Is this bush real? It feels like a toy.",
        CARNIVALDECOR_BANNER_KIT = "I have to hang the party-flags myself? Okay!",
        CARNIVALDECOR_BANNER = "Flappy party-flags make everything look so fun!",

        CARNIVALDECOR_FIGURE =
        {
            RARE = "Wow! I got the super shiny rare toy! I'm so lucky!",
            UNCOMMON = "This toy is cooler than the regular ones!",
            GENERIC = "Another little statue for my collection!",
        },
        CARNIVALDECOR_FIGURE_KIT = "A mystery box! What kind of toy is inside?",
        CARNIVALDECOR_FIGURE_KIT_SEASON2 = "A mystery box with brand new toys inside!",

        CARNIVAL_BALL = "A bouncy sphere! Catch!",
        CARNIVAL_SEEDPACKET = "Snacks for the birds or seeds for the dirt?",
        CARNIVALFOOD_CORNTEA = "Crunchy yellow leaf-water? That's a silly drink!",

        CARNIVAL_VEST_A = "I feel like a brave explorer in this!",
        CARNIVAL_VEST_B = "A leafy shirt! Now I'm a walking bush.",
        CARNIVAL_VEST_C = "I hope there aren't any actual bugs hiding in this flower-shirt!",

        -- YOTB
        YOTB_SEWINGMACHINE = "A clickety-clack machine for making fuzzy clothes!",
        YOTB_SEWINGMACHINE_ITEM = "Pieces for a clickety-clack sewing toy.",
        YOTB_STAGE = "The boss bird-man sits there to watch the game!",
        YOTB_POST =  "Tie the fuzzy monster here so it doesn't wander off during the show.",
        YOTB_STAGE_ITEM = "Toys to build a big wooden sitting-spot.",
        YOTB_POST_ITEM =  "A tying-stick for the fuzzy monsters.",

        YOTB_PATTERN_FRAGMENT_1 = "Doodle-papers with secrets for making fuzzy-monster clothes!",
        YOTB_PATTERN_FRAGMENT_2 = "Doodle-papers with secrets for making fuzzy-monster clothes!",
        YOTB_PATTERN_FRAGMENT_3 = "Doodle-papers with secrets for making fuzzy-monster clothes!",

        YOTB_BEEFALO_DOLL_WAR = {
            GENERIC = "A little squishy fuzzy-monster toy! Perfect for star-hugs!",
            YOTB = "I wonder if the big bird-judge likes this squishy toy.",
        },
        YOTB_BEEFALO_DOLL_DOLL = {
            GENERIC = "A little squishy fuzzy-monster toy! Perfect for star-hugs!",
            YOTB = "I wonder if the big bird-judge likes this squishy toy.",
        },
        YOTB_BEEFALO_DOLL_FESTIVE = {
            GENERIC = "A little squishy fuzzy-monster toy! Perfect for star-hugs!",
            YOTB = "I wonder if the big bird-judge likes this squishy toy.",
        },
        YOTB_BEEFALO_DOLL_NATURE = {
            GENERIC = "A little squishy fuzzy-monster toy! Perfect for star-hugs!",
            YOTB = "I wonder if the big bird-judge likes this squishy toy.",
        },
        YOTB_BEEFALO_DOLL_ROBOT = {
            GENERIC = "A little squishy fuzzy-monster toy! Perfect for star-hugs!",
            YOTB = "I wonder if the big bird-judge likes this squishy toy.",
        },
        YOTB_BEEFALO_DOLL_ICE = {
            GENERIC = "A little squishy fuzzy-monster toy! Perfect for star-hugs!",
            YOTB = "I wonder if the big bird-judge likes this squishy toy.",
        },
        YOTB_BEEFALO_DOLL_FORMAL = {
            GENERIC = "A little squishy fuzzy-monster toy! Perfect for star-hugs!",
            YOTB = "I wonder if the big bird-judge likes this squishy toy.",
        },
        YOTB_BEEFALO_DOLL_VICTORIAN = {
            GENERIC = "A little squishy fuzzy-monster toy! Perfect for star-hugs!",
            YOTB = "I wonder if the big bird-judge likes this squishy toy.",
        },
        YOTB_BEEFALO_DOLL_BEAST = {
            GENERIC = "A little squishy fuzzy-monster toy! Perfect for star-hugs!",
            YOTB = "I wonder if the big bird-judge likes this squishy toy.",
        },

        WAR_BLUEPRINT = "Doodles to make the fuzzy-monster look super brave!",
        DOLL_BLUEPRINT = "This doodle makes the fuzzy-monster look like a giant squishy toy!",
        FESTIVE_BLUEPRINT = "Party-clothes doodles for the fuzzy-monster!",
        ROBOT_BLUEPRINT = "Beep-boop clothes for the fuzzy-monster! Science!",
        NATURE_BLUEPRINT = "Flower-power doodles for a pretty monster.",
        FORMAL_BLUEPRINT = "Fancy suit doodles so the monster looks like a boss.",
        VICTORIAN_BLUEPRINT = "Old-timey dress doodles for the fuzzy-monster.",
        ICE_BLUEPRINT = "Frosty popsic-doodles to keep the monster cool.",
        BEAST_BLUEPRINT = "Scary monster doodles! Rawr!",

        BEEF_BELL = "Ring-a-ding! This bell makes the giant fuzzy monsters want to be my friend!",

		-- YOT Catcoon
        KITCOONDEN =
        {
            GENERIC = "Only a tiny fuzzy-kitty could squeeze in there!",
            BURNT = "Oh no! The kitty-hideout got all burnt up!",
            PLAYING_HIDEANDSEEK = "Ready or not, here I come! Where are you hiding?",
            PLAYING_HIDEANDSEEK_TIME_ALMOST_UP = "The game is almost over! Come out, come out!",
        },

        KITCOONDEN_KIT = "Puzzle pieces for a fuzzy-kitty house!",

        TICOON =
        {
            GENERIC = "This kitty is a super-sniffer!",
            ABANDONED = "The sniffer-kitty gave up. I'll just use my own nose!",
            SUCCESS = "Yay! He found a hidden friend!",
            LOST_TRACK = "Aww, another player tagged them first.",
            NEARBY = "The sniffer-kitty's tail is wagging! Something is close!",
            TRACKING = "Follow the leader! Zoom zoom!",
            TRACKING_NOT_MINE = "That kitty is playing follow-the-leader with someone else.",
            NOTHING_TO_TRACK = "No more hidden friends to sniff out.",
            TARGET_TOO_FAR_AWAY = "The hiding spot is too far for his little sniffer.",
        },

        YOT_CATCOONSHRINE =
        {
            GENERIC = "A big statue of a fuzzy-kitty! Should I leave a toy?",
            EMPTY = "It wants a tickle-feather to play with!",
            BURNT = "Crispy kitty statue. Poor thing.",
        },

        KITCOON_FOREST = "Aren't you the fluffiest little ground-cloud!",
        KITCOON_SAVANNA = "Come here so I can give you a star-hug!",
        KITCOON_MARSH = "I need to scoop you up before you get muddy!",
        KITCOON_DECIDUOUS = "Look at those big eyes! You're so cute!",
        KITCOON_GRASS = "A tiny bouncing fuzzball!",
        KITCOON_ROCKY = "Don't scratch your paws on the hard rocks, little kitty!",
        KITCOON_DESERT = "A hot and sandy fuzzy-friend!",
        KITCOON_MOON = "You're a glowing night-spark kitty!",
        KITCOON_YOT = "I want to play tag with you all day!",

        -- Moon Storm
        ALTERGUARDIAN_PHASE1 = {
            GENERIC = "Stop being a big meanie and throwing things at us!",
            DEAD = "Take that, you giant space-bully!",
        },
        ALTERGUARDIAN_PHASE2 = {
            GENERIC = "Uh oh... the space-bully is throwing a giant tantrum!",
            DEAD = "Is it finally time for your nap?",
        },
        ALTERGUARDIAN_PHASE2SPIKE = "Watch out for the glowing pointy-sticks!",
        ALTERGUARDIAN_PHASE3 = "Ahhh! The night-bully is super-duper mad now!",
        ALTERGUARDIAN_PHASE3TRAP = "Those shiny traps make my eyes feel super heavy.",
        ALTERGUARDIAN_PHASE3DEADORB = "The night-spark is still floating there... Is the game over?",
        ALTERGUARDIAN_PHASE3DEAD = "I think I see something shiny inside! I wanna see, I wanna see!",

        ALTERGUARDIANHAT = "This shiny crown makes my brain feel bigger than a whole galaxy!",
        ALTERGUARDIANHATSHARD = "Just a piece of the shiny crown, but it still glows!",

        MOONSTORM_GLASS = {
            GENERIC = "Shiny star-glass!",
            INFUSED = "It's buzzing with super-charged night-magic!"
        },

        MOONSTORM_STATIC = "Zap zap! Floating sky-sparks!",
        MOONSTORM_STATIC_ITEM = "Holding this makes my mane go poof!",
        MOONSTORM_STATIC_ROAMER = "A little zappy-spark zooming all over the place!",
        MOONSTORM_SPARK = "I caught a bouncy little star-zap!",

        BIRD_MUTANT = "The night-magic turned the birdie into a scary monster!",
        BIRD_MUTANT_SPITTER = "Stop spitting yucky stuff at me, meanie-bird!",

        WAGSTAFF_NPC = "Mr. Scientist is playing with the sky-sparks! I want to help!",

        WAGSTAFF_NPC_MUTATIONS = "Mr. Scientist is always busy with his games!",
        WAGSTAFF_NPC_WAGPUNK = "Where is Mr. Scientist zooming off to now?",

        ALTERGUARDIAN_CONTAINED = "The science-machine is eating all the boss-monster's sparks!",

        WAGSTAFF_TOOL_1 = "Ooh, a shiny grabby-tool! Is this what he wants?",
        WAGSTAFF_TOOL_2 = "A heavy smasher-tool! Perfect for breaking things!",
        WAGSTAFF_TOOL_3 = "A clicky-turner! Science is so fun!",
        WAGSTAFF_TOOL_4 = "This weird stick looks super important!",
        WAGSTAFF_TOOL_5 = "A squishy science-toy! Catch, Mr. Scientist!",

        MOONSTORM_GOGGLESHAT = "Funny glasses made of ground-snacks! Now the sky-sparks don't blind me.",

        MOON_DEVICE = {
            GENERIC = "A giant spark-trap to catch the night-magic!",
            CONSTRUCTION1 = "We're building a super cool trap!",
            CONSTRUCTION2 = "Almost done putting the puzzle together!",
        },

        -- Wanda
        POCKETWATCH_HEAL = {
            GENERIC = "A tick-tock toy to fix boo-boos!",
            RECHARGING = "The tick-tock toy needs a nap before it heals again.",
        },

        POCKETWATCH_REVIVE = {
            GENERIC = "A tick-tock toy that wakes friends up from the forever-nap!",
            RECHARGING = "The toy is out of waking-sparks right now.",
        },

        POCKETWATCH_WARP = {
            GENERIC = "This tick-tock toy makes me zoom backwards!",
            RECHARGING = "It's winding back up for another zoom!",
        },

        POCKETWATCH_RECALL = {
            GENERIC = "A magic teleporter hidden inside a tick-tock toy!",
            RECHARGING = "The magic door-toy is resting.",
            UNMARKED = "only_used_by_wanda",
            MARKED_SAMESHARD = "only_used_by_wanda",
            MARKED_DIFFERENTSHARD = "only_used_by_wanda",
        },

        POCKETWATCH_PORTAL = {
            GENERIC = "A tick-tock toy to make space-doors for everyone!",
            RECHARGING = "No more space-doors until the toy stops resting.",
            UNMARKED = "only_used_by_wanda unmarked",
            MARKED_SAMESHARD = "only_used_by_wanda same shard",
            MARKED_DIFFERENTSHARD = "only_used_by_wanda other shard",
        },

        POCKETWATCH_WEAPON = {
            GENERIC = "A scary tick-tock whip! Snap snap!",
            DEPLETED = "only_used_by_wanda",
        },

        POCKETWATCH_PARTS = "Broken bits of tick-tock magic. So many tiny gears!",
        POCKETWATCH_DISMANTLER = "A squishing-tool to break the tick-tock toys apart!",

        POCKETWATCH_PORTAL_ENTRANCE =
        {
            GENERIC = "Let's jump through the space-door! Wheee!",
            DIFFERENTSHARD = "A space-door to another world! Here I go!",
        },
        POCKETWATCH_PORTAL_EXIT = "Whoa, that was a super dizzy ride!",

        -- Waterlog
        WATERTREE_PILLAR = "Wow, that tree is as tall as a comet's tail!",
        OCEANTREE = "Silly trees, you're supposed to grow in the dirt, not the splashy-water!",
        OCEANTREENUT = "It's a heavy seed! Something is wiggling inside.",
        WATERTREE_ROOT = "Giant twisty toes for the splashy-tree!",

        OCEANTREE_PILLAR = "We made our very own giant splashy-tree!",

        OCEANVINE = "Soggy green ropes for swinging! Wheee!",
        FIG = "A squishy purple sweet-snack!",
        FIG_COOKED = "The fire made the squishy-snack warm and yummy!",

        SPIDER_WATER = "Hey! How come the many-legs can walk on the splashy-water and I can't?",
        MUTATOR_WATER = "Ew, Webber! That looks like a smelly swamp-snack!",
        OCEANVINE_COCOON = "A fuzzy sleeping-bag hanging from the tree. Should I poke it?",
        OCEANVINE_COCOON_BURNT = "The sleeping-bag got all crispy-burnt.",

        GRASSGATOR = "A floating leafy-monster! Can I ride it?",

        TREEGROWTHSOLUTION = "Yucky swamp-juice to make the trees grow super fast!",

        FIGATONI = "Curly noodles with sweet purple-sauce! Yay!",
        FIGKABAB = "A sticky sweet-snack on a pointy stick!",
        KOALEFIG_TRUNK = "A squishy purple elephant-nose!",
        FROGNEWTON = "A yummy cookie with sweet purple-stuff inside!",

        -- The Terrorarium
        TERRARIUM = {
            GENERIC = "A spooky little tree trapped in a glass toy.",
            CRIMSON = "Ahhh! The glass toy is glowing with angry red bad-magic!",
            ENABLED = "The spooky toy is waiting for the night-sky!",
            WAITING_FOR_DARK = "It wants to play a scary game when the sun goes to sleep.",
            COOLDOWN = "The glass toy is taking a nap after all that scary magic.",
            SPAWN_DISABLED = "No more giant peepers coming out of the glass toy!",
        },

        -- Wolfgang
        MIGHTY_GYM =
        {
            GENERIC = "A big heavy jungle-gym for Mr. Strongman!",
            BURNT = "The heavy jungle-gym had a fiery tantrum.",
        },

        DUMBBELL = "A heavy stick with rocks on the ends!",
        DUMBBELL_GOLDEN = "Shiny gold lifty-toys! So heavy!",
        DUMBBELL_MARBLE = "Super heavy stone lifty-toys! I can't even pick one up!",
        DUMBBELL_GEM = "Pretty purple gems! But ouch, they're way too heavy for my star-paws!",
        POTATOSACK = "A super heavy bag of bumpy ground-snacks.",

        DUMBBELL_HEAT = "A toasty warm lifty-toy!",
        DUMBBELL_REDGEM = "A fiery hot gem-toy! It burns my paws!",
        DUMBBELL_BLUEGEM = "A freezing cold gem-toy! Brrr!",

        TERRARIUMCHEST =
        {
            GENERIC = "A spooky treasure box with a glowing red eye!",
            BURNT = "The spooky eye-box is all burnt up.",
            SHIMMER = "The box is wiggling with scary magic...",
        },

        EYEMASKHAT = "A squishy peeper-mask! I look like a scary monster now! Rawr!",

        EYEOFTERROR = "Ahhh! A giant flying peeper! Stop looking at me!",
        EYEOFTERROR_MINI = "A bunch of tiny bitey-peepers! Go away!",
        EYEOFTERROR_MINI_GROUNDED = "An egg with a peeper trying to hatch!",

        FROZENBANANADAIQUIRI = "A sweet yellow popsic-drink! Brain freeze!",
        BUNNYSTEW = "Warm soup made out of a bouncy-bunny.",
        MILKYWHITES = "Ew... squishy white peeper juice. Why does it smell so good?",

        CRITTER_EYEOFTERROR = "A tiny floaty peeper-pet! It's kind of cute when it doesn't bite.",

        SHIELDOFTERROR = "A giant biting mouth-shield! Snap snap!",
        TWINOFTERROR1 = "Oh no! Now there's TWO giant meanie-peepers!",
        TWINOFTERROR2 = "The shiny robot-peeper looks super dangerous!",

		-- Cult of the Lamb
        COTL_TRINKET = "A shiny red crown! Can I be the star-king now?",
        TURF_COTL_GOLD = "Shiny gold floor! Make sure to wipe your paws before stepping on it!",
        TURF_COTL_BRICK = "Red blocks to build a super fancy play-floor.",
        COTL_TABERNACLE_LEVEL1 =
        {
            LIT = "That glowing red eyes is spooky, but kind of pretty too.",
            GENERIC = "The spooky eyes went to sleep. It must be hungry.",
        },
        COTL_TABERNACLE_LEVEL2 =
        {
            LIT = "Look at that glowing statue! It's staring right at me.",
            GENERIC = "The statue's light went out. Time for a fuel-snack!",
        },
        COTL_TABERNACLE_LEVEL3 =
        {
            LIT = "Wow... the giant spooky-shrine is so bright it makes my brain feel wibbly-wobbly.",
            GENERIC = "The giant shrine is taking a nap in the dark.",
        },

        -- Year of the Catcoon
        CATTOY_MOUSE = "A squeaky-snack on wheels! Zoom zoom!",
        KITCOON_NAMETAG = "What should I name you? Star-fluff? Asteroid? Mr. Paws?",

        KITCOONDECOR1 =
        {
            GENERIC = "The fuzzy-kitties think it's a real flappy-bird! So silly.",
            BURNT = "Oh no, the flappy-bird toy is all crispy now!",
        },
        KITCOONDECOR2 =
        {
            GENERIC = "Look at them chase the little toys! Wait, what was I doing again?",
            BURNT = "Fire ruined the playtime!",
        },

        KITCOONDECOR1_KIT = "Pieces to build a flappy-toy for the fuzzy-kitties!",
        KITCOONDECOR2_KIT = "Let's put together a bouncy game for the kitties!",

        -- WX78
        WX78MODULE_MAXHEALTH = "A shiny beep-boop puzzle piece for Mr. Robot!",
        WX78MODULE_MAXSANITY1 = "A shiny beep-boop puzzle piece for Mr. Robot!",
        WX78MODULE_MAXSANITY = "A shiny beep-boop puzzle piece for Mr. Robot!",
        WX78MODULE_MOVESPEED = "A shiny beep-boop puzzle piece for Mr. Robot!",
        WX78MODULE_MOVESPEED2 = "A shiny beep-boop puzzle piece for Mr. Robot!",
        WX78MODULE_HEAT = "A shiny beep-boop puzzle piece for Mr. Robot!",
        WX78MODULE_NIGHTVISION = "A shiny beep-boop puzzle piece for Mr. Robot!",
        WX78MODULE_COLD = "A shiny beep-boop puzzle piece for Mr. Robot!",
        WX78MODULE_TASER = "A shiny beep-boop puzzle piece for Mr. Robot!",
        WX78MODULE_LIGHT = "A shiny beep-boop puzzle piece for Mr. Robot!",
        WX78MODULE_MAXHUNGER1 = "A shiny beep-boop puzzle piece for Mr. Robot!",
        WX78MODULE_MAXHUNGER = "A shiny beep-boop puzzle piece for Mr. Robot!",
        WX78MODULE_MUSIC = "A shiny beep-boop puzzle piece for Mr. Robot!",
        WX78MODULE_BEE = "A shiny beep-boop puzzle piece for Mr. Robot!",
        WX78MODULE_MAXHEALTH2 = "A shiny beep-boop puzzle piece for Mr. Robot!",

        WX78_SCANNER =
        {
            GENERIC = "Mr. Robot's flying eyeball pet!",
            HUNTING = "Go find some cool science, little eyeball!",
            SCANNING = "Ooh, the eyeball is learning things from staring!",
        },

        WX78_SCANNER_ITEM = "A sleeping eyeball-toy waiting to fly.",
        WX78_SCANNER_SUCCEEDED = "It looks so happy to share its robot secrets!",

        WX78_MODULEREMOVER = "A grabby-tool to pluck out the beep-boop pieces.",

        SCANDATA = "A shiny little card full of robot-thoughts!",

        -- QOL 2022
        JUSTEGGS = "Squishy yellow bird-drops! They need some sizzle.",
        VEGGIEOMLET = "A yummy yellow circle stuffed with green-snacks!",
        TALLEGGS = "A giant cooked egg! My tummy-nebula is rumbling already.",
        BEEFALOFEED = "Yuck! I'm leaving this smelly hay for the fuzzy monsters.",
        BEEFALOTREAT = "A crunchy treat for the big fluffy doggies!",

        -- Pirates
        BOAT_ROTATOR = "Spin the wheel! Now we're zooming the other way!",
        BOAT_ROTATOR_KIT = "A spinny-toy to turn the boat around.",
        BOAT_BUMPER_KELP = "Squishy green string-pads to keep the boat safe from bumps!",
        BOAT_BUMPER_KELP_KIT = "Let's make some squishy boat-pillows.",
        BOAT_BUMPER_SHELL = "Crunchy shell-pads for smashing into the big waves!",
        BOAT_BUMPER_SHELL_KIT = "Time to build crunchy boat-pillows.",
        BOAT_BUMPER_CRABKING = "Giant rock-claws! The ocean bullies better watch out now!",
        BOAT_BUMPER_CRABKING_KIT = "Toys to build big crab-shields for the boat.",

        BOAT_CANNON = {
            GENERIC = "A giant boom-shooter! It needs a heavy rock-snack.",
            AMMOLOADED = "Ready to make a giant splash! Boom!",
            NOAMMO = "It's resting its tummy before the next big boom.",
        },
        BOAT_CANNON_KIT = "Pieces for a giant boom-shooter.",
        CANNONBALL_ROCK_ITEM = "A heavy rock-ball for the boom-shooter!",

        OCEAN_TRAWLER = {
            GENERIC = "A giant net-toy for catching splashy-friends.",
            LOWERED = "Going down to the dark-bottom to find surprises!",
            CAUGHT = "Yay! It scooped up a water-treasure!",
            ESCAPED = "Aww, the splashy-friend wiggled out.",
            FIXED = "All patched up and ready to scoop again!",
        },
        OCEAN_TRAWLER_KIT = "Let's build a giant scoop-net.",

        BOAT_MAGNET =
        {
            GENERIC = "A magic puller-toy! Science is super neat.",
            ACTIVATED = "It's grabbing things with invisible star-magic!",
        },
        BOAT_MAGNET_KIT = "Toys to build a magic puller.",

        BOAT_MAGNET_BEACON =
        {
            GENERIC = "This shiny stick calls the magic puller over!",
            ACTIVATED = "Come here, boat! Zoom zoom!",
        },
        DOCK_KIT = "Puzzle pieces to make a wood-floor right on the water.",
        DOCK_WOODPOSTS_ITEM = "Little fences so I don't fall in the splashy-water.",

        MONKEYHUT =
        {
            GENERIC = "The meanie-monkeys live in a big leaf-fort!",
            BURNT = "The monkey-fort had a supernova!",
        },
        POWDER_MONKEY = "Keep your paws off my boat, you fuzzy thief!",
        PRIME_MATE = "That monkey thinks he's the captain! Unfair!",
        LIGHTCRAB = "A glowing snappy-friend! Like a tiny walking star.",
        CUTLESS = "A scratchy toy-sword for playing pirate.",
        CURSED_MONKEY_TOKEN = "A spooky gold coin. It makes my paws feel tingly.",
        OAR_MONKEY = "The monkeys use this stick to zoom super fast!",
        BANANABUSH = "A bush full of yellow smile-snacks!",
        DUG_BANANABUSH = "A sleepy smile-snack plant.",
        PALMCONETREE = "A tall tree with a giant pinecone head!",
        PALMCONE_SEED = "A heavy tree-egg.",
        PALMCONE_SAPLING = "A little baby cone-tree trying its best.",
        PALMCONE_SCALE = "A big crunchy piece of tree-armor.",
        MONKEYTAIL = "A fuzzy plant that wiggles like a tail!",
        DUG_MONKEYTAIL = "A fuzzy wibble-plant waiting for dirt.",

        MONKEY_MEDIUMHAT = "Arrr! I'm Captain Sunlion!",
        MONKEY_SMALLHAT = "A silly little cloth on my head.",
        POLLY_ROGERSHAT = "A funny hat to call the flappy pirate-bird.",
        POLLY_ROGERS = "A nice flappy-bird that fetches my toys!",

        MONKEYISLAND_PORTAL = "A giant water-door that spits out monkey junk.",
        MONKEYISLAND_PORTAL_DEBRIS = "Broken beep-boop parts in the splashy-water.",
        MONKEYQUEEN = "The giant boss-monkey! She looks very grumpy.",
        MONKEYPILLAR = "A super tall monkey-stick.",
        PIRATE_FLAG_POLE = "Arrr! We need to raise the pirate banner!",

        BLACKFLAG = "A scary bad-magic flag for playing pirate.",
        PIRATE_STASH = "A secret toy-box hidden in the dirt!",
        STASH_MAP = "A doodle-map to find hidden treasure!",

        BANANAJUICE = "Sweet yellow splash-juice! So yummy!",

        FENCE_ROTATOR = "A clicky-turner for the stick-fences.",

        CHARLIE_STAGE_POST = "A spooky wooden fort for pretending.",
        CHARLIE_LECTURN = "A reading-table for the scary lady's game.",

        CHARLIE_HECKLER = "Meanies yelling at the pretend-game!",

        PLAYBILL_THE_DOLL = "A doodle-paper about a creepy face-toy.",
        PLAYBILL_THE_VEIL = "A doodle-paper from the spooky shadow-birds.",
        PLAYBILL_THE_VAULT = "A doodle-paper with a big 'E' on it.",
        STATUEHARP_HEDGESPAWNER = "The headless rock-statue is growing green hair!",
        HEDGEHOUND = "Ahhh! A doggie made of meanie-leaves!",
        HEDGEHOUND_BUSH = "That bush smells exactly like a grumpy doggie.",

        MASK_DOLLHAT = "A creepy face-toy.",
        MASK_DOLLBROKENHAT = "The face-toy has a big crack.",
        MASK_DOLLREPAIREDHAT = "Patched up with star-glue, but still creepy.",
        MASK_BLACKSMITHHAT = "A heavy face-toy for a metal-smasher.",
        MASK_MIRRORHAT = "A shiny face! I can see my sparkly mane in it!",
        MASK_QUEENHAT = "A boss-lady mask.",
        MASK_KINGHAT = "A boss-man mask.",
        MASK_TREEHAT = "A wooden face for playing hide-and-seek in the forest.",
        MASK_FOOLHAT = "A silly jingle-face for making people laugh!",

        COSTUME_DOLL_BODY = "A fluffy dress for playing tea-party.",
        COSTUME_QUEEN_BODY = "Boss-lady dress-up clothes!",
        COSTUME_KING_BODY = "A heavy robe for playing boss-man.",
        COSTUME_BLACKSMITH_BODY = "A tough apron for building toys.",
        COSTUME_MIRROR_BODY = "A super shiny glass-suit!",
        COSTUME_TREE_BODY = "Scratchy clothes to pretend I'm a tree.",
        COSTUME_FOOL_BODY = "A silly jingle-suit!",

        STAGEUSHER =
        {
            STANDING = "Don't touch me, spooky shadow-man!",
            SITTING = "Why is the shadow-man just sitting there staring?",
        },
        SEWING_MANNEQUIN =
        {
            GENERIC = "A wooden friend holding the dress-up clothes.",
            BURNT = "The wooden friend got too close to a supernova.",
        },

        -- Waxwell
        MAGICIAN_CHEST = "Mr. Shadow-Man's magic toy-box. It feels wiggly inside.",
        TOPHAT_MAGICIAN = "A tall fancy-hat that swallows toys like a black hole!",

        -- Year of the Rabbit
        YOTR_FIGHTRING_KIT = "Toys to build a bouncy play-ring!",
        YOTR_FIGHTRING_BELL =
        {
            GENERIC = "A shiny bell. Does it mean playtime?",
            PLAYING = "Ding ding! Time for the big bouncy game!",
        },

        YOTR_DECOR_1 = {
            GENERAL = "Look at the glowing bunny-star!",
            OUT = "The bunny-star went to sleep.",
        },
        YOTR_DECOR_2 = {
            GENERAL = "A happy glowing bunny-star!",
            OUT = "The lights are out for the bunny.",
        },

        HAREBALL = "Ew! A giant furball from a bouncy-bunny!",
        YOTR_DECOR_1_ITEM = "I want to put this bunny-light in my room!",
        YOTR_DECOR_2_ITEM = "Another bunny-light for decorating!",

        --
        DREADSTONE = "Spooky black rocks. They eat all the starlight.",
        HORRORFUEL = "Super concentrated bad-magic! Keep it away!",
        DAYWALKER =
        {
            GENERIC = "The big scratched-up monster looks super grumpy!",
            IMPRISONED = "The monster is stuck! But I'm too scared to help.",
        },
        DAYWALKER_PILLAR =
        {
            GENERIC = "Shiny rock covering up something scary.",
            EXPOSED = "A super tough scary-rock stick.",
        },
        DAYWALKER2 =
        {
            GENERIC = "Shh, don't wake the grumpy monster.",
            BURIED = "He's hiding under a giant pile of heavy trash.",
            HOSTILE = "Ahhh! He's throwing a huge tantrum!",
        },
        ARMORDREADSTONE = "A dark star-suit made of scary rocks.",
        DREADSTONEHAT = "A spooky bucket for my head, but it fixes itself!",

        -- Rifts 1
        LUNARRIFT_PORTAL = "That shiny night-hole is full of night-sparks! I want to jump in!",
        LUNARRIFT_CRYSTAL = "Shiny glass made of solid nightlight!",

        LUNARTHRALL_PLANT = "Whoa! That big night-plant is trying to give me a thorny hug!",
        LUNARTHRALL_PLANT_VINE_END = "Pointy grabby-vines! Stay away from my paws!",

        LUNAR_GRAZER = "A glowing floaty-friend! Did you fall out of the sky-hole?",

        PUREBRILLIANCE = "Super-duper bright star-stuff! It's filled with magic!",
        LUNARPLANT_HUSK = "Scratchy night-leaves. Maybe I can build a toy out of them!",

        LUNAR_FORGE = "A magical glowing table for building night-spark toys!",
        LUNAR_FORGE_KIT = "Let's put together a glowing toy-station!",

        LUNARPLANT_KIT = "Little pieces for making scratchy leaf-clothes!",
        ARMOR_LUNARPLANT = "I'm a tough leafy star-knight now! You can't tag me!",
        LUNARPLANTHAT = "This leaf-crown makes my mane glow even brighter!",
        BOMB_LUNARPLANT = "A sparkly boom-toy! Throw it and run!",
        STAFF_LUNARPLANT = "Zap! A magic night-stick to play wizard!",
        SWORD_LUNARPLANT = "Swoosh! Swish! I can't stop making laser sounds when I swing it!",
        PICKAXE_LUNARPLANT = "A glowing smasher for breaking extra-hard rocks!",
        SHOVEL_LUNARPLANT = "I can dig the biggest dirt-holes ever with this sparkly scoop!",

        BROKEN_FORGEDITEM = "Oh no, my shiny toy broke! I need to fix it now!",

        PUNCHINGBAG = "A bouncy hit-toy! Take that, invisible bully! Pow! Bam!",

        -- Rifts 2
        SHADOWRIFT_PORTAL = "It's like the evil surface thing!",

		SHADOW_FORGE = "I dont want to make toys here...",
		SHADOW_FORGE_KIT = "The bad thing is portable! That's not good!",

        FUSED_SHADELING = "I liked you better when you were smaller, and bothering someone else.",
        FUSED_SHADELING_BOMB = "Bombastic!",

		VOIDCLOTH = "Those shadows are all cut from the same cloth.",
		VOIDCLOTH_KIT = "I hope I'll never have to use this scary thing!",
		VOIDCLOTHHAT = "It's scary and I don't like it!",
		ARMOR_VOIDCLOTH = "I don't like this one, it's too scary!",

        VOIDCLOTH_UMBRELLA = "I always hate when my hair gets melted by acid.",
        VOIDCLOTH_SCYTHE = "It might be useful but I still don't like it!",

		SHADOWTHRALL_HANDS = "Hands off!",
		SHADOWTHRALL_HORNS = "It looks hungry for a fight.",
		SHADOWTHRALL_WINGS = "The wings seem to be just for show.",
		SHADOWTHRALL_MOUTH = "It's a mouthy one.",

        CHARLIE_NPC = "Wait, is that...?",
        CHARLIE_HAND = "It wants something dreadful.",

        NITRE_FORMATION = "It's definitely some kind of rock.",
        DREADSTONE_STACK = "It's coming from deep down in those chasms...",
        
        SCRAPBOOK_PAGE = "Someone else out there likes to scrapbook.",

        LEIF_IDOL = "Carving a tree out of wood seems a bit redundant.",
        WOODCARVEDHAT = "It looks like it's been lovingly carved.",
        WALKING_STICK = "It's a very nice stick.",

        IPECACSYRUP = "I don't think I want to eat this.",
        BOMB_LUNARPLANT_WORMWOOD = "Our friend seems to be getting more in touch with his lunar roots.", -- Unused
        WORMWOOD_MUTANTPROXY_CARRAT =
        {
        	DEAD = "That's the end of that.",
        	GENERIC = "Are carrots supposed to have legs?",
        	HELD = "You're kind of ugly up close.",
        	SLEEPING = "It's almost cute.",
        },
        WORMWOOD_MUTANTPROXY_LIGHTFLIER = "How strange, carrying one makes my pocket feel lighter!",
		WORMWOOD_MUTANTPROXY_FRUITDRAGON =
		{
			GENERIC = "It's cute, but it's not ripe yet.",
			RIPE = "I think it's ripe now.",
			SLEEPING = "It's snoozing.",
		},

        SUPPORT_PILLAR_SCAFFOLD = "It's all under wraps for now.",
        SUPPORT_PILLAR = "I should really get around to fixing that.",
        SUPPORT_PILLAR_COMPLETE = "It fills me with confidence.",
        SUPPORT_PILLAR_BROKEN = "You were once tall and strong.",

		SUPPORT_PILLAR_DREADSTONE_SCAFFOLD = "It's all under wraps for now.",
		SUPPORT_PILLAR_DREADSTONE = "I should really get around to fixing that.",
		SUPPORT_PILLAR_DREADSTONE_COMPLETE = "That looks dreadfully strong.",
		SUPPORT_PILLAR_DREADSTONE_BROKEN = "How dreadful.",

        WOLFGANG_WHISTLE = "It gives me terrible flashbacks to the gym classes of my youth...",

        -- Rifts 3

        MUTATEDDEERCLOPS = "It's got a little something in its eye.",
        MUTATEDWARG = "What big, glowing eyes you have!",
        MUTATEDBEARGER = "Things are about to get hairy...",

        LUNARFROG = "Quit staring.",

        DEERCLOPSCORPSE =
        {
            GENERIC  = "It's over... right?",
            BURNING  = "Can't be too careful.",
            REVIVING = "I don't want to believe what my eyes are seeing!",
        },

        WARGCORPSE =
        {
            GENERIC  = "Why do I still feel uneasy?",
            BURNING  = "It's for the best.",
            REVIVING = "What in the name of science?!",
        },

        BEARGERCORPSE =
        {
            GENERIC  = "What an unbearable stench!",
            BURNING  = "That was close.",
            REVIVING = "There must be a scientific explanation for this!",
        },

        BEARGERFUR_SACK = "There's still fur on it. Chilling.",
        HOUNDSTOOTH_BLOWPIPE = "Teeth? Doesn't seem all that hygenic.",
        DEERCLOPSEYEBALL_SENTRYWARD =
        {
            GENERIC = "How's that for an icy gaze?",    -- Enabled.
            NOEYEBALL = "Someone lose an eye?",  -- Disabled.
        },
        DEERCLOPSEYEBALL_SENTRYWARD_KIT = "Stand back everyone, I am a trained scientist!",

        SECURITY_PULSE_CAGE = "Interesting. It's empty.",
        SECURITY_PULSE_CAGE_FULL = "Aren't you the cutest little ball of pure energy?",

		CARPENTRY_STATION =
        {
            GENERIC = "It makes furniture.",
            BURNT = "It doesn't make furniture anymore.",
        },

        WOOD_TABLE = -- Shared between the round and square tables.
        {
            GENERIC = "I use tables periodically.",
            HAS_ITEM = "I use tables periodically.",
            BURNT = "I don't think I'll be using it anymore.",
        },

        WOOD_CHAIR =
        {
            GENERIC = "I'd like to sit on that!",
            OCCUPIED = "Somebody else is sitting on that.",
            BURNT = "I wouldn't like to sit on that.",
        },

        DECOR_CENTERPIECE = "How sophisticated.",
        DECOR_LAMP = "A welcoming light.",
        DECOR_FLOWERVASE =
        {
            GENERIC = "A nice vase of flowers.",
            EMPTY = "A nice vase without any flowers.",
            WILTED = "Not looking very fresh.",
            FRESHLIGHT = "It's nice to have a little light.",
            OLDLIGHT = "I know I told Maxwell to replace the bulb.",
        },
        DECOR_PICTUREFRAME =
        {
            GENERIC = "It's beautiful.",
            UNDRAWN = "I should draw something in this.",
        },
        DECOR_PORTRAITFRAME = "Looking good!",

        PHONOGRAPH = "Oh no, I've seen THAT before.",
        RECORD = "Drat, I just got that song out of my head!",
        RECORD_CREEPYFOREST = "A whole song on one record? Technology has come so far.",
        RECORD_DANGER = "Not my favorite.", -- Unused.
        RECORD_DAWN = "Needs more trumpet.", -- Unused.
        RECORD_DRSTYLE = "A whole song on one record? Technology has come so far.",
        RECORD_DUSK = "Needs more trumpet.", -- Unused.
        RECORD_EFS = "One of their more experimental tracks.",
        RECORD_END = "A whole song on one record? Technology has come so far.", -- Unused.
        RECORD_MAIN = "Needs more trumpet.", -- Unused.
        RECORD_WORKTOBEDONE = "One of their more experimental tracks.", -- Unused.
        RECORD_HALLOWEDNIGHTS = "Spooktacular!",
        RECORD_BALATRO = "Irresistible! It's like it touches my mind!",

        ARCHIVE_ORCHESTRINA_MAIN = "It's like they made it puzzling on purpose.",

        WAGPUNKHAT = "It really gets my gears turning.",
        ARMORWAGPUNK = "Fearsome and gearsome.",
        WAGSTAFF_MACHINERY = "There might be some discoveries to be made in this pile of junk.",
        WAGPUNK_BITS = "I bet I could make something incredibly scientific with this.",
        WAGPUNKBITS_KIT = "Machines that fix other machines! What will science think of next?",

        WAGSTAFF_MUTATIONS_NOTE = "Fascinating! Illuminating! Brain-embiggening!",

        -- Meta 3

        BATTLESONG_INSTANT_REVIVE = "It's a very lively tune.",

        WATHGRITHR_IMPROVEDHAT = "Does Wigfrid have any leadership experience? Or is she just winging it?",
        SPEAR_WATHGRITHR_LIGHTNING = "It's amplified with electricity.",

        BATTLESONG_CONTAINER = "Wow, it stores so many songs.",

        SADDLE_WATHGRITHR = "Wigfrid made that? Looks like she winged it.",

        WATHGRITHR_SHIELD = "Protect me!!",

        BATTLESONG_SHADOWALIGNED = "Theater makes me fidgety.",
        BATTLESONG_LUNARALIGNED = "Theater makes me fidgety.",

		SHARKBOI = "Shiver me timbers!",
        BOOTLEG = "Somewhere out there, a pirate is missing their bootie.",
        OCEANWHIRLPORTAL = "I'll give it a whirl.",

        EMBERLIGHT = "A fire without fuel? No matter.",
        WILLOW_EMBER = "only_used_by_willow",

        -- Year of the Dragon
        YOTD_DRAGONSHRINE =
        {
            GENERIC = "I'm burning with curiosity to see what's on offer.",
            EMPTY = "It might like a piece of charcoal.",
            BURNT = "Things got a little heated.",
        },

        DRAGONBOAT_KIT = "I'd better stop dragon my feet and build it.",
        DRAGONBOAT_PACK = "Boat building made easy!",

        BOATRACE_CHECKPOINT = "There's the checkpoint!",
        BOATRACE_CHECKPOINT_THROWABLE_DEPLOYKIT = "One more thing to check off my list.",
        BOATRACE_START = "You have to start somewhere.",
        BOATRACE_START_THROWABLE_DEPLOYKIT = "Where to start?",

        BOATRACE_PRIMEMATE = "Someone's shadowing me!",
        BOATRACE_SPECTATOR_DRAGONLING = "Its support is getting me all fired up!",

        YOTD_STEERINGWHEEL = "That'll steer me in the right direction. And the left direction.",
        YOTD_STEERINGWHEEL_ITEM = "That's going to be the steering wheel.",
        YOTD_OAR = "It's a really handy paddle.",
        YOTD_ANCHOR = "I wouldn't want my boat to fly away.",
        YOTD_ANCHOR_ITEM = "Now I can build an anchor.",
        MAST_YOTD = "That's one scaly sail.",
        MAST_YOTD_ITEM = "Now I can build a mast.",
        BOAT_BUMPER_YOTD = "When you mess with a dragon boat, you get the horns!",
        BOAT_BUMPER_YOTD_KIT = "A soon-to-be boat bumper.",
        BOATRACE_SEASTACK = "Buoy oh buoy!",
        BOATRACE_SEASTACK_THROWABLE_DEPLOYKIT = "Buoy oh buoy!",
        BOATRACE_SEASTACK_MONKEY = "Buoy oh buoy!",
        BOATRACE_SEASTACK_MONKEY_THROWABLE_DEPLOYKIT = "Buoy oh buoy!",
        MASTUPGRADE_LAMP_YOTD = "Aww, just look how its eyes light up when it sees me!",
        MASTUPGRADE_LAMP_ITEM_YOTD = "I'm full of bright ideas.",
        WALKINGPLANK_YOTD = "Dressing it up doesn't make me feel better about using it.",
        CHESSPIECE_YOTD = "Just the sight of it gets my heart racing!",

        -- Rifts / Meta QoL

        HEALINGSALVE_ACID = "This will salve a number of problems.",

        BEESWAX_SPRAY = "Is that formaldehyde I smell?",
        WAXED_PLANT = "It's frozen in fear!", -- Used for all waxed plants, from farm plants to trees.

        STORAGE_ROBOT = {
            GENERIC = "Let's not get carried away.",
            BROKEN = "It's broken.",
        },

        SCRAP_MONOCLEHAT = "Does it make me look more distinguished?",
        SCRAPHAT = "The tip of that hat is almost as sharp as... my mind!",

        FENCE_JUNK = "Tell me it's ugly, I won't take a fence.",
        JUNK_PILE = "A good junk pile rummage? I'll never refuse.",
        JUNK_PILE_BIG = {
            BLUEPRINT = "There's something up there.",
            GENERIC = "I think it could fall over any moment.",
        },
        
        ARMOR_LUNARPLANT_HUSK = "That'll put a thorn in your side.",

        -- Meta 4 / Ocean QoL

        OTTER = "You should see the otter guy.",
        OTTERDEN = {
            GENERIC = "Otter den that, there's not much else there.",
            HAS_LOOT = "I otter have a closer look.",
        },
        OTTERDEN_DEAD = "We are taking on a l'otter water.",

        BOAT_ANCIENT_ITEM = "I guess I'm doing this the old-fashioned way.",
        BOAT_ANCIENT_CONTAINER = "\"Cargo\" is sailor-lingo for \"stuff\".",
        WALKINGPLANK_ANCIENT = "Couldn't we have just made a lifeboat?",

        ANCIENTTREE_SEED = "There are no surprises, only incomplete data.",

        ANCIENTTREE_GEM = {
            GENERIC = "It's vegetable AND mineral. Fascinating.",
            STUMP = "This tree has been mined.",
        },

        ANCIENTTREE_SAPLING_ITEM = "I need to plant this in the right place.",

        ANCIENTTREE_SAPLING = {
            GENERIC = "It's growing! I think?",
            WRONG_TILE = "I don't think it's getting the required nutrients here.",
            WRONG_SEASON = "It seems like it fits in, but it's not yet ready to grow.",
        },
 
        ANCIENTTREE_NIGHTVISION = {
            GENERIC = "Tree-t with caution.",
            STUMP = "It's a stump.",
        },

        ANCIENTFRUIT_GEM = "Hot and fresh! My tummy-nebula is ready for this shiny rock-snack.",
        ANCIENTFRUIT_NIGHTVISION = "Eek! Why is the fruit wiggling? Stop staring at me!",
        ANCIENTFRUIT_NIGHTVISION_COOKED = "The fire fixed it! No more creepy wiggles.",

        BOATPATCH_KELP = "This soggy green band-aid will keep the boat from drinking the ocean!",

        CRABKING_MOB = "Watch out! The giant snappy-crab is super grumpy today.",
        CRABKING_MOB_KNIGHT = "Hey! Putting on a rock-suit is cheating, Mr. Snappy-Crab!",
        CRABKING_CANNONTOWER = "Those snappy-crabs are playing rough with that big throwing-toy!",
        CRABKING_ICEWALL = "Brrr! It's a freezing popsic-wall blocking the way!",

        SALTLICK_IMPROVED = "So much salty-dust! It makes my tongue feel dry just looking at it.",

        OFFERING_POT =
        {
            GENERIC = "The fishy-frogs left their mud-pot completely empty.",
            SOME_KELP = "We can totally fit more soggy strings in there.",
            LOTS_OF_KELP = "Look at all those green string-snacks! The fishy-frogs must be super hungry.",
        },

        OFFERING_POT_UPGRADED =
        {
            GENERIC = "Even fancy mud-pots need snacks inside!",
            SOME_KELP = "Let's stuff more soggy water-strings inside!",
            LOTS_OF_KELP = "Whoa, it's overflowing with fishy-frog treats!",
        },

        MERM_ARMORY = "The fishy-frogs hide all their pointy-toys in this mud-house.",
        MERM_ARMORY_UPGRADED = "Wow, they upgraded the mud-house for their pointy-toys!",
        MERM_TOOLSHED = "I wouldn't want to play with the messy sticks in there.",
        MERM_TOOLSHED_UPGRADED = "Now it's an even bigger house for their messy sticks!",
        MERMARMORHAT = "Yuck! That mud-helmet is not going anywhere near my sparkly mane.",
        MERMARMORUPGRADEDHAT = "Harder mud doesn't make it any less stinky. No thanks!",
        MERM_TOOL = "That wobbly stick doesn't look like a safe toy to play with.",
        MERM_TOOL_UPGRADED = "Swamp-girl made the wobbly stick shiny!",

        WURT_SWAMPITEM_SHADOW = "Swamp-girl's bad-magic toy is giving me the wibbly-wobblies...",
        WURT_SWAMPITEM_LUNAR = "My eyes! Swamp-girl's night-spark toy is super bright.",

        MERM_SHADOW = "Oh no! The bad-magic got inside the fishy-frog!",
        MERMGUARD_SHADOW = "Keep away from the bad-magic fishy-guard! He may be a meanie!",

        MERM_LUNAR = "Look! The fishy-frog is glowing with night-sparks!",
        MERMGUARD_LUNAR = "The shiny night-guard looks ready to pounce!",

        -- Rifts 4

        SHADOW_BEEF_BELL = "A spooky jingle-toy. I don't want to ring it.",
        SADDLE_SHADOW = "A bad-magic seat for the fuzzy monster. Yuck!",
        SHADOW_BATTLEAXE = "A scary shadow-chopper!",
        VOIDCLOTH_BOOMERANG = "If I throw it, will the bad-magic come back to me?!",
        ROPE_BRIDGE_KIT = "A bouncy string-path to walk on the water!",
        GELBLOB =
        {
            GENERIC = "Ew! Sticky floor-goop!",
            HAS_ITEM = "My toy is stuck in the sticky-goop!",
            HAS_CHARACTER = "Oh no! A friend is trapped in the goop!",
        },
        RABBITKING_AGGRESSIVE = "The big bunny is throwing a giant tantrum!",
        RABBITKING_PASSIVE = "A giant fluffy hopper! Can I pet him?",
        RABBITKING_LUCKY = "This hopper has special star-magic!",
        RABBITKINGMINION_BUNNYMAN = "The big bunnies are super grumpy!",
        ARMOR_CARROTLURE = "A shirt made of pointy-snacks to trick the hoppers.",
        RABBITKINGHORN = "A bouncy-tooter! Toot toot!",
        RABBITKINGHORN_CHEST = "A magic box that listens to the bouncy-tooter!",
        RABBITKINGSPEAR = "A pointy stick with bunny-magic!",
        RABBITHAT = "A floppy-ear hat! Now I'm a hop-lion!",
        WORM_BOSS = "Ahhh! A giant wiggly dirt-monster!",

        STONE_TABLE = -- Shared between the round and square tables.
        {
            GENERIC = "A heavy rock-table for drawing star-maps.",
            HAS_ITEM = "The rock-table is holding my toys.",
        },

        STONE_CHAIR =
        {
            GENERIC = "A hard rock-seat. It needs a fluffy cushion.",
            OCCUPIED = "Someone else is resting their paws.",
        },

        CARPENTRY_BLADE_MOONGLASS = "A super-sharp shiny night-glass! Don't cut my paws!",

        CHEST_MIMIC_REVEALED = "Ahhh! The toy-box is a biting monster!",

        GELBLOB_STORAGE = {
            GENERIC  = "An empty sticky-goop jar.",
            FULL = "The goop is holding my snacks hostage!",
        },
        GELBLOB_STORAGE_KIT = "A toy to make a sticky-jar.",
        GELBLOB_BOTTLE = "A little bottle of yucky goop.",

        PLAYER_HOSTED =
        {
            GENERIC = "They're busy playing a different game.",
            ME = "Wait, is that me? Am I in two places at once?",
        },

        MASK_SAGEHAT = "A smarty-pants mask!",
        MASK_HALFWITHAT = "A silly-pants mask!",
        MASK_TOADYHAT = "A grumpy frog-mask!",

        SHADOWTHRALL_PARASITE = "Ew! A bad-magic brain-bug! Get it away!",

        PUMPKINCARVER = "A tiny toy for making spooky faces on the gourds!",
        SNOWMAN =
        {
            GENERIC = "A cold frosty-friend! I want to give him a star-hug, but he might melt.",
            SNOWBALL = "A giant snowball waiting to be a frosty-friend!",
        },
        SNOWBALL_ITEM = "A freezing throw-toy! Incoming!",

        -- Year of the Snake
        YOTS_SNAKESHRINE =
        {
            GENERIC = "A slithery-friend statue! Is it time to play?",
            EMPTY = "The slithery-statue is hungry for a shiny snack.",
            BURNT = "The slithery-friend had a supernova.",
        },
        YOTS_WORM = "A little dirt-noodle!",
        YOTS_LANTERN_POST = 
        {
            GENERIC = "A pretty tall-light.",
            BURNT = "The tall-light went out forever.",
        },
        YOTS_LANTERN_POST_ITEM = "A tall-light toy waiting to be built.",
        CHESSPIECE_DEPTHWORM  = "A heavy rock dirt-noodle!",

        -- Meta 5
        GHOSTLYELIXIR_LUNAR = "A magic potion full of night-sparks!",
        GHOSTLYELIXIR_SHADOW = "Ew, a potion made of bad-magic.",

        SLINGSHOTMODKIT = "Toys for upgrading the zoomy-shooter!",
        SLINGSHOT_BAND_PIGSKIN = "A stretchy piggy-band for the zoomy-shooter.",
        SLINGSHOT_BAND_TENTACLE = "A slimy purple band. Gross, but stretchy!",
        SLINGSHOT_BAND_MIMIC = "A monster-mouth band! Careful with your paws!",
        SLINGSHOT_FRAME_BONE = "A spooky bone-handle.",
        SLINGSHOT_FRAME_GEMS = "A sparkly gem-handle! My favorite!",
        SLINGSHOT_FRAME_WAGPUNK_0 = "A metal beep-boop handle.",
        SLINGSHOT_FRAME_WAGPUNK = "An even cooler beep-boop handle!",
        SLINGSHOT_HANDLE_STICKY = "A goopy handle. Now my paws are sticky!",
        SLINGSHOT_HANDLE_JELLY = "A squishy zap-jelly handle!",
        SLINGSHOT_HANDLE_SILK = "A soft bug-string handle.",
        SLINGSHOT_HANDLE_VOIDCLOTH = "A bad-magic handle. I don't want to touch it.",

        WOBY_TREAT = "A yummy snack for Walter's big doggie!",
        BANDAGE_BUTTERFLYWINGS = "A soft flappy-petal to heal my boo-boos.",
        PORTABLEFIREPIT_ITEM = "A little land-star I can carry in my pocket!",
        SLINGSHOTAMMO_CONTAINER = "A box for all the zoomy-rocks!",

        ELIXIR_CONTAINER = "A spooky bag for ghost-potions.",
        GHOSTFLOWERHAT = "A flower crown that smells like cold ghost-hugs.",
        WENDY_RESURRECTIONGRAVE = "A spooky dirt-bed to bring back friends!",
        GRAVEURN =
        {
            GENERIC = "An empty spooky pot.",
            HAS_SPIRIT = "There's a happy little spark hiding inside!",
        },

        SHALLOW_GRAVE = "Someone left a spooky dirt-bump.",
        THULECITEBUGNET = "A super-magic swooshy net for catching sky-friends!",

        -- Deck of Cards
        DECK_OF_CARDS = "A stack of doodle-papers for a fun game!",
        PLAYING_CARD = "Just one doodle-paper. I can't play with only one!",
        BALATRO_MACHINE = "A magic beep-boop box for playing card games!",

        -- Rifts 5
        GESTALT_CAGE =
        {
            GENERIC = "An empty star-trap.",
            FILLED = "There's a night-spark trapped inside!",
        },
        WAGBOSS_ROBOT_SECRET = "Ooh, a secret beep-boop toy!",
        WAGBOSS_ROBOT = "A giant metal friend!",
        WAGBOSS_ROBOT_POSSESSED = "Oh no! The bad-magic got inside the metal friend!",
        WAGBOSS_ROBOT_LEG = "A giant stompy metal foot!",
        ALTERGUARDIAN_PHASE1_LUNARRIFT = "You're a meanie night-boss, but you look different!",
        ALTERGUARDIAN_PHASE1_LUNARRIFT_GESTALT = "The floaty night-ghost wants this one.",
        ALTERGUARDIAN_PHASE4_LUNARRIFT = "Stop throwing a tantrum, big meanie!",
        WAGDRONE_ROLLING =
        {
            GENERIC = "A little rolling beep-boop.",
            INACTIVE = "The roller-toy went to sleep.",
            DAMAGED = "The roller-toy has a big boo-boo.",
            FRIENDLY = "A friendly rolling beep-boop!",
        },
        WAGDRONE_FLYING =
        {
            GENERIC = "A little flappy beep-boop.",
            INACTIVE = "The flappy-toy is napping.",
            DAMAGED = "The flappy-toy fell down and broke.",
        },
        WAGDRONE_PARTS = "Broken bits of a beep-boop toy.",
        WAGDRONE_BEACON = "A shiny stick that talks to the beep-boops.",

        WAGPUNK_WORKSTATION = "A messy desk for making science toys!",
        WAGPUNK_LEVER = "A big clicky handle! Can I pull it?",
        WAGPUNK_FLOOR_KIT = "Metal floor puzzles!",
        WAGPUNK_CAGEWALL = "A metal fence to keep things inside.",

        WAGSTAFF_ITEM_1 = "A fuzzy-looking glove, but it's not a ghost!",
        WAGSTAFF_ITEM_2 = "A solid doodle-board.",

        HERMITCRAB_RELOCATION_KIT = "A moving box for the crab-lady.",

        WANDERINGTRADER =
        {
            REVEALED = "Do you have new toys to show me?",
            GENERIC = "The fuzzy monster has a funny blanket on.",
        },

        GESTALT_GUARD_EVOLVED = "The night-ghosts are super angry now!",
        FLOTATIONCUSHION = "A squishy floaty-pad!",
        LUNAR_SEED = "A tiny night-spark seed.",

        -- rifts5.1
        WAGBOSS_ROBOT_CONSTRUCTIONSITE = "The giant metal friend is hiding under a blanket.",
        WAGBOSS_ROBOT_CONSTRUCTIONSITE_KIT = "A magic box to build a giant metal friend!",
        WAGBOSS_ROBOT_CREATION_PARTS = "A pile of giant robot puzzle pieces.",
        MOONSTORM_STATIC_CATCHER = "A jar waiting for a sky-spark.",
        COOLANT = "Frosty blue bubble-juice!",

        FENCE_ELECTRIC = {
            LINKED = "The stick-fence is full of tingly sky-sparks!",      --NOTE: the fence post is fully linked to two other posts
            GENERIC = "Just a metal stick. Needs more spark.",           --NOTE: no links or electricity, just boring ol fence post
        },
        FENCE_ELECTRIC_ITEM = "A metal stick waiting to go in the dirt.",

        MUTATEDBIRD = "A flap-flap birdie with spooky night-magic.",

        BIRDCORPSE =
        {
            GENERIC  = "The little birdie lost its spark.", --witnessing the corpse
            BURNING  = "A tiny birdie supernova.", --when its burning
            REVIVING = "Eek! The night-magic is waking the birdie up wrong!", --when its mutating and being revived
        },

        BUZZARDCORPSE = {
            GENERIC  = "The grumpy bald birdie is sleeping forever.", --witnessing the corpse
            BURNING  = "A big birdie supernova.", --when its burning
            REVIVING = "Ahhh! The dead birdie is moving again!", --when its mutating and being revived
        },

        MUTATEDBUZZARD_GESTALT = {
            GENERIC = "A floaty night-ghost inside a birdie.", -- Generic string
            EATING_CORPSE = "Ew! It's munching on a gross snack!", -- Eating from a fresh corpse (might be from the players kill or another creatures kill)
        },

        -- Rifts 6

        SHADOWTHRALL_CENTIPEDE = {
            HEAD = "A bad-magic bitey-head!", --The head segment
            BODY = "A wiggly bad-magic tummy!", --The body segment
            FLIPPED = "The shadow-bug is doing a tumble!", --When it's flipped over (either head or body segment)
        },

        TREE_ROCK =
        {
            BURNING = "The rock-tree is having a fire tantrum!", --It's vines are burning, it will collapse
            CHOPPED = "Timber! The heavy rock fell down!", --It's 'chopped', so the rock fell
            GENERIC = "A big rock wearing a leafy necklace.", --Rock is still on tree
        },

        -- NOTE: Unsure about HOT and COLD, just do GENERIC, GAS, MIASMA for now!
        CAVE_VENT_ROCK =
        {
            GENERIC = "A little chimney in the ground.", -- Not ventilating anything
            HOT     = "It's blowing warm air like a tummy-rumble!", -- Ventiliating hot air, making the area warm
            GAS     = "Pee-yew! The ground is doing a stinky burp!", -- Ventiliating Toadstools gas fumes and spores
            MIASMA  = "Oh no, bad-magic smoke is coming out!", -- Ventiliating the shadow rift miasma
        },
        CAVE_FERN_WITHERED = "The little leaf-friend is all crispy and sad.",
        FLOWER_CAVE_WITHERED = "The light-bulb plant lost its spark.",

        ABYSSPILLAR_MINION =
        {
            GENERIC = "Just a spooky rock-statue taking a nap.", --off, looks like decor/statue
            ACTIVATED = "Ahhh! The rock-statue woke up!", --turned on and hopping over puzzle pillars
        },
        ABYSSPILLAR_TRIAL = "A spooky puzzle stick.",

        VAULT_TELEPORTER =
        {
            GENERIC = "A magic space-door!",
            BROKEN = "The space-door has a big boo-boo.",
            UNPOWERED = "The space-door needs a sparky-recharge.",
        },
        VAULT_TELEPORTER_UNDERCONSTRUCTION = "\"The science isn't done yet!\"",
        VAULT_ORB = "A heavy rolling toy.",
        VAULT_LOBBY_EXIT = "A portal back to the safe playground!",
        VAULT_CHANDELIER_BROKEN = "The big ceiling-star is broken.",

        ANCIENT_HUSK = "Spooky old metal-bones.",
        MASK_ANCIENT_HANDMAIDHAT = "A dusty old mask.",
        MASK_ANCIENT_ARCHITECTHAT = "A silly old stone face.",
        MASK_ANCIENT_MASONHAT = "A very heavy stone mask.",

        TREE_ROCK_SEED = "A tiny rock-seed.",
        TREE_ROCK_SAPLING = "A baby rock-tree!",

        -- Rifts 6.1
        OCEANWHIRLBIGPORTALEXIT = "Look at all the splashy water-trash!", -- The flotsam pickable not the waterfall.

        VAULT_TORCH =
        {
            GENERIC = "A clicky-switch for a light!",
            BROKEN = "The clicky-switch is stuck!", --the torch still functions, just the lever is broken
        },

        CAVE_VENT_MITE =
        {
            DEAD = "The gas-bug went poof.",
            GENERIC = "A bug that breathes yucky gas.",
            SLEEPING = "Shh, the gas-bug is taking a nap.",
            VENTING = "It's blowing an angry smoke-cloud!", -- in the shield state and venting out gasses
        },

        --Hallowed Nights 2025

        PUMPKINHAT =
        {
            GENERIC = "A big orange wobble-gourd with a spooky face! Rawr!",
            UNCARVED = "It needs a spooky face first! Otherwise it's just a heavy hat.",--can't wear it unless it's carved.
        },

        PENGUINCORPSE =
        {
            GENERIC  = "The slidey-bird went to sleep forever. Poor thing.", --witnessing the corpse
            BURNING  = "A crispy slidey-bird supernova!", --when its burning
            REVIVING = "Eek! The slidey-bird is waking up with scary shadow-magic!", --when its mutating and being revived
        },
        SPIDERCORPSE =
        {
            GENERIC = "Ew! The many-legs lost its spark, but it's still gross.",
            BURNING = "Yay! Fire makes the gross things go away!",
            REVIVING = "Ahhh! The bad-magic is putting the many-legs back together!",
        },
        SPIDERQUEENCORPSE =
        {
            GENERIC = "The giant spiky-queen is extra super gross now.",
            BURNING = "A giant bug bonfire! Way less scary.",
            REVIVING = "No no no! The giant meanie is waking up with bad-magic!",
        },
        MERMCORPSE =
        {
            GENERIC = "The fishy-frog is taking a forever-nap. And it smells bad.",
            BURNING = "Pee-yew! Cooking stinky fishy-frogs is a bad experiment!",
            REVIVING = "Uh oh... the swamp-magic is making the fishy-frog stand up!",
        },
        GENERIC_CORPSE = -- A generic set of lines for ANY corpse, until they get their own unique lines at least.
        {
            GENERIC = "It lost all its inner spark. So sad.",
            BURNING = "Returning to stardust! Sizzly, crispy stardust.",
            REVIVING = "Eek! The bad-magic is putting the spark back in the wrong way!",
        },

		--Winter's Feast 2025

        HERMITHOTSPRING  =
        {
            BOMBED = "A warm, fizzy bubble bath for a little star-cub! Yay!",
            GENERIC = "I want to splash and play in the warm water!",
            EMPTY = "Aww, the warm puddle went away.",
        },
        HERMITHOTSPRING_CONSTR = "It's a work-in-progress play-puddle!",
        MEATRACK_HERMIT_MULTI = --talk to vito; want to reuse MEATRACK, but less meat focused; more fish/tea
        {
            DONE = "Chewy-snack time! Yay!",
            DRYING = "The snack is taking a long sun-nap.",
            DRYINGINRAIN = "Sky-juice makes the snack-nap take forever!",
            GENERIC =  "A hanging-toy for making chewy treats.",
            BURNT = "Oh no, my snack-hanger had a supernova!",
            DONE_NOTMEAT = "It's all crispy and ready to munch!",
            DRYING_NOTMEAT = "Drying out leaves is serious star-business.",
            DRYINGINRAIN_NOTMEAT = "Go away, sky-juice! My snacks are getting soggy!",
            DONE_SALT = "Salty star-dust! Yum!",
            ABANDONED = "It went to sleep and forgot to finish.",
        },
        HERMITHOUSE_ORNAMENT = "Jingle-jangle wind toys!",
        HERMITHOUSE_LAUNDRY = "Somebody's clothes are taking a breeze-nap.",

        PETALS_DRIED = "Crunchy ground-star petals!",
        PETALS_EVIL_DRIED = "Crispy shadow-petals. Still spooky.",
        FOLIAGE_DRIED = "Crunchy green leaves!",
        SUCCULENT_PICKED_DRIED = "Crispy prickly-plant.",
        FIRENETTLES_DRIED = "Crunchy ouchie-leaves!",
        TILLWEED_DRIED = "Crispy meanie-weed.",
        MOON_TREE_BLOSSOM_DRIED = "Crunchy night-blossom!",
        FORGETMELOTS_DRIED = "Crispy little blue-stars!",

        HERMITCRABTEA_PETALS = "Sweet flower-water! It warms my tummy-nebula.",
        HERMITCRABTEA_PETALS_EVIL = "Spooky shadow-water. It makes my head wiggle.",
        HERMITCRABTEA_FOLIAGE = "Leafy-water. It tastes like a forest nap.",
        HERMITCRABTEA_SUCCULENT_PICKED = "Prickly-water, but without the pokes!",
        HERMITCRABTEA_FIRENETTLES = "Spicy hot-water! My tongue is doing a supernova!",
        HERMITCRABTEA_TILLWEED = "Healing-water to fix my boo-boos.",
        HERMITCRABTEA_MOON_TREE_BLOSSOM = "Night-blossom water! It tastes like starlight.",
        HERMITCRABTEA_FORGETMELOTS = "Happy blue-water! No more scary shadows in my head.",
        SHELLWEAVER = "A magical toy-maker for the snappy-shells!",
        ICESTAFF2 = "A super-freezing popsic-stick!",
        ICESTAFF3 = "The ultimate frosty star-stick! Brrr!",
        NONSLIPGRIT = "Sticky-dust for my paws so I don't go slidey-slide.",
        NONSLIPGRITBOOSTED = "Super sticky-dust! No more slipping on the boat!",
        DESICCANT = "Magic dry-dust!",
        DESICCANTBOOSTED = "Super magic dry-dust! Bye-bye soggy!",
        HERMITCRAB_SHELL = "A giant swirly-shell toy!",
        SALTY_DOGHAT = "A funny yellow hat for playing sailor!",
        SALTY_DOG = "A water-puppy! Can I pet you?",

        HERMITCRAB_TEASHOP =
        {
            GENERIC = "The shop is taking a nap. No water-snacks right now.", -- Inactive state, no Pearl inside.
            ACTIVE = "The crab-lady is ready to play tea-party!", -- Active, Pearl is inside, can buy from her
            BREWING = "She's cooking up some warm tummy-water!", -- A trade just happened and she's brewing the tea!|
            BURNT = "Oh no, the tea-party house had a fiery tantrum.", -- burnt strings.
        },

        FISHMEAT_DRIED = "Chewy water-snack!",
        FISHMEAT_SMALL_DRIED = "Teeny-tiny chewy water-snack!",

        HERMITCRAB_LIGHTPOST = -- Similar to YOTS_LANTERN_POST
        {
            GENERIC = "A pretty bottle-star to light up the dark!",
            ABANDONED = "The bottle-star looks lonely and sleepy.",
        },
        HERMITCRAB_LIGHTPOST_ITEM = "A bottle-star toy waiting to be built.",

        -- Year of the Clockwork Knight

        YOTH_KNIGHTSHRINE =
        {
            GENERIC = "The rock-pony looks happy with its shiny gifts!", -- Has an offering of either gears, wires or doodad.
            EMPTY = "The rock-pony wants a shiny beep-boop toy to play with.", -- No offering. Character should hint at it wanting an offering.
            BURNT = "The pony-statue got all crispy and sad.", -- Burnt.
        },

        MASK_PRINCESSHAT = "A sparkly princess-crown! Am I a star-princess now?",
        COSTUME_PRINCESS_BODY = "A pretty dress for royal tea-parties!",

        PLAYBILL_THE_PRINCESS_YOTH = "A doodle-story about a brave princess-pony!",

        KNIGHT_YOTH =
        {
            GENERIC = "A big grumpy rock-pony! Don't stomp on me!", -- Generic quote. It's aggressive.
            FOLLOWING = "The rock-pony wants to play follow-the-leader!", -- Following the character examining
            FOLLOWING_OTHER = "The rock-pony is following someone else's game.", -- Following another character or mannequin
        },

        YOTH_KNIGHTHAT = "A pony-hat! Neigh!",
        ARMOR_YOTH_KNIGHT = "A heavy pony-suit for playing knight!",
        HORSESHOE = "A metal U-toy! Maybe it brings lucky star-magic.",
        YOTH_LANCE = "A giant zoomy-poke stick for jousting!",

        FLOATINGLANTERN =
        {
            DEFLATED = "Aww, the floaty-light took a nap on the ground.", -- Depleted and on the ground
            HELD = "A paper-star waiting to fly away!", -- In the players inventory
            GENERIC = "Fly high, little paper-star! Wheee!", -- Floating in the sky!
        },

        YOTH_KNIGHTSTICK = "A bouncy stick-pony! Giddy up, zoom-zoom!",
        YOTH_CHAIR_ROCKING_ITEM = "Toys to build a wobbly-chair!", -- The chair itself uses WOOD_CHAIR inspect states.
    }, 

    DESCRIBE_GENERIC = "How do you play with this toy?",
    DESCRIBE_TOODARK = "It's too dark! I'm scared of the Big Dark!",
    DESCRIBE_SMOLDERING = "Uh oh, that toy is getting super hot!",

    DESCRIBE_PLANTHAPPY = "Look at that happy little green-friend! It's reaching for the stars! Yay!",
    DESCRIBE_PLANTVERYSTRESSED = "Oh no! The green-friend's inner star is super dim. It's having a big sad-tantrum!",
    DESCRIBE_PLANTSTRESSED = "The little green-friend is being a bit of a grumpy-pants today.",
    DESCRIBE_PLANTSTRESSORKILLJOYS = "Those meanie-weeds are bullying the green-friend! I gotta pounce on them!",
    DESCRIBE_PLANTSTRESSORFAMILY = "Aww, it's lonely! It needs more family-friends to play tag with.",
    DESCRIBE_PLANTSTRESSOROVERCROWDING = "Too many green-friends in one spot! They don't have enough room to stretch their leafy arms!",
    DESCRIBE_PLANTSTRESSORSEASON = "The clouds are making the wrong weather-magic for this little plant.",
    DESCRIBE_PLANTSTRESSORMOISTURE = "It's super thirsty! It needs a big drink of splashy sky-juice.",
    DESCRIBE_PLANTSTRESSORNUTRIENTS = "Its tummy is completely empty! It's begging for a stinky-snack.",
    DESCRIBE_PLANTSTRESSORHAPPINESS = "It wants a friend to talk to! Should I tell it a story about the stars?",

    EAT_FOOD =
    {
        TALLBIRDEGG_CRACKED = "Mmm. Crunchy beak-bits!",
		WINTERSFEASTFUEL = "Tastes like the holidays.",
    },

    WENDY_SKILLTREE_EASTEREGG = "only_used_by_wendy",


}