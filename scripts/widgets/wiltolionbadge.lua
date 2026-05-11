local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"
local Image = require "widgets/image"

local WiltolionBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, nil, owner, { 1, 0.8, 0, 1 }, "status_meter", nil, nil, true)

    -- USAMOS EL AVATAR: Tiene mucha más resolución y forma perfecta para el HUD
    self.icon = self.underNumber:AddChild(Image("images/avatars/avatar_wiltolion.xml", "avatar_wiltolion.tex"))
    
    -- TAMAÑO DEL ICONO: Auméntalo o redúcelo cambiando este número (ej: 0.3 o 0.2)
    self.base_scale = 0.8
    self.icon:SetScale(self.base_scale) 
    self.icon:SetPosition(0, 0, 0)
    
    -- Variables para la animación de latido
    self.pulse_dir = 1
    self.pulse_scale = self.base_scale
    
    self:StartUpdating()
end)

function WiltolionBadge:OnUpdate(dt)
    if self.owner and self.owner._net_heat_power then
        local current_heat = self.owner._net_heat_power:value()
        
        -- 1. ARREGLO DE LOS CEROS Y LA BARRA LLENA
        -- Le pasamos un valor de 0.0 a 1.0. Esto arregla visualmente el anillo y el número.
        self:SetPercent(current_heat / 100, 100)
        
        -- 2. ANIMACIÓN DEL ICONO (Latido del Núcleo)
        -- Late rápido si está caliente (>50), y lento si se está apagando (<50)
        local speed = (current_heat > 50) and 0.15 or 0.05
        local max_scale = self.base_scale + 0.015
        local min_scale = self.base_scale - 0.015
        
        self.pulse_scale = self.pulse_scale + (speed * dt * self.pulse_dir)
        
        if self.pulse_scale >= max_scale then
            self.pulse_scale = max_scale
            self.pulse_dir = -1
        elseif self.pulse_scale <= min_scale then
            self.pulse_scale = min_scale
            self.pulse_dir = 1
        end
        
        self.icon:SetScale(self.pulse_scale)
    end
end

return WiltolionBadge