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

---@param player Player
---@param itemData table
function InventoryService:clickItem(player, itemData)
    ---@type ServerApplication
    local application = self.diContainer:resolve("Application")
    local playerEntity = application.services.playerService:getPlayerEntity(player)
    local item = playerEntity.inventory:getItem(itemData.name) -- entity
    if itemData.equipdable then
        playerEntity.equipment:equip(item)
    elseif itemData.usable then
        item:use()
    end
end

---@param playerEntity PlayerEntity
---@param itemData itemData
function InventoryService:addItem(playerEntity, itemData)
    ---@type SharedDomain
    local domain = self.diContainer:resolve("Domain")
    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    local _itemData = shared.data:getItemData(itemData.name)
    local sword = domain.OneHanded.new()

    playerEntity.inventory:addItem(sword)
end

return InventoryService
