---@class ServerApplicationInventoryService
---@field diContainer DIContainer
local InventoryService = {}
InventoryService.__index = InventoryService

---@param diContainer DIContainer
---@return ServerApplicationInventoryService
function InventoryService.new(diContainer)
    local self = setmetatable({}, InventoryService)
    self.diContainer = diContainer
    return self
end

function InventoryService:equip()
    
end

function InventoryService:unequip()
    
end

---@param playerEntity PlayerEntity
---@param itemData itemData
function InventoryService:addItem(playerEntity, itemData)
    ---@type SharedDomain
    local domain = self.diContainer:resolve("Domain")
    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    local _itemData = shared.data:getItemData(itemData.name)
    local sword = domain.Sword.new()

    playerEntity.inventory:addItem(sword)
end

return InventoryService
