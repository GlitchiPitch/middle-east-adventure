local Interfaces = require(script.Parent.Interfaces)
local IRepository = Interfaces.IRepository

---@class StatsRepository : IRepository
---@field playerRepository IPlayerRepository
---@field statCache table
---@field cacheExpiry number
---@field maxCacheSize number
local StatsRepository = setmetatable({}, { __index = IRepository })
StatsRepository.__index = StatsRepository

---@param diContainer DIContainer
---@return StatsRepository
function StatsRepository.new(diContainer)
	local self = setmetatable(IRepository.new(diContainer), StatsRepository)
	self.statCache = {}
	self.cacheExpiry = 0.05 -- 50ms cache expiry for stats (more frequent updates)
	self.maxCacheSize = 1000 -- Maximum number of cached entries
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

	-- Manage cache size after adding new entry
	self:_manageCacheSize()

	return value
end

--- Очистка кеша для конкретного игрока
---@param playerEntity PlayerEntity
function StatsRepository:invalidateCache(playerEntity)
	local playerId = playerEntity.id or tostring(playerEntity)
	-- Remove all cache entries for this player
	for key in pairs(self.statCache) do
		if key:sub(1, #playerId + 1) == playerId .. "_" then
			self.statCache[key] = nil
		end
	end
end

--- Очистка всего кеша
function StatsRepository:clearCache()
	self.statCache = {}
end

--- Управление размером кеша
function StatsRepository:_manageCacheSize()
	local cacheSize = 0
	for _ in pairs(self.statCache) do
		cacheSize = cacheSize + 1
	end

	-- If cache is too large, remove oldest entries
	if cacheSize > self.maxCacheSize then
		local currentTime = tick()
		local entriesToRemove = {}

		-- Collect entries that are expired or oldest
		for key, entry in pairs(self.statCache) do
			if currentTime - entry.timestamp > self.cacheExpiry then
				table.insert(entriesToRemove, key)
			end
		end

		-- Remove expired entries first
		for _, key in ipairs(entriesToRemove) do
			self.statCache[key] = nil
			cacheSize = cacheSize - 1
		end

		-- If still too large, remove more entries (oldest first)
		if cacheSize > self.maxCacheSize then
			local sortedEntries = {}
			for key, entry in pairs(self.statCache) do
				table.insert(sortedEntries, { key = key, timestamp = entry.timestamp })
			end

			table.sort(sortedEntries, function(a, b)
				return a.timestamp < b.timestamp
			end)

			local toRemove = cacheSize - self.maxCacheSize
			for i = 1, math.min(toRemove, #sortedEntries) do
				self.statCache[sortedEntries[i].key] = nil
			end
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
	-- Validation
	if not playerEntity then
		error("playerEntity is required")
	end
	if not statName or statName == "" then
		error("statName is required and cannot be empty")
	end
	if value == nil then
		error("value is required")
	end

	local stats = self:getStats(playerEntity)
	if not stats then
		error("Failed to get stats for player")
	end

	if not stats[statName] then
		error(string.format("Stat '%s' does not exist", statName))
	end

	if stats[statName] and typeof(stats[statName]) == "table" then
		if typeof(value) ~= "number" then
			error("value must be a number for stat objects")
		end
		stats[statName].current = math.clamp(value, 0, stats[statName].max)
	elseif typeof(stats[statName]) == "boolean" then
		if typeof(value) ~= "boolean" then
			error("value must be a boolean for boolean stats")
		end
		stats[statName] = value
	else
		error(string.format("Unsupported stat type for '%s'", statName))
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
	for _, statData in pairs(stats) do
		if typeof(statData) == "table" and statData.max then
			statData.current = statData.max
		end
	end

	-- Reset effects
	stats.weak = false
	stats.poisoned = false
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
