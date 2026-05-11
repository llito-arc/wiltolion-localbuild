local GLOBAL = GLOBAL

-- ==========================================
-- LEYES GLOBALES: WILTOLION SUNDROPS
-- ==========================================
local original_FEEDPLAYER_fn = GLOBAL.ACTIONS.FEEDPLAYER.fn

GLOBAL.ACTIONS.FEEDPLAYER.fn = function(act)
    if act.invobject ~= nil and act.invobject.prefab == "wiltolion_sundrop" then
        if act.target ~= nil and not act.target:HasTag("wiltolion") then
            if act.doer ~= nil and act.doer.components.talker then
                act.doer.components.talker:Say("It's too hot for them!")
            end
            return false 
        end
    end
    if original_FEEDPLAYER_fn then
        return original_FEEDPLAYER_fn(act)
    end
    return false
end

AddClassPostConstruct("components/container", function(self)
    local old_CanTakeItemInSlot = self.CanTakeItemInSlot
    self.CanTakeItemInSlot = function(self, item, slot)
        if item ~= nil and item.prefab == "wiltolion_sundrop" then
            if self.inst ~= nil and self.inst.prefab ~= "wiltolion_pylon" then
                return false
            end
        end
        if old_CanTakeItemInSlot then
            return old_CanTakeItemInSlot(self, item, slot)
        end
        return true
    end
end)

AddClassPostConstruct("components/container_replica", function(self)
    local old_CanTakeItemInSlot = self.CanTakeItemInSlot
    self.CanTakeItemInSlot = function(self, item, slot)
        if item ~= nil and item.prefab == "wiltolion_sundrop" then
            if self.inst ~= nil and self.inst.prefab ~= "wiltolion_pylon" then
                return false
            end
        end
        if old_CanTakeItemInSlot then
            return old_CanTakeItemInSlot(self, item, slot)
        end
        return true
    end
end)

-- ==========================================
-- UI INJECTIONS
-- ==========================================
AddClassPostConstruct("screens/playerhud", function(self)
    self.OpenWiltoJournalScreen = function(self, p_up, p_chop, p_mine, p_dig, p_fight, p_give, p_harvest, tokens, points)
        local WiltoJournalScreen = GLOBAL.require("screens/wiltojournalscreen")
        self.wiltojournal = WiltoJournalScreen(self.owner, p_up, p_chop, p_mine, p_dig, p_fight, p_give, p_harvest, tokens, points)
        GLOBAL.TheFrontEnd:PushScreen(self.wiltojournal)
    end
end)

-- ==========================================
-- SISTEMA DE RANURAS: PILÓN GIRASOL
-- ==========================================
local containers = GLOBAL.require("containers")
local Image = GLOBAL.require("widgets/image")

local pylon_slotpos = {
    GLOBAL.Vector3(-80, 80, 0),  GLOBAL.Vector3(0, 80, 0),  GLOBAL.Vector3(80, 80, 0),
    GLOBAL.Vector3(-80, 0, 0),                              GLOBAL.Vector3(80, 0, 0), 
    GLOBAL.Vector3(-80, -80, 0), GLOBAL.Vector3(0, -80, 0), GLOBAL.Vector3(80, -80, 0)
}

local PYLON_SLOT_ITEMS = {
    [1] = "redgem",            
    [2] = "wiltolion_sundrop", 
    [3] = "bluegem",           
    [4] = "purplegem",         
    [5] = "orangegem",         
    [6] = "yellowgem",         
    [7] = "opalpreciousgem",   
    [8] = "greengem",          
}

local function PylonItemTest(container, item, slot)
    if slot ~= nil then
        return item.prefab == PYLON_SLOT_ITEMS[slot]
    end
    for i, prefab in ipairs(PYLON_SLOT_ITEMS) do
        if item.prefab == prefab then return true end
    end
    return false
end

local pylon_widget = {
    widget = {
        slotbg = {
            { image = "inv_slot.tex" }, { image = "inv_slot.tex" }, { image = "inv_slot.tex" }, 
            { image = "inv_slot.tex" },                             { image = "inv_slot.tex" }, 
            { image = "inv_slot.tex" }, { image = "inv_slot.tex" }, { image = "inv_slot.tex" }
        },
        slotpos = pylon_slotpos,
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_3x3",
        pos = GLOBAL.Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "chest",
    usespecificslotsforitems = true,
    itemtestfn = PylonItemTest,
}
containers.params.wiltolion_pylon = pylon_widget
for k, v in pairs(containers.params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end

-- ==========================================
-- EL HACK VISUAL: IMÁGENES FANTASMA NATIVAS
-- ==========================================
AddClassPostConstruct("widgets/containerwidget", function(self)
    local old_Open = self.Open
    self.Open = function(self, container, doer)
        old_Open(self, container, doer)
        if container ~= nil and container.prefab == "wiltolion_pylon" then
            for i, slot in pairs(self.inv) do
                local expected_prefab = PYLON_SLOT_ITEMS[i]
                if not slot.wiltolion_ghost and expected_prefab then
                    local tex_name = expected_prefab .. ".tex"
                    local atlas_name = GLOBAL.GetInventoryItemAtlas(tex_name)
                    if atlas_name then
                        slot.wiltolion_ghost = slot:AddChild(Image(atlas_name, tex_name))
                        slot.wiltolion_ghost:SetTint(1, 1, 1, 0.3) 
                        slot.wiltolion_ghost:SetClickable(false)   
                        if slot.tile then
                            slot.wiltolion_ghost:Hide()
                        end
                    end
                end
            end
        end
    end

    local old_OnItemGet = self.OnItemGet
    if old_OnItemGet then
        self.OnItemGet = function(self, item, slot_num, ...)
            old_OnItemGet(self, item, slot_num, ...)
            if self.isopen and self.container and self.container.prefab == "wiltolion_pylon" then
                local slot = self.inv[slot_num]
                if slot and slot.wiltolion_ghost then
                    slot.wiltolion_ghost:Hide()
                end
            end
        end
    end

    local old_OnItemLose = self.OnItemLose
    if old_OnItemLose then
        self.OnItemLose = function(self, slot_num, ...)
            old_OnItemLose(self, slot_num, ...)
            if self.isopen and self.container and self.container.prefab == "wiltolion_pylon" then
                local slot = self.inv[slot_num]
                if slot and slot.wiltolion_ghost then
                    slot.wiltolion_ghost:Show()
                end
            end
        end
    end
end)