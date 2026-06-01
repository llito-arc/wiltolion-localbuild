local Screen = require "widgets/screen"
local Widget = require "widgets/widget"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local Text = require "widgets/text"

local WiltoJournalScreen = Class(Screen, function(self, owner, p_up, p_chop, p_mine, p_dig, p_fight, p_give, p_harvest, tokens, points)
    Screen._ctor(self, "WiltoJournalScreen")
    self.owner = owner
    
    local t = tokens or 0
    local p = points or 0

    -- 1. RAÍZ DE LA PANTALLA
    self.root = self:AddChild(Widget("root"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)

    -- 2. PANEL DE FONDO
    self.bg = self.root:AddChild(Image("images/wilto_panel.xml", "wilto_panel.tex"))
    self.bg:SetScale(0.4, 0.4, 0.4) 
    self.bg:SetPosition(0, -10, 0)

    -- 3. TÍTULO Y ESTADÍSTICAS
    self.title = self.root:AddChild(Text(TITLEFONT, 55, "Adventure Journal"))
    self.title:SetPosition(0, 230, 0)
    self.title:SetColour(1, 1, 1, 1)

    self.stats_text = self.root:AddChild(Text(TITLEFONT, 28, "Medical Tokens: " .. t .. "/20  (" .. p .. "/30 pts)"))
    self.stats_text:SetPosition(0, 175, 0)
    self.stats_text:SetColour(0.2, 0.8, 0.2, 1)

    -- 4. ESTADOS DE LOS BOTONES
    self.toggles = {
        pickup = p_up == true,
        chop = p_chop == true,
        mine = p_mine == true,
        dig = p_dig == true,
        fight = p_fight == true,
        give = p_give == true,
        harvest = p_harvest == true
    }

    -- 5. FUNCIÓN CONSTRUCTORA DE BOTONES TOGGLE
    local function CreateToggle(name, text, x, y)
        local btn = self.root:AddChild(ImageButton("images/ui.xml", "button_large.tex", "button_large_over.tex", "button_large_disabled.tex"))
        btn:SetPosition(x, y, 0)
        btn:SetScale(0.7, 0.7, 0.7)
        
        btn:SetFont(TALKINGFONT)
        btn:SetTextSize(36)
        btn:SetText(text)
        btn:SetTextColour(1, 1, 1, 1)
        btn:SetTextFocusColour(1, 1, 1, 1)
        
        local function UpdateColor()
            if self.toggles[name] then
                btn.image:SetTint(0.2, 0.8, 0.2, 1)
            else
                btn.image:SetTint(0.8, 0.2, 0.2, 1)
            end
        end
        UpdateColor()

        btn:SetOnClick(function()
            self.toggles[name] = not self.toggles[name]
            UpdateColor()
            SendModRPCToServer(GetModRPC("Wiltolion", "ToggleWiltoAction"), name, self.toggles[name] and 1 or 0)
        end)
        
        return btn
    end

    -- ==========================================
    -- 6. LA CUADRÍCULA PERFECTA (2x4)
    -- ==========================================
    -- FILA 1
    self.btn_pickup  = CreateToggle("pickup", "Pick Up Items", -130, 130)
    self.btn_harvest = CreateToggle("harvest", "Harvest Plants", 130, 130)

    -- FILA 2
    self.btn_chop    = CreateToggle("chop", "Chop Trees", -130, 70)
    self.btn_mine    = CreateToggle("mine", "Mine Rocks", 130, 70)
    
    -- FILA 3
    self.btn_dig     = CreateToggle("dig", "Dig", -130, 10)
    self.btn_give    = CreateToggle("give", "Give Items", 130, 10)

    -- FILA 4 (Izquierda: Pelear | Derecha: Llamar a Wilto)
    self.btn_fight   = CreateToggle("fight", "Fight", -130, -50)
    
    self.btn_call = self.root:AddChild(ImageButton("images/ui.xml", "button_large.tex", "button_large_over.tex", "button_large_disabled.tex"))
    self.btn_call:SetPosition(130, -50, 0) -- Alineado con Fight
    self.btn_call:SetScale(0.7, 0.7, 0.7)
    self.btn_call:SetFont(TALKINGFONT)
    self.btn_call:SetTextSize(32)
    self.btn_call:SetText("Call Wilto")
    self.btn_call:SetTextColour(1, 0.8, 0, 1) 
    self.btn_call:SetTextFocusColour(1, 0.8, 0, 1)
    self.btn_call:SetOnClick(function()
        SendModRPCToServer(GetModRPC("Wiltolion", "CallWilto"))
        TheFrontEnd:PopScreen(self)
    end)


    -- ==========================================
    -- 7. BOTONES INFERIORES CENTRADOS
    -- ==========================================
    -- DROP EVERYTHING
    self.btn_drop = self.root:AddChild(ImageButton("images/ui.xml", "button_large.tex", "button_large_over.tex", "button_large_disabled.tex"))
    self.btn_drop:SetPosition(0, -130, 0)
    self.btn_drop:SetScale(1.1, 1.1, 1.1)
    
    self.btn_drop:SetFont(BUTTONFONT)
    self.btn_drop:SetTextSize(36)
    self.btn_drop:SetText("DROP EVERYTHING")
    self.btn_drop:SetTextColour(1, 1, 1, 1)
    self.btn_drop:SetTextFocusColour(1, 1, 1, 1)
    self.btn_drop.image:SetTint(1, 0.5, 0, 1) 
    
    self.btn_drop:SetOnClick(function()
        self.toggles["pickup"] = false
        if self.btn_pickup then self.btn_pickup.image:SetTint(0.8, 0.2, 0.2, 1) end
        
        SendModRPCToServer(GetModRPC("Wiltolion", "ToggleWiltoAction"), "pickup", 0)
        SendModRPCToServer(GetModRPC("Wiltolion", "WiltoDropEverything"))
    end)

    -- CERRAR
    self.close_btn = self.root:AddChild(ImageButton("images/ui.xml", "button_large.tex", "button_large_over.tex", "button_large_disabled.tex"))
    self.close_btn:SetPosition(0, -210, 0)
    self.close_btn:SetScale(0.6, 0.6, 0.6)
    
    self.close_btn:SetFont(BUTTONFONT)
    self.close_btn:SetTextSize(36)
    self.close_btn:SetText("Close")
    self.close_btn:SetTextColour(1, 1, 1, 1)
    self.close_btn:SetTextFocusColour(1, 1, 1, 1)
    
    self.close_btn:SetOnClick(function() self:Close() end)
end)

-- Permite cerrar la ventana pulsando la tecla ESC
function WiltoJournalScreen:OnControl(control, down)
    if WiltoJournalScreen._base.OnControl(self, control, down) then return true end
    if not down and (control == CONTROL_CANCEL) then
        self:Close()
        return true
    end
end

-- Función para destruir la pantalla de forma segura
function WiltoJournalScreen:Close()
    TheFrontEnd:PopScreen(self)
end

return WiltoJournalScreen