require "behaviours/chaseandattack"

local WiltolionBuddyBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function WiltolionBuddyBrain:OnStart()
    local root = PriorityNode({
        -- 1. Atacar si hay enemigos cerca
        ChaseAndAttack(self.inst, 10),
        
        -- 2. Modo Vuelo Libre (Esto permite que el OnUpdate del prefab tome el control)
        ActionNode(function()
            self.inst.components.locomotor.directdrive = true
        end),
    }, .25)
    
    self.bt = BT(self.inst, root)
end

return WiltolionBuddyBrain