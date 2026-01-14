local Interfaces = require(script.Parent.Interfaces)
local IRepository = Interfaces.IRepository

---@class AttributesRepository : IRepository
---@field playerRepository IPlayerRepository
---@field levelCache table
---@field expCache table
---@field cacheExpiry number
local AttributesRepository = setmetatable({}, { __index = IRepository })
AttributesRepository.__index = AttributesRepository

---@param diContainer DIContainer
---@return AttributesRepository
function AttributesRepository.new(diContainer)
	local self = setmetatable(IRepository.new(diContainer), AttributesRepository)
	self.levelCache = {}
	self.expCache = {}
	self.cacheExpiry = 0.1 -- 100ms cache expiry
	return self
end

function AttributesRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.playerRepository = shared.infrastructure.repositories.playerRepository
end

--- Внутренний метод для получения кешированного или свежего значения
---@param playerEntity PlayerEntity
---@param cache table
---@param getter function
---@return any
function AttributesRepository:_getCachedValue(playerEntity, cache, getter)
	local playerId = playerEntity.id or tostring(playerEntity)
	local currentTime = tick()

	-- Check if we have cached value and it's not expired
	if cache[playerId] and (currentTime - cache[playerId].timestamp) < self.cacheExpiry then
		return cache[playerId].value
	end

	-- Get fresh value and cache it
	local value = getter(self, playerEntity)
	cache[playerId] = {
		value = value,
		timestamp = currentTime,
	}

	return value
end

--- Очистка кеша для конкретного игрока
---@param playerEntity PlayerEntity
function AttributesRepository:invalidateCache(playerEntity)
	local playerId = playerEntity.id or tostring(playerEntity)
	self.levelCache[playerId] = nil
	self.expCache[playerId] = nil
end

---@param playerEntity PlayerEntity
---@return AttributesEntity
function AttributesRepository:getAttributes(playerEntity)
	return playerEntity.attributes
end

---@param playerEntity PlayerEntity
---@param attributeName string
---@param value number
function AttributesRepository:updateAttribute(playerEntity, attributeName, value)
	local attributes = self:getAttributes(playerEntity)
	attributes[attributeName] = value
end

---@param playerEntity PlayerEntity
---@param expAmount number
function AttributesRepository:addExp(playerEntity, expAmount)
	local attributes = self:getAttributes(playerEntity)
	attributes.exp.exp = attributes.exp.exp + expAmount
	attributes.exp.expPoints = attributes.exp.expPoints + expAmount

	-- Invalidate cache since exp changed
	self:invalidateCache(playerEntity)

	-- Check for level up (simplified logic)
	local expNeeded = attributes.exp.level * 100 -- Example formula
	if attributes.exp.expPoints >= expNeeded then
		self:levelUp(playerEntity)
	end
end

---@param playerEntity PlayerEntity
function AttributesRepository:levelUp(playerEntity)
	local attributes = self:getAttributes(playerEntity)
	attributes.exp.level = attributes.exp.level + 1
	attributes.exp.expPoints = attributes.exp.expPoints - (attributes.exp.level * 100)

	-- Invalidate cache since level changed
	self:invalidateCache(playerEntity)
end

---@param playerEntity PlayerEntity
---@param attributeName string
---@return number
function AttributesRepository:getAttribute(playerEntity, attributeName)
	local attributes = self:getAttributes(playerEntity)
	return attributes[attributeName]
end

---@param playerEntity PlayerEntity
---@return number
function AttributesRepository:getLevel(playerEntity)
	return self:_getCachedValue(playerEntity, self.levelCache, function(repo, player)
		local attributes = repo:getAttributes(player)
		return attributes.exp.level
	end)
end

---@param playerEntity PlayerEntity
---@return number
function AttributesRepository:getExp(playerEntity)
	return self:_getCachedValue(playerEntity, self.expCache, function(repo, player)
		local attributes = repo:getAttributes(player)
		return attributes.exp.exp
	end)
end

---@param playerEntity PlayerEntity
---@param defenseType string
---@param value number
function AttributesRepository:updateDefense(playerEntity, defenseType, value)
	local attributes = self:getAttributes(playerEntity)
	if attributes.defense then
		attributes.defense[defenseType] = value
	end
end

return AttributesRepository
