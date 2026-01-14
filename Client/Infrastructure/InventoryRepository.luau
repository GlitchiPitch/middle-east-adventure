---@class ClientInventoryRepository
---@field diContainer DIContainer
---@field playerRepository ClientPlayerRepository
local InventoryRepository = {}
InventoryRepository.__index = InventoryRepository

---@param diContainer DIContainer
---@return ClientInventoryRepository
function InventoryRepository.new(diContainer)
	local self = setmetatable({}, InventoryRepository)
	self.diContainer = diContainer
	return self
end

function InventoryRepository:init()
	---@type ClientInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.playerRepository
end

---@return InventoryEntity
function InventoryRepository:getInventory()
	local playerEntity = self.playerRepository:getPlayerEntity()
	return playerEntity:getInventory()
end

---@param itemName string
---@param itemData table
function InventoryRepository:addItem(itemName, itemData)
	-- Client-side implementation - would typically use RemoteEvent
	local inventory = self:getInventory()

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

---@param itemName string
---@param amount number
function InventoryRepository:removeItem(itemName, amount)
	local inventory = self:getInventory()
	local currentItem = inventory:getItem(itemName)

	if currentItem then
		currentItem.amount = currentItem.amount - amount
		if currentItem.amount <= 0 then
			inventory[itemName] = nil
		end
	end
end

---@param itemName string
---@param newData table
function InventoryRepository:updateItem(itemName, newData)
	local inventory = self:getInventory()
	local currentItem = inventory:getItem(itemName)

	if currentItem then
		for key, value in pairs(newData) do
			currentItem[key] = value
		end
	end
end

---@param itemName string
---@return table
function InventoryRepository:getItem(itemName)
	local inventory = self:getInventory()
	return inventory:getItem(itemName)
end

---@return table<string, table>
function InventoryRepository:getAllItems()
	local inventory = self:getInventory()
	local items = {}

	for itemName, itemData in pairs(inventory) do
		if typeof(itemData) == "table" then
			items[itemName] = itemData
		end
	end

	return items
end

return InventoryRepository
