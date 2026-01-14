local Interfaces = require(script.Parent.Interfaces)
local IRepository = Interfaces.IRepository

---@class StatsRepository : IRepository
---@field playerRepository IPlayerRepository
---@field statCache table
---@field cacheExpiry number
local StatsRepository = setmetatable({}, { __index = IRepository })
StatsRepository.__index = StatsRepository

---@param diContainer DIContainer
---@return StatsRepository
function StatsRepository.new(diContainer)
	local self = setmetatable(IRepository.new(diContainer), StatsRepository)
	self.statCache = {}
	self.cacheExpiry = 0.05 -- 50ms cache expiry for stats (more frequent updates)
	return self
end

function StatsRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.playerRepository = shared.infrastructure.repositories.playerRepository
end

--- Внутренний метод для получения кешированного или свежего значения
---@param playerEntity PlayerEntity
---@param statName string
---@param cache table
---@param getter function
---@return any
function StatsRepository:_getCachedStat(playerEntity, statName, cache, getter)
	local playerId = playerEntity.id or tostring(playerEntity)
	local cacheKey = playerId .. "_" .. statName
	local currentTime = tick()

	-- Check if we have cached value and it's not expired
	if cache[cacheKey] and (currentTime - cache[cacheKey].timestamp) < self.cacheExpiry then
		return cache[cacheKey].value
	end

	-- Get fresh value and cache it
	local value = getter(self, playerEntity, statName)
	cache[cacheKey] = {
		value = value,
		timestamp = currentTime,
	}

	return value
end

--- Очистка кеша для конкретного игрока
---@param playerEntity PlayerEntity
function StatsRepository:invalidateCache(playerEntity)
	local playerId = playerEntity.id or tostring(playerEntity)
	-- Remove all cache entries for this player
	for key in pairs(self.statCache) do
		if key:sub(1, #playerId) == playerId then
			self.statCache[key] = nil
		end
	end
end

---@param playerEntity PlayerEntity
---@return StatsEntity
function StatsRepository:getStats(playerEntity)
	return playerEntity.stats
end

---@param playerEntity PlayerEntity
---@param statName string
---@param value number
function StatsRepository:updateStat(playerEntity, statName, value)
	local stats = self:getStats(playerEntity)

	if stats[statName] and typeof(stats[statName]) == "table" then
		stats[statName].current = math.clamp(value, 0, stats[statName].max)
	elseif typeof(stats[statName]) == "boolean" then
		stats[statName] = value
	end

	-- Invalidate cache for this stat
	self:invalidateCache(playerEntity)
end

---@param playerEntity PlayerEntity
---@param statName string
---@param amount number
function StatsRepository:heal(playerEntity, statName, amount)
	local stats = self:getStats(playerEntity)

	if stats[statName] and typeof(stats[statName]) == "table" then
		stats[statName].current = math.min(stats[statName].current + amount, stats[statName].max)
	end

	-- Invalidate cache for this stat
	self:invalidateCache(playerEntity)
end

---@param playerEntity PlayerEntity
---@param statName string
---@param amount number
function StatsRepository:damage(playerEntity, statName, amount)
	local stats = self:getStats(playerEntity)

	if stats[statName] and typeof(stats[statName]) == "table" then
		stats[statName].current = math.max(stats[statName].current - amount, 0)
	end

	-- Invalidate cache for this stat
	self:invalidateCache(playerEntity)
end

---@param playerEntity PlayerEntity
---@param statName string
---@return table
function StatsRepository:getStat(playerEntity, statName)
	return self:_getCachedStat(playerEntity, statName, self.statCache, function(repo, player, stat)
		local stats = repo:getStats(player)
		return stats[stat]
	end)
end

---@param playerEntity PlayerEntity
function StatsRepository:resetStats(playerEntity)
	local stats = self:getStats(playerEntity)

	-- Reset numeric stats to max
	for statName, statData in pairs(stats) do
		if typeof(statData) == "table" and statData.max then
			statData.current = statData.max
		end
		-- statName is used for iteration, no need for explicit usage
	end

	-- Reset effects
	stats.weak = false
	stats.posioned = false
	stats.frosted = false
	stats.fired = false

	-- Invalidate cache since all stats changed
	self:invalidateCache(playerEntity)
end

---@param playerEntity PlayerEntity
---@param effectName string
---@param state boolean
function StatsRepository:setEffect(playerEntity, effectName, state)
	local stats = self:getStats(playerEntity)
	stats[effectName] = state

	-- Invalidate cache for this effect
	self:invalidateCache(playerEntity)
end

return StatsRepository
