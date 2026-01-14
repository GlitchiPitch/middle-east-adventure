-- Пример использования Unit of Work паттерна и событийной системы
-- Этот файл демонстрирует, как использовать новые паттерны в коде

---@class EquipItemExample
---@field diContainer DIContainer
local EquipItemExample = {}
EquipItemExample.__index = EquipItemExample

---@param diContainer DIContainer
---@return EquipItemExample
function EquipItemExample.new(diContainer)
	local self = setmetatable({}, EquipItemExample)
	self.diContainer = diContainer
	return self
end

function EquipItemExample:init()
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.unitOfWork = infrastructure.unitOfWork
	self.inventoryRepository = infrastructure.inventoryRepository
	self.equipmentRepository = infrastructure.equipmentRepository
end

--- Пример комплексной операции с использованием Unit of Work
--- Экипировка предмета: снимаем из инвентаря и надеваем на персонажа
---@param player Player
---@param itemName string
---@param slot string
function EquipItemExample:equipItem(player, itemName, slot)
	-- Начинаем транзакцию
	self.unitOfWork:beginTransaction()

	local success = false
	local errorMessage = ""

	local successTransaction, transactionError = pcall(function()
		-- Проверяем, есть ли предмет в инвентаре
		local item = self.inventoryRepository:getItem(player, itemName)
		if not item then
			error("Предмет '" .. itemName .. "' не найден в инвентаре")
		end

		if item.amount < 1 then
			error("Недостаточно предметов в инвентаре")
		end

		-- Удаляем предмет из инвентаря
		self.inventoryRepository:removeItem(player, itemName, 1)

		-- Экипируем предмет
		self.equipmentRepository:equipItem(player, itemName, slot)

		success = true
	end)

	if not successTransaction then
		errorMessage = transactionError
	end

	if success then
		-- Фиксируем изменения
		self.unitOfWork:commit()
		print("Предмет '" .. itemName .. "' успешно экипирован в слот '" .. slot .. "'")
	else
		-- Откатываем изменения при ошибке
		self.unitOfWork:rollback()
		error("Ошибка при экипировке предмета: " .. errorMessage)
	end
end

--- Пример использования кеша с автоматической инвалидацией
---@param player Player
---@param itemName string
function EquipItemExample:getCachedInventoryItem(player, itemName)
	---@type SharedInfrastructure
	local sharedInfra = self.diContainer:resolve("Shared")
	local cache = sharedInfra.cache

	local cacheKey = "Inventory:" .. player.UserId .. ":" .. itemName

	-- Пытаемся получить из кеша
	local cachedItem = cache:get(cacheKey)
	if cachedItem then
		print("Получено из кеша: " .. itemName)
		return cachedItem
	end

	-- Если нет в кеше, получаем из репозитория
	local item = self.inventoryRepository:getItem(player, itemName)
	if item then
		-- Сохраняем в кеш на 5 минут
		cache:set(cacheKey, item, 300)
		print("Сохранено в кеш: " .. itemName)
	end

	return item
end

return EquipItemExample
