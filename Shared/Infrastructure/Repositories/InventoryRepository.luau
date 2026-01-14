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

	-- Инициализируем базовый репозиторий для получения UnitOfWork и EventEmitter
	IRepository.init(self)
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
	-- Validation
	if not playerEntity then
		error("playerEntity is required")
	end
	if not itemName or itemName == "" then
		error("itemName is required and cannot be empty")
	end
	if not itemData or typeof(itemData) ~= "table" then
		error("itemData must be a valid table")
	end

	local inventory = self:getInventory(playerEntity)
	if not inventory then
		error("Failed to get inventory for player")
	end

	local currentItem = inventory:getItem(itemName)
	local isNewItem = false

	if currentItem then
		-- Увеличиваем количество если предмет уже есть
		local amountToAdd = itemData.amount or 1
		if amountToAdd < 0 then
			error("Cannot add negative amount of items")
		end
		currentItem.amount = currentItem.amount + amountToAdd

		-- Регистрируем изменение в UnitOfWork
		if self.unitOfWork:isInTransaction() then
			self.unitOfWork:registerDirty(inventory)
		end
	else
		-- Добавляем новый предмет
		inventory:addItem({
			name = itemName,
			data = itemData,
		})
		isNewItem = true

		-- Регистрируем новое добавление в UnitOfWork
		if self.unitOfWork:isInTransaction() then
			self.unitOfWork:registerDirty(inventory)
		end
	end

	-- Публикуем событие об изменении инвентаря
	self.eventEmitter:emit("EntityUpdated", {
		entityType = "Inventory",
		entityId = tostring(playerEntity.id),
		changes = {
			inventory = true,
			itemName = itemName,
			action = isNewItem and "added" or "updated",
		},
	})
end

---@param playerEntity PlayerEntity
---@param itemName string
---@param amount number
function InventoryRepository:removeItem(playerEntity, itemName, amount)
	-- Validation
	if not playerEntity then
		error("playerEntity is required")
	end
	if not itemName or itemName == "" then
		error("itemName is required and cannot be empty")
	end
	if not amount or amount <= 0 then
		error("amount must be a positive number")
	end

	local inventory = self:getInventory(playerEntity)
	if not inventory then
		error("Failed to get inventory for player")
	end

	local currentItem = inventory:getItem(itemName)
	if not currentItem then
		error(string.format("Item '%s' not found in inventory", itemName))
	end

	if currentItem.amount < amount then
		error(string.format("Not enough items in inventory. Have: %d, Need: %d", currentItem.amount, amount))
	end

	local wasRemoved = false
	currentItem.amount = currentItem.amount - amount
	if currentItem.amount <= 0 then
		inventory[itemName] = nil
		wasRemoved = true
	end

	-- Регистрируем изменение в UnitOfWork
	if self.unitOfWork:isInTransaction() then
		self.unitOfWork:registerDirty(inventory)
	end

	-- Публикуем событие об изменении инвентаря
	self.eventEmitter:emit("EntityUpdated", {
		entityType = "Inventory",
		entityId = tostring(playerEntity.id),
		changes = {
			inventory = true,
			itemName = itemName,
			action = wasRemoved and "removed" or "updated",
		},
	})
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

		-- Регистрируем изменение в UnitOfWork
		if self.unitOfWork:isInTransaction() then
			self.unitOfWork:registerDirty(inventory)
		end

		-- Публикуем событие об изменении инвентаря
		self.eventEmitter:emit("EntityUpdated", {
			entityType = "Inventory",
			entityId = tostring(playerEntity.id),
			changes = {
				inventory = true,
				itemName = itemName,
				action = "updated",
			},
		})
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
