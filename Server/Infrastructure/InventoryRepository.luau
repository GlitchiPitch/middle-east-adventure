---@class ServerInventoryRepository
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
---@field unitOfWork UnitOfWork
---@field eventEmitter EventEmitter
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
    ---@type Shared
    local shared = self.diContainer:resolve("Shared")

	self.playerRepository = infrastructure.playerRepository

	self.unitOfWork = shared.infrastructure.unitOfWork
	self.eventEmitter = shared.infrastructure.eventEmitter
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
	local isNewItem = false

	if currentItem then
		-- Увеличиваем количество если предмет уже есть
		currentItem.amount = currentItem.amount + (itemData.amount or 1)

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
		entityId = tostring(player.UserId),
		changes = {
			inventory = true,
			itemName = itemName,
			action = isNewItem and "added" or "updated",
		},
	})
end

---@param player Player
---@param itemName string
---@param amount number
function InventoryRepository:removeItem(player, itemName, amount)
	local inventory = self:getInventory(player)
	local currentItem = inventory:getItem(itemName)

	if currentItem then
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
			entityId = tostring(player.UserId),
			changes = {
				inventory = true,
				itemName = itemName,
				action = wasRemoved and "removed" or "updated",
			},
		})
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

		-- Регистрируем изменение в UnitOfWork
		if self.unitOfWork:isInTransaction() then
			self.unitOfWork:registerDirty(inventory)
		end

		-- Публикуем событие об изменении инвентаря
		self.eventEmitter:emit("EntityUpdated", {
			entityType = "Inventory",
			entityId = tostring(player.UserId),
			changes = {
				inventory = true,
				itemName = itemName,
				action = "updated",
			},
		})
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
