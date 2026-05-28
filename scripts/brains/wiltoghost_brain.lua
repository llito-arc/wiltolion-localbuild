require("behaviours/follow")
require("behaviours/wander")

local WiltoGhostBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local MIN_FOLLOW_DIST = 2
local MAX_FOLLOW_DIST = 9
local TARGET_FOLLOW_DIST = 5

local function GetLeader(inst)
    return inst.components.follower ~= nil and inst.components.follower:GetLeader() or nil
end

local function GetWanderPos(inst)
    return inst:GetPosition()
end

function WiltoGhostBrain:OnStart()
    local root = PriorityNode(
    {
        -- The ghost only follows the leader and wanders idly. No actions allowed.
        Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST, true),
        Wander(self.inst, GetWanderPos, 3, { minwalktime = 0.5, randwalktime = 0.5, minwaittime = 1, randwaittime = 2 }),
    }, 0.25)

    self.bt = BT(self.inst, root)
end

return WiltoGhostBrain