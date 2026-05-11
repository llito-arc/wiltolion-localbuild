local Screen = require "widgets/screen"
local Widget = require "widgets/widget"
local ImageButton = require "widgets/imagebutton"
local Text = require "widgets/text"
local Image = require "widgets/image"

local PylonMapScreen = Class(Screen, function(self, owner, current_pylon, pylon_data)
    Screen._ctor(self, "PylonMapScreen")
    self.owner = owner
    self.current_pylon = current_pylon

    -- 1. FONDO OSCURO (Más profundo para el contraste de brillo)
    self.black = self:AddChild(Image("images/global.xml", "square.tex"))
    self.black:SetVRegPoint(ANCHOR_MIDDLE)
    self.black:SetHRegPoint(ANCHOR_MIDDLE)
    self.black:SetVAnchor(ANCHOR_MIDDLE)
    self.black:SetHAnchor(ANCHOR_MIDDLE)
    self.black:SetScaleMode(SCALEMODE_FILLSCREEN)
    self.black:SetTint(0, 0, 0, 0.9) 

    -- 2. NODO CENTRAL
    self.root = self:AddChild(Widget("root"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)

    self.title = self.root:AddChild(Text(UIFONT, 45, "Celestial Star Map"))
    self.title:SetPosition(0, 300, 0)
    self.title:SetColour(1, 1, 0.8, 1)
    
    self.subtitle = self.root:AddChild(Text(BODYTEXTFONT, 25, "Select a destination pylon..."))
    self.subtitle:SetPosition(0, 260, 0)

    -- === NUEVO: CONTENEDOR DEL MAPA Y ZOOM ===
    self.zoom_level = 1 -- Empezamos con zoom normal
    self.map_root = self.root:AddChild(Widget("map_root"))

    -- ESCALA GLOBAL
    local MAP_SCALE = 0.35

    -- 3. DIBUJAR LAS LÍNEAS 
    self:DrawConstellations(pylon_data, MAP_SCALE)

    -- 4. DIBUJAR LOS GIRASOLES
    self:DrawStars(pylon_data, MAP_SCALE)

-- 5. BOTÓN CERRAR (Estética mejorada)
    self.cancel_btn = self.root:AddChild(ImageButton("images/ui.xml", "button_large.tex", "button_large_over.tex", "button_large_disabled.tex"))
    
    self.cancel_btn:SetFont(UIFONT)
    self.cancel_btn:SetText("Close Map")
    self.cancel_btn:SetTextSize(35)
    
    self.cancel_btn:SetTextColour(0.9, 0.8, 0.6, 1) 
    self.cancel_btn:SetTextFocusColour(1, 1, 1, 1)  
    
    self.cancel_btn:SetScale(0.8) 
    
    -- EL ARREGLO: Animación de "Pop" usando los eventos nativos seguros
    local old_cancel_gain = self.cancel_btn.OnGainFocus
    self.cancel_btn.OnGainFocus = function(s)
        if old_cancel_gain then old_cancel_gain(s) end
        s:SetScale(0.88)
    end

    local old_cancel_lose = self.cancel_btn.OnLoseFocus
    self.cancel_btn.OnLoseFocus = function(s)
        if old_cancel_lose then old_cancel_lose(s) end
        s:SetScale(0.8)
    end
    
    self.cancel_btn:SetPosition(0, -320, 0)
    self.cancel_btn:SetOnClick(function() self:Close() end)
end)

function PylonMapScreen:DrawConstellations(pylon_data, map_scale)
    -- En el modmain ya enviamos TODOS los pilones, así que usamos pylon_data directamente.
    local nodes = pylon_data
    
    for i = 1, #nodes do
        for j = i + 1, #nodes do
            local p1 = nodes[i]
            local p2 = nodes[j]

            local x1 = p1.x * map_scale
            local y1 = -p1.z * map_scale
            local x2 = p2.x * map_scale
            local y2 = -p2.z * map_scale
            
            local dist = math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
            
            if dist > 0.1 then 
                local angle = math.deg(math.atan2(y2 - y1, x2 - x1))
                -- ¡Añadimos a map_root!
                local line = self.map_root:AddChild(Image("images/global.xml", "square.tex"))
                
                line:SetTint(1, 1, 1, 0.5) -- Blanco con transparencia
                line:SetSize(dist, 1)      -- Línea fina
                line:SetPosition((x1 + x2) / 2, (y1 + y2) / 2, 0)
                line:SetRotation(-angle)
            end
        end
    end
end

function PylonMapScreen:DrawStars(pylon_data, map_scale)
    local cx, cy, cz = self.current_pylon.Transform:GetWorldPosition()

    -- === 1. DIBUJAR EL PILÓN ACTUAL (PUNTO DE ORIGEN) ===
    -- EL PILÓN ACTUAL
    local cur_x = cx * map_scale
    local cur_y = -cz * map_scale

    -- ¡Añadimos a map_root!
    local origin_marker = self.map_root:AddChild(ImageButton("images/inventoryimages/wiltolion_pylon.xml", "wiltolion_pylon.tex"))

    origin_marker:SetPosition(cur_x, cur_y, 0)
    origin_marker:SetScale(0.4)
    origin_marker.image:SetTint(1, 1, 1, 1) -- Blanco brillante
    origin_marker:SetHoverText("You are here")
    -- No le ponemos SetOnClick para que no haga nada.
    
    -- Resplandor extra para el origen
    local glow = origin_marker:AddChild(Image("images/inventoryimages/wiltolion_pylon.xml", "wiltolion_pylon.tex"))
    glow:SetScale(1.4)
    glow:SetTint(1, 1, 1, 0.3)
    glow:MoveToBack()

    -- === 2. DIBUJAR LOS DESTINOS (FILTRANDO EL ACTUAL) ===
    for i, data in ipairs(pylon_data) do
        local world_dist = math.sqrt((data.x - cx)^2 + (data.z - cz)^2)

        -- FILTRO CRUCIAL: Solo dibujamos botón si está a más de 2 metros (evita solapamiento)
        if world_dist > 2 then
            local dx = data.x * map_scale
            local dy = -data.z * map_scale

            local star_btn = self.map_root:AddChild(ImageButton(
                "images/inventoryimages/wiltolion_pylon.xml", 
                "wiltolion_pylon.tex"
            ))
            
            star_btn:SetPosition(dx, dy, 0)
            star_btn:SetScale(0.35) 
            star_btn.image:SetTint(0.4, 0.4, 0.4, 1) -- Grisáceo por defecto

            -- Tooltip con la distancia
            star_btn:SetHoverText("Travel (" .. math.floor(world_dist) .. "m)")

            -- Animación de foco (Zoom sutil e iluminado)
            local old_gain = star_btn.OnGainFocus
            star_btn.OnGainFocus = function(s)
                if old_gain then old_gain(s) end
                s:SetScale(0.4) 
                s.image:SetTint(1, 1, 1, 1)
            end

            local old_lose = star_btn.OnLoseFocus
            star_btn.OnLoseFocus = function(s)
                if old_lose then old_lose(s) end
                s:SetScale(0.35)
                s.image:SetTint(0.4, 0.4, 0.4, 1)
            end

            star_btn:SetOnClick(function()
                -- 1. Enviamos la petición de viaje y el cobro de energía al servidor
                SendModRPCToServer(MOD_RPC["Wiltolion"]["TravelToPylon"], self.current_pylon, data.x, data.z)
                
                -- 2. EL PARCHE ANTI-LAG: 
                -- Obligamos a nuestro juego local a iniciar la animación en este mismo frame, 
                -- sin esperar a que el servidor conteste.
                if self.owner and self.owner.sg then
                    self.owner.sg:GoToState("wiltolion_pylon_travel")
                end
                
                -- 3. Cerramos el mapa
                self:Close()
            end)
        end
    end
end

function PylonMapScreen:OnControl(control, down)
    if PylonMapScreen._base.OnControl(self, control, down) then return true end
    
    if not down then
        if control == CONTROL_CANCEL then
            self:Close()
            return true
        end
    end
    
    -- === CONTROLES DE ZOOM ===
    -- Rueda hacia adelante: Acercar (Zoom In)
    if control == CONTROL_SCROLLFWD then
        self.zoom_level = math.min(3.0, self.zoom_level + 0.15) -- Límite de x3
        self.map_root:SetScale(self.zoom_level)
        return true
    -- Rueda hacia atrás: Alejar (Zoom Out)
    elseif control == CONTROL_SCROLLBACK then
        self.zoom_level = math.max(0.5, self.zoom_level - 0.15) -- Límite de x0.5
        self.map_root:SetScale(self.zoom_level)
        return true
    end
end

function PylonMapScreen:Close()
    TheFrontEnd:PopScreen(self)
end

return PylonMapScreen