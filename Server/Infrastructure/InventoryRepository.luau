---@class ServerInventoryRepository
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
local InventoryRepository = {}
InventoryRepository.__index = InventoryRepository

---@param diContainer DIContainer
---@return ServerInventoryRepository
function InventoryRepository.new(diContainer)
    local self = setmetatable({}, InventoryRepository)
    self.diContainer = diContainer
    
    return self
end

function InventoryRepository:init()
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.playerRepository
end

---@param player Player
---@return InventoryEntity
function InventoryRepository:getInventory(player)
    local playerEntity = self.playerRepository:getPlayerEntity(player)
    return playerEntity:getInventory()
end

---@param player Player
---@param itemName string
---@param itemData table
function InventoryRepository:addItem(player, itemName, itemData)
    local inventory = self:getInventory(player)

    local currentItem = inventory:getItem(itemName)
    if currentItem then
        -- Увеличиваем количество если предмет уже есть
        currentItem.amount = currentItem.amount + (itemData.amount or 1)
    else
        -- Добавляем новый предмет
        inventory:addItem({
            name = itemName,
            data = itemData,
        })
    end
end

---@param player Player
---@param itemName string
---@param amount number
function InventoryRepository:removeItem(player, itemName, amount)
    local inventory = self:getInventory(player)
    local currentItem = inventory:getItem(itemName)

    if currentItem then
        currentItem.amount = currentItem.amount - amount
        if currentItem.amount <= 0 then
            inventory[itemName] = nil
        end
    end
end

---@param player Player
---@param itemName string
---@param newData table
function InventoryRepository:updateItem(player, itemName, newData)
    local inventory = self:getInventory(player)
    local currentItem = inventory:getItem(itemName)

    if currentItem then
        for key, value in pairs(newData) do
            currentItem[key] = value
        end
    end
end

---@param player Player
---@param itemName string
---@return table
function InventoryRepository:getItem(player, itemName)
    local inventory = self:getInventory(player)
    return inventory:getItem(itemName)
end

---@param player Player
---@return table<string, table>
function InventoryRepository:getAllItems(player)
    local inventory = self:getInventory(player)
    local items = {}

    for itemName, itemData in pairs(inventory) do
        if typeof(itemData) == "table" then
            items[itemName] = itemData
        end
    end

    return items
end

return InventoryRepository