---@class UnitOfWork
---@field diContainer DIContainer
---@field _newEntities table
---@field _dirtyEntities table
---@field _deletedEntities table
---@field _inTransaction boolean
local UnitOfWork = {}
UnitOfWork.__index = UnitOfWork

---@param diContainer DIContainer
---@return UnitOfWork
function UnitOfWork.new(diContainer)
	local self = setmetatable({}, UnitOfWork)
	self.diContainer = diContainer
	self._newEntities = {}
	self._dirtyEntities = {}
	self._deletedEntities = {}
	self._inTransaction = false
	return self
end

--- Начинает транзакцию
function UnitOfWork:beginTransaction()
	if self._inTransaction then
		error("Transaction already in progress")
	end
	self._inTransaction = true
	self._newEntities = {}
	self._dirtyEntities = {}
	self._deletedEntities = {}
end

--- Фиксирует изменения в транзакции
function UnitOfWork:commit()
	if not self._inTransaction then
		error("No active transaction")
	end

	-- Здесь можно добавить логику сохранения данных
	-- Для простоты пока оставим пустым, так как сохранение уже происходит в репозиториях

	self._inTransaction = false
	self._newEntities = {}
	self._dirtyEntities = {}
	self._deletedEntities = {}
end

--- Откатывает изменения в транзакции
function UnitOfWork:rollback()
	if not self._inTransaction then
		error("No active transaction")
	end

	-- Восстанавливаем состояние сущностей из оригиналов
	-- Для простоты реализации, пока оставим пустым
	-- В реальной реализации нужно хранить оригинальные состояния

	self._inTransaction = false
	self._newEntities = {}
	self._dirtyEntities = {}
	self._deletedEntities = {}
end

--- Регистрирует новую сущность
---@param entity table
function UnitOfWork:registerNew(entity)
	if not self._inTransaction then
		error("No active transaction")
	end
	table.insert(self._newEntities, entity)
end

--- Регистрирует измененную сущность
---@param entity table
function UnitOfWork:registerDirty(entity)
	if not self._inTransaction then
		error("No active transaction")
	end
	table.insert(self._dirtyEntities, entity)
end

--- Регистрирует удаленную сущность
---@param entity table
function UnitOfWork:registerDeleted(entity)
	if not self._inTransaction then
		error("No active transaction")
	end
	table.insert(self._deletedEntities, entity)
end

--- Возвращает все зарегистрированные новые сущности
---@return table
function UnitOfWork:getNewEntities()
	return self._newEntities
end

--- Возвращает все зарегистрированные измененные сущности
---@return table
function UnitOfWork:getDirtyEntities()
	return self._dirtyEntities
end

--- Возвращает все зарегистрированные удаленные сущности
---@return table
function UnitOfWork:getDeletedEntities()
	return self._deletedEntities
end

--- Проверяет, активна ли транзакция
---@return boolean
function UnitOfWork:isInTransaction()
	return self._inTransaction
end

return UnitOfWork
