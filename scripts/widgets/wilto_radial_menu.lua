local Widget = require "widgets/widget"
local UIAnim = require "widgets/uianim"
local Image = require "widgets/image"
local Text = require "widgets/text"

local RADIUS = 150
local HOVER_TEXT_COLOR = { 1, 1, 1, 1 }
local DEPLOY_TIME = 0.15

--------------------------------------------------------------------------
-- CUSTOM BADGE BUTTON CLASS
--------------------------------------------------------------------------
local WiltoBadgeButton = Class(Widget, function(self, data, on_click, on_hover)
    Widget._ctor(self, data.id)
    
    self.data = data
    self.onclick = on_click
    self.onhover = on_hover

    self.anim_root = self:AddChild(Widget("anim_root"))
    
    self.backing = self.anim_root:AddChild(UIAnim())
    self.backing:GetAnimState():SetBank("status_meter")
    self.backing:GetAnimState():SetBuild("status_meter")
    self.backing:GetAnimState():PlayAnimation("bg")
    
    self.circleframe = self.anim_root:AddChild(UIAnim())
    self.circleframe:GetAnimState():SetBank("status_meter")
    self.circleframe:GetAnimState():SetBuild("status_meter")
    self.circleframe:GetAnimState():PlayAnimation("frame")
    self.circleframe:GetAnimState():SetPercent("frame", 0) 
    
    local atlas = GetInventoryItemAtlas(data.icon) or "images/inventoryimages.xml"
    self.icon = self.anim_root:AddChild(Image(atlas, data.icon))
    self.icon:SetScale(0.55, 0.55, 0.55) 
    
    self:SetClickable(true)
end)

function WiltoBadgeButton:OnGainFocus()
    WiltoBadgeButton._base.OnGainFocus(self)
    self.anim_root:SetScale(1.15, 1.15, 1.15)
    if self.onhover then self.onhover(true, self.data.name) end
end

function WiltoBadgeButton:OnLoseFocus()
    WiltoBadgeButton._base.OnLoseFocus(self)
    self.anim_root:SetScale(1, 1, 1)
    if self.onhover then self.onhover(false, "") end
end

function WiltoBadgeButton:OnControl(control, down)
    if WiltoBadgeButton._base.OnControl(self, control, down) then return true end
    
    if not down and control == CONTROL_ACCEPT then
        TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
        if self.onclick then self.onclick() end
        return true
    end
end

function WiltoBadgeButton:SetBadgeColor(r, g, b)
    self.backing:GetAnimState():SetMultColour(r, g, b, 1)
end


--------------------------------------------------------------------------
-- MAIN RADIAL MENU WIDGET (HUD ELEMENT)
--------------------------------------------------------------------------
-- Changed inheritance from Screen to Widget
local WiltoRadialMenu = Class(Widget, function(self, owner, p_up, p_chop, p_mine, p_dig, p_fight, p_give, p_harvest, tokens, points)
    Widget._ctor(self, "WiltoRadialMenu")
    self.owner = owner
    
    -- Track time to prevent instant closing from the initial book interaction
    self.time_opened = GetTime()

    -- Global listener for Right-Click (CONTROL_SECONDARY)
    self.rightclick_handler = TheInput:AddControlHandler(CONTROL_SECONDARY, function(down)
        -- Trigger only when the button is released, and menu isn't already closing
        if not down and not self.is_closing then
            if GetTime() - self.time_opened > 0.2 then
                self:Close()
            end
        end
    end)

    -- Anchor the widget itself to the center of the screen
    self:SetVAnchor(ANCHOR_MIDDLE)
    self:SetHAnchor(ANCHOR_MIDDLE)
    self:SetScaleMode(SCALEMODE_PROPORTIONAL)

    -- Root for animations
    self.root = self:AddChild(Widget("root"))
    self.root:SetScale(0, 0, 0)
    self.root:ScaleTo(0, 1, DEPLOY_TIME)

    self.hover_text = self.root:AddChild(Text(UIFONT, 40, ""))
    self.hover_text:SetPosition(0, 35, 0)
    self.hover_text:SetColour(unpack(HOVER_TEXT_COLOR))

    local t = tokens or 0
    local p = points or 0
    self.stats_text = self.root:AddChild(Text(UIFONT, 28, "Medical Tokens: " .. tostring(t) .. "/20\nPoints: " .. tostring(p) .. "/30"))
    self.stats_text:SetPosition(0, -25, 0)
    self.stats_text:SetColour(0.2, 0.8, 0.2, 1)

    self.toggles = {
        pickup = p_up == true,
        chop = p_chop == true,
        mine = p_mine == true,
        dig = p_dig == true,
        fight = p_fight == true,
        give = p_give == true,
        harvest = p_harvest == true
    }

    local buttons_data = {
        { id = "pickup",  name = "Pick Up Items",   icon = "twigs.tex",      type = "toggle" },
        { id = "harvest", name = "Harvest Plants",  icon = "cutgrass.tex",   type = "toggle" },
        { id = "chop",    name = "Chop Trees",      icon = "axe.tex",        type = "toggle" },
        { id = "mine",    name = "Mine Rocks",      icon = "pickaxe.tex",    type = "toggle" },
        { id = "dig",     name = "Dig",             icon = "shovel.tex",     type = "toggle" },
        { id = "fight",   name = "Fight",           icon = "spear.tex",      type = "toggle" },
        { id = "give",    name = "Give Items",      icon = "goldnugget.tex", type = "toggle" },
        { id = "drop",    name = "Drop Everything", icon = "backpack.tex",   type = "action" },
        { id = "call",    name = "Call Wilto",      icon = "horn.tex",       type = "action" }
    }

    self.buttons = {}
    local num_buttons = #buttons_data
    local angle_step = (2 * math.pi) / num_buttons

    for i, data in ipairs(buttons_data) do
        local angle = (i - 1) * angle_step - (math.pi / 2)
        local x = math.cos(angle) * RADIUS
        local y = -math.sin(angle) * RADIUS 

        local btn = self.root:AddChild(WiltoBadgeButton(
            data, 
            function()
                if data.type == "toggle" then
                    self.toggles[data.id] = not self.toggles[data.id]
                    self:UpdateAllBadgeColors()
                    SendModRPCToServer(GetModRPC("Wiltolion", "ToggleWiltoAction"), data.id, self.toggles[data.id] and 1 or 0)
                elseif data.id == "drop" then
                    self.toggles["pickup"] = false
                    SendModRPCToServer(GetModRPC("Wiltolion", "ToggleWiltoAction"), "pickup", 0)
                    SendModRPCToServer(GetModRPC("Wiltolion", "WiltoDropEverything"))
                    self:Close()
                elseif data.id == "call" then
                    SendModRPCToServer(GetModRPC("Wiltolion", "CallWilto"))
                    self:Close()
                end
            end,
            function(is_hovering, name_str)
                if is_hovering then
                    self.hover_text:SetString(name_str)
                else
                    self.hover_text:SetString("")
                end
            end
        ))
        
        btn:SetPosition(x, y, 0)
        table.insert(self.buttons, btn)
    end

    self:UpdateAllBadgeColors()
end)

function WiltoRadialMenu:UpdateAllBadgeColors()
    for _, btn in ipairs(self.buttons) do
        if btn.data.type == "toggle" then
            if self.toggles[btn.data.id] then
                btn:SetBadgeColor(0.2, 0.8, 0.2) 
            else
                btn:SetBadgeColor(0.8, 0.2, 0.2) 
            end
        else
            btn:SetBadgeColor(0.8, 0.6, 0.2) 
        end
    end
end

-- Safely destroy the widget
function WiltoRadialMenu:Close()
    if self.is_closing then return end
    self.is_closing = true

    -- Remove the global input handler immediately
    if self.rightclick_handler ~= nil then
        self.rightclick_handler:Remove()
        self.rightclick_handler = nil
    end

    self.root:ScaleTo(1, 0, DEPLOY_TIME)
    
    self.inst:DoTaskInTime(DEPLOY_TIME, function()
        -- Clear reference from the HUD to allow reopening
        if self.owner and self.owner.HUD and self.owner.HUD.wilto_radial_menu == self then
            self.owner.HUD.wilto_radial_menu = nil
        end
        -- Destroy the widget
        self:Kill()
    end)
end

return WiltoRadialMenu