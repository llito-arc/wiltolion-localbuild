-- =========================================================
-- SPEECH DICTIONARY: WILTO
-- Contains all randomized dialogue lines.
-- =========================================================

local SPEECH_WILTO = {
    -- Triggered when gathering items for the medical system
    HEAL_GATHER = {
        "I'll save this... just in case you get hurt.",
        "This could work as a bandage later.",
        "More supplies for the road...",
        "I'll carry these. Maybe they'll help us survive a bit longer.",
        "Stored away... tell me if you need help.",
        "I think I can turn this into something useful..."
    },

    -- Triggered when health is dangerously low in combat
    COMBAT_FLEE = {
        "I can't take much more of this...",
        "We need to get back... I won't survive another hit.",
        "I'm hurt... badly...",
        "Getting out of here...",
        "No... no...",
        "I need to patch this up... please cover me...",
        "Everything's starting to fade..."
    },

    -- Triggered when attempting to give an item but inventory is full
    INVENTORY_FULL = {
        "My pockets are completely full..."
    },

    -- Triggered when receiving a valid item
    ITEM_RECEIVED = {
        "I'll try to make good use of this...",
        "Thank you... I'll hold onto it.",
        "This should help... somehow.",
        "For me...? Thanks...",
        "Alright... let's see what I can do with this.",
        "I'll keep it safe.",
        "This looks useful... I won't waste it."
    },

    -- Triggered when the leader (player) dies
    LEADER_DIED = {
        "I really didn't want to see that..."
    },

    -- Triggered when the leader changes character or despawns
    LEADER_DESPAWN = {
        "Goodbye..."
    },

    -- Triggered randomly while idling or walking
    AMBIENT = {
        "This place is... really big.",
        "Are you sure we're going the right way...?",
        "It's scary out here... but I trust you.",
        "Do you think it'll rain later...?",
        "What was that noise...?",
        "I hope we don't run into anything too dangerous.",
        "It feels darker now... somehow.",
        "I'll follow your lead.",
        "I'm glad I'm not alone.",
        "Your light makes things feel a little safer.",
        "I'll do what I can to protect you.",
        "You don't have to carry everything by yourself...",
        "Do you ever feel like you've been here before...?",
        "Sometimes I feel like I forgot something important...",
        "It's nice when things are quiet.",
        "The world feels strange... but being together helps."
    },

    -- Triggered when greeting a nearby player
    GREETING = {
        "Oh... hey, %s.",
        "You doing alright, %s...?",
        "Stay safe out there, %s.",
        "Need help with anything, %s...?",
        "Ah... %s.",
        "Try not to starve, %s...",
        "It's nice seeing you, %s.",
        "Take care of yourself, %s.",
        "Be careful out there, %s.",
        "You're still alive... that's good.",
        "Try not to die today, %s...",
        "You smell like smoke, %s.",
        "Ah- don't sneak up on me like that, %s..."
    },
}

return SPEECH_WILTO