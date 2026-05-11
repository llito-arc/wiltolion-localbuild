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

    inst:ListenForEvent("wiltolion_bloom_dirty", function(player)
        local state = player._wiltolion_bloom_state:value()
        
        if state == 2 then
            player.AnimState:ClearSymbolBloom("swap_hat")
        elseif state == 1 then
            player.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
            player.AnimState:SetSymbolBloom("swap_hat")
        else
            player.AnimState:ClearSymbolBloom("swap_hat")
            if not player:HasTag("playerghost") then
                player.AnimState:ClearBloomEffectHandle()
            end
        end
    end)

    if GLOBAL.TheWorld.ismastersim then
        inst._torus_active = false
        inst._has_body_bloom = false

        local function EvaluateVisuals(player)
            local state = 0
            if player._has_body_bloom then
                state = 2 
            elseif player._torus_active then
                state = 1 
            end
            player._wiltolion_bloom_state:set(state)
        end

        inst:ListenForEvent("equip", function(player, data)
            local item = data and data.item
            if item then
                if item.prefab == "yellowamulet" then
                    player._has_body_bloom = true
                elseif item.prefab == "wiltolion_torus" then
                    player._torus_active = not item._on_cooldown
                end
            end
            EvaluateVisuals(player)
        end)

        inst:ListenForEvent("unequip", function(player, data)
            local item = data and data.item
            if item then
                if item.prefab == "yellowamulet" then
                    player._has_body_bloom = false
                elseif item.prefab == "wiltolion_torus" then
                    player._torus_active = false
                end
            end
            EvaluateVisuals(player)
        end)
        
        inst:ListenForEvent("wiltolion_torus_statechange", function(player, data)
            if data then
                player._torus_active = data.is_glowing
                EvaluateVisuals(player)
            end
        end)
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