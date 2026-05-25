-- =========================================================
-- SPEECH DICTIONARY: WILTO
-- Contains all randomized dialogue lines.
-- =========================================================

local SPEECH_WILTO = {
    -- Triggered when gathering items for the medical system
    HEAL_GATHER = {
        "I'm saving this to patch you up!",
        "This will make a fine bandage later!",
        "More medical supplies for the road.",
        "Keep them coming, I'll keep us alive!",
        "Stored! Let me know if you need first aid.",
        "Perfect. I'll convert this into healing materials!"
    },

    -- Triggered when health is dangerously low in combat
    COMBAT_FLEE = {
        "I can't take much more of this!",
        "Fall back! I cannot survive another hit!",
        "I'm hurt out here...!",
        "Getting out of here...!",
        "No, no, no!",
        "I need to patch up immediately! Cover me!",
        "My vision is fading...!"
    },

    -- Triggered when attempting to give an item but inventory is full
    INVENTORY_FULL = {
        "My pockets are completely full!"
    },

    -- Triggered when receiving a valid item
    ITEM_RECEIVED = {
        "I'll put this to good use...!",
        "Thank you! I'll hold onto this for now.",
        "Appreciate it! This will definitely come in handy!",
        "For me? Thanks...!",
        "Alright, let's see what we can do with this...",
        "Safe with me! Thanks for the gear.",
        "This looks useful. I'll make sure it doesn't go to waste!"
    },

    -- Triggered when the leader (player) dies
    LEADER_DIED = {
        "I really didn't want to see that at all!"
    },

    -- Triggered when the leader changes character or despawns
    LEADER_DESPAWN = {
        "Goodbye...!"
    },

    -- Triggered randomly while idling or walking
    AMBIENT = {
        "This place is... quite big.",
        "Are you sure we're going the right way?",
        "It's a bit scary out here, but I trust you.",
        "Do you think it will rain?",
        "What was that noise...?",
        "I hope we don't run into anything too big.",
        "Is it getting darker, or is it just me?",
        "I'll follow your lead.",
        "I'm glad I'm not alone here.",
        "Your light makes me feel safe.",
        "I'll try my best to protect you.",
        "You don't have to carry all the weight yourself, you know.",
        "Do you ever feel like you've been here before?",
        "Sometimes I feel like I'm forgetting something important...",
        "It's peaceful when it's quiet like this.",
        "The world is so strange... but it's okay if we are together."
    },
    -- Triggered when greeting a nearby player
    GREETING = {
        "Hey, %s! How are you doing?",
        "Looking good today, %s.",
        "Stay safe out here, %s.",
        "Need any help, %s?",
        "Oi! %s!",
        "Don't starve, %s. Or else...",
        "Nice to see you, %s.",
        "Keep up the good work, %s!",
        "Careful out there, %s.",
        "You're still alive. Nice.",
        "Try not to die today, %s.",
        "You smell like campfire smoke, %s.",
        "Hey! Don't sneak up on me like that, %s."
    },
}

return SPEECH_WILTO