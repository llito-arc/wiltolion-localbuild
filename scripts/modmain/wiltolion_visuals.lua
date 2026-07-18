local GLOBAL = GLOBAL

-- ==========================================================
-- REMOVE RED OVERHEAT AURA VISUALS FOR WILTOLION
-- ==========================================================
AddPlayerPostInit(function(inst)
    inst:ListenForEvent("playeractivated", function(player)
        if player == GLOBAL.ThePlayer then
            if player:HasTag("wiltolion") then
                GLOBAL.TUNING.OVERHEAT_TEMP = 980
                GLOBAL.TUNING.OVERHEAT_HURT_TEMP = 990
            else
                GLOBAL.TUNING.OVERHEAT_TEMP = 70
                GLOBAL.TUNING.OVERHEAT_HURT_TEMP = 71
            end
        end
    end)
end)

-- ==========================================
-- GESTOR VISUAL CENTRALIZADO (BLOOM)
-- ==========================================
AddPlayerPostInit(function(inst)
    inst._wiltolion_bloom_state = GLOBAL.net_tinybyte(inst.GUID, "wiltolion.bloom_state", "wiltolion_bloom_dirty")

    -- LOCAL APPLY FUNCTION: This safely sets the bloom based on the network value
    local function ApplyBloomState(player)
        if not player or not player:IsValid() then return end
        local state = player._wiltolion_bloom_state:value()
        
        if state == 2 then
            player.AnimState:ClearSymbolBloom("swap_hat")
            player.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        elseif state == 1 then
            player.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
            player.AnimState:SetSymbolBloom("swap_hat")
        else
            player.AnimState:ClearSymbolBloom("swap_hat")
            if not player:HasTag("playerghost") then
                player.AnimState:ClearBloomEffectHandle()
            end
        end
    end

    -- CLIENT SIDE: Listens to the network AND overrides its own predictions
    if not GLOBAL.TheNet:IsDedicated() then
        inst:ListenForEvent("wiltolion_bloom_dirty", function(player) player:DoTaskInTime(0, ApplyBloomState) end)
        -- These two lines are the magic fix: The client corrects itself immediately when moving items
        inst:ListenForEvent("equip", function(player) player:DoTaskInTime(0, ApplyBloomState) end)
        inst:ListenForEvent("unequip", function(player) player:DoTaskInTime(0, ApplyBloomState) end)
    end

    -- SERVER SIDE: Evaluates actual inventory and updates the network
    if GLOBAL.TheWorld.ismastersim then
        local function EvaluateVisuals(player)
            if not player:IsValid() then return end
            
            local torus_active = false
            local body_bloom = false
            
            if player.components.inventory then
                local head_item = player.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HEAD)
                if head_item and head_item.prefab == "wiltolion_torus" then
                    torus_active = not head_item._on_cooldown
                end
                
                local body_item = player.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BODY)
                if body_item and body_item.prefab == "yellowamulet" then
                    body_bloom = true
                end
            end
            
            if player.sg and player.sg:HasStateTag("busy") and player.sg.currentstate.name == "wiltolion_pylon_travel" then
                body_bloom = true
            end
            
            local final_state = 0
            if body_bloom then final_state = 2 elseif torus_active then final_state = 1 end
            
            player._wiltolion_bloom_state:set(final_state)
            
            if not GLOBAL.TheNet:IsDedicated() then
                player:PushEvent("wiltolion_bloom_dirty")
            end
        end

        inst:ListenForEvent("equip", function(player) player:DoTaskInTime(0, EvaluateVisuals) end)
        inst:ListenForEvent("unequip", function(player) player:DoTaskInTime(0, EvaluateVisuals) end)
        inst:ListenForEvent("wiltolion_torus_statechange", function(player) player:DoTaskInTime(0, EvaluateVisuals) end)
        inst:ListenForEvent("wiltolion_visuals_dirty", function(player) player:DoTaskInTime(0, EvaluateVisuals) end)
    end
end)

-- ==========================================
-- HUD: CORE MEDALS (SOLAR & LUNAR)
-- ==========================================
AddClassPostConstruct("widgets/statusdisplays", function(self)
    -- 1. Check if the owner is Wiltolion before adding custom UI
    -- self.owner is the player entity associated with this HUD
    if self.owner and self.owner.prefab == "wiltolion" then
        
        local WiltolionBadge = require("widgets/wiltolionbadge")
        local AlterBadge = require("widgets/alterbadge")

        -- 2. Create Solar Power Badge (Orange)
        self.wilto_heat = self:AddChild(WiltolionBadge(self.owner))
        self.wilto_heat:SetPosition(60, -120, 0) 

        -- 3. Create Alter Badge (Blue/Lunar)
        self.alter_tokens = self:AddChild(AlterBadge(self.owner))
        self.alter_tokens:SetPosition(60, -205, 0)

        -- 4. Hook SetGhostMode to handle visibility during death
        -- We only override it if we actually created the badges
        local old_SetGhostMode = self.SetGhostMode
        self.SetGhostMode = function(self, isghost)
            old_SetGhostMode(self, isghost)
            
            -- Safety check: Ensure badges exist before calling methods
            if self.wilto_heat then
                if isghost then 
                    self.wilto_heat:Hide() 
                else 
                    self.wilto_heat:Show() 
                end
            end

            if self.alter_tokens then
                if isghost then
                    self.alter_tokens:Hide()
                else
                    -- The AlterBadge logic in its own OnUpdate will handle 
                    -- if it should be Show() or Hide() based on Skilltree tags
                    self.alter_tokens:Show()
                end
            end
        end
    end
end)