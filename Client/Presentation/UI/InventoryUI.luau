---@class InventoryUI
---@field _instance Frame
---@field diContainer DIContainer
---@field _slotTemplate TextButton
local InventoryUI = {}
InventoryUI.__index = InventoryUI

---@param diContainer DIContainer
---@param inventoryUI Frame
---@return InventoryUI
function InventoryUI.new(diContainer, inventoryUI)
    local self = setmetatable({}, InventoryUI)
    self.diContainer = diContainer
    self._instance = inventoryUI
    self:_registerUI()
    return self
end

function InventoryUI:_registerUI()
    self._slotTemplate = self._instance.Template
end

function InventoryUI:init()
    ---@type ClientApplication
    local application = self.diContainer:resolve("Application")
    local playerInventory = application.services.inventoryService:getInventory()
    local inventoryData = playerInventory:toData()

    for i, v in inventoryData do
        self:_createSlot(i, v)
    end
end

function InventoryUI:_createSlot(i, itemData)
    ---@type ClientApplication
    local application = self.diContainer:resolve("Application")

    local itemSlot = self._slotTemplate:Clone()
    local function onClick()
        application.services.inventoryService:clickItem(itemData)
    end

    itemSlot.Parent = self._instance
    itemSlot.Visible = true
    itemSlot.LayoutOrder = i
    itemSlot.MouseButton1Click:Connect(onClick)
end

return InventoryUI
