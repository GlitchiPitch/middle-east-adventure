local Interfaces = require(script.Parent.Interfaces)
local IRepository = Interfaces.IRepository

---@class InventoryRepository : IRepository
---@field playerRepository IPlayerRepository
local InventoryRepository = setmetatable({}, { __index = IRepository })
InventoryRepository.__index = InventoryRepository

---@param diContainer DIContainer
---@return InventoryRepository
function InventoryRepository.new(diContainer)
	local self = setmetatable(IRepository.new(diContainer), InventoryRepository)

	return self
end

function InventoryRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.playerRepository = shared.infrastructure.repositories.playerRepository
end

---@param playerEntity PlayerEntity
---@return InventoryEntity
function InventoryRepository:getInventory(playerEntity)
	return playerEntity.inventory
end

---@param playerEntity PlayerEntity
---@param itemName string
---@param itemData table
function InventoryRepository:addItem(playerEntity, itemName, itemData)
	local inventory = self:getInventory(playerEntity)

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

---@param playerEntity PlayerEntity
---@param itemName string
---@param amount number
function InventoryRepository:removeItem(playerEntity, itemName, amount)
	local inventory = self:getInventory(playerEntity)
	local currentItem = inventory:getItem(itemName)

	if currentItem then
		currentItem.amount = currentItem.amount - amount
		if currentItem.amount <= 0 then
			inventory[itemName] = nil
		end
	end
end

---@param playerEntity PlayerEntity
---@param itemName string
---@param newData table
function InventoryRepository:updateItem(playerEntity, itemName, newData)
	local inventory = self:getInventory(playerEntity)
	local currentItem = inventory:getItem(itemName)

	if currentItem then
		for key, value in pairs(newData) do
			currentItem[key] = value
		end
	end
end

---@param playerEntity PlayerEntity
---@param itemName string
---@return table
function InventoryRepository:getItem(playerEntity, itemName)
	local inventory = self:getInventory(playerEntity)
	return inventory:getItem(itemName)
end

---@param playerEntity PlayerEntity
---@return table<string, table>
function InventoryRepository:getAllItems(playerEntity)
	local inventory = self:getInventory(playerEntity)

	-- Используем table.clone для более эффективного копирования
	local items = {}
	for itemName, itemData in pairs(inventory) do
		if typeof(itemData) == "table" then
			items[itemName] = itemData
		end
	end

	return items
end

return InventoryRepository
