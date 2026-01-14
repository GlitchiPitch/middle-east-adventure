---@class Cache
---@field _cache table
---@field eventEmitter EventEmitter
---@field diContainer DIContainer
local Cache = {}
Cache.__index = Cache

---@param diContainer DIContainer
---@return Cache
function Cache.new(diContainer)
	local self = setmetatable({}, Cache)
	self.diContainer = diContainer
	self._cache = {}
	return self
end

function Cache:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.eventEmitter = shared.infrastructure.eventEmitter
	-- Подписываемся на события для автоматической инвалидации кеша
	self.eventEmitter:on("EntityUpdated", function(data)
		self:_handleEntityUpdate(data)
	end)

	self.eventEmitter:on("EntityDeleted", function(data)
		self:_handleEntityDelete(data)
	end)

	self.eventEmitter:on("EntityCreated", function(data)
		self:_handleEntityCreate(data)
	end)
end

--- Сохраняет значение в кеш
---@param key string
---@param value any
---@param ttl number? -- время жизни в секундах
function Cache:set(key, value, ttl)
	self._cache[key] = {
		value = value,
		timestamp = os.time(),
		ttl = ttl,
	}
end

--- Получает значение из кеша
---@param key string
---@return any
function Cache:get(key)
	local entry = self._cache[key]
	if not entry then
		return nil
	end

	-- Проверяем TTL
	if entry.ttl and (os.time() - entry.timestamp) > entry.ttl then
		self._cache[key] = nil
		return nil
	end

	return entry.value
end

--- Удаляет значение из кеша
---@param key string
function Cache:delete(key)
	self._cache[key] = nil
end

--- Очищает весь кеш
function Cache:clear()
	self._cache = {}
end

--- Инвалидирует кеш для конкретной сущности
---@param entityType string
---@param entityId string|number
function Cache:invalidateEntity(entityType, entityId)
	local prefix = entityType .. ":" .. tostring(entityId) .. ":"

	-- Удаляем все ключи, начинающиеся с префикса
	for key in pairs(self._cache) do
		if string.sub(key, 1, #prefix) == prefix then
			self._cache[key] = nil
		end
	end
end

--- Инвалидирует кеш для связанных сущностей
---@param entityType string
---@param entityId string|number
---@param changes table
function Cache:invalidateRelatedEntities(entityType, entityId, changes)
	-- Инвалидируем кеш основной сущности
	self:invalidateEntity(entityType, entityId)

	-- Инвалидируем связанные сущности
	if entityType == "Player" then
		-- При изменении игрока инвалидируем связанные данные
		if changes.stats then
			self:invalidateEntity("Stats", entityId)
		end
		if changes.inventory then
			self:invalidateEntity("Inventory", entityId)
		end
		if changes.equipment then
			self:invalidateEntity("Equipment", entityId)
		end
		if changes.attributes then
			self:invalidateEntity("Attributes", entityId)
		end
		if changes.skills then
			self:invalidateEntity("Skills", entityId)
		end
	elseif entityType == "Inventory" and changes.itemName then
		-- При изменении предмета в инвентаре инвалидируем кеш предметов
		local itemKey = "Item:" .. changes.itemName .. ":*"
		for key in pairs(self._cache) do
			if string.match(key, "^Item:" .. changes.itemName .. ":") then
				self._cache[key] = nil
			end
		end
	end
end

--- Обработчик события обновления сущности
---@param data EntityEventData
function Cache:_handleEntityUpdate(data)
	print(string.format("Cache: Invalidating cache for %s:%s", data.entityType, data.entityId))
	self:invalidateRelatedEntities(data.entityType, data.entityId, data.changes or {})
end

--- Обработчик события удаления сущности
---@param data EntityEventData
function Cache:_handleEntityDelete(data)
	print(string.format("Cache: Deleting cache for %s:%s", data.entityType, data.entityId))
	self:invalidateEntity(data.entityType, data.entityId)
end

--- Обработчик события создания сущности
---@param data EntityEventData
function Cache:_handleEntityCreate(data)
	print(string.format("Cache: New entity created %s:%s", data.entityType, data.entityId))
	-- Для новых сущностей кеш обычно не инвалидируется, но можно добавить логику
end

return Cache
