---@class InventoryUI
---@field _instance Frame
---@field diContainer DIContainer
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
    self.slotTemplate = self._instance.Template 
end

function InventoryUI:init()
    ---@type ClientApplication
    local application = self.diContainer:resolve("Application")
    local playerEntity = application.services.playerService:getPlayerEntity()
end

return InventoryUI