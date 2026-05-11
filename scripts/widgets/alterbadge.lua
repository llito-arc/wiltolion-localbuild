local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"
local Image = require "widgets/image"

local AlterBadge = Class(Badge, function(self, owner)
    -- Mantenemos el color azul
    Badge._ctor(self, nil, owner, { 0, 0.5, 1, 1 }, "status_meter", nil, nil, true)

    -- Recuerda cambiar esto por tu icono personalizado cuando lo tengas
    self.icon = self.underNumber:AddChild(Image("images/inventoryimages.xml", "moonrocknugget.tex"))
    
    self.base_scale = 0.8
    self.icon:SetScale(self.base_scale) 
    self.icon:SetPosition(0, 0, 0)
    
    self:StartUpdating()
end)

function AlterBadge:OnUpdate(dt)
    -- Visibilidad por Skilltree
    if self.owner:HasTag("wiltolion_lunar_1") then
        self:Show()
    else
        self:Hide()
        return 
    end

    if self.owner and self.owner._net_alter_tokens then
        local current_tokens = self.owner._net_alter_tokens:value()
        self:SetPercent(current_tokens / 3, 3)
    end
end

return AlterBadge