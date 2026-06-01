local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"
local Image = require "widgets/image"

local AlterBadge = Class(Badge, function(self, owner)
    -- Keep the blue color
    Badge._ctor(self, nil, owner, { 0, 0.5, 1, 1 }, "status_meter", nil, nil, true)

    -- Load the custom compiled texture and its corresponding atlas
    self.icon = self.underNumber:AddChild(Image("images/inventoryimages/wiltolion_gestalt.xml", "wiltolion_gestalt.tex"))
    
    -- A 128x128 image needs a much smaller scale to fit inside the native ring
    self.base_scale = 0.45 
    self.icon:SetScale(self.base_scale)
    self.icon:SetPosition(0, 0, 0)
    
    self:StartUpdating()
end)

function AlterBadge:OnUpdate(dt)
    -- Visibility driven by Skilltree tags
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