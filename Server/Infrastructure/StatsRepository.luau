---@class ServerStatsRepository
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
local StatsRepository = {}
StatsRepository.__index = StatsRepository

---@param diContainer DIContainer
---@return ServerStatsRepository
function StatsRepository.new(diContainer)
	local self = setmetatable({}, StatsRepository)
	self.diContainer = diContainer
	return self
end

function StatsRepository:init()
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.playerRepository
end

---@param player Player
---@return StatsEntity
function StatsRepository:getStats(player)
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	return playerEntity:getStats()
end

---@param player Player
---@param statName string
---@param value number
function StatsRepository:updateStat(player, statName, value)
	local stats = self:getStats(player)

	if stats[statName] and typeof(stats[statName]) == "table" then
		stats[statName].current = math.clamp(value, 0, stats[statName].max)
	elseif typeof(stats[statName]) == "boolean" then
		stats[statName] = value
	end
end

---@param player Player
---@param statName string
---@param amount number
function StatsRepository:heal(player, statName, amount)
	local stats = self:getStats(player)

	if stats[statName] and typeof(stats[statName]) == "table" then
		stats[statName].current = math.min(stats[statName].current + amount, stats[statName].max)
	end
end

---@param player Player
---@param statName string
---@param amount number
function StatsRepository:damage(player, statName, amount)
	local stats = self:getStats(player)

	if stats[statName] and typeof(stats[statName]) == "table" then
		stats[statName].current = math.max(stats[statName].current - amount, 0)
	end
end

---@param player Player
---@param statName string
---@return table
function StatsRepository:getStat(player, statName)
	local stats = self:getStats(player)
	return stats[statName]
end

---@param player Player
function StatsRepository:resetStats(player)
	local stats = self:getStats(player)

	-- Reset numeric stats to max
	for statName, statData in pairs(stats) do
		if typeof(statData) == "table" and statData.max then
			statData.current = statData.max
		end
	end

	-- Reset effects
	stats.weak = false
	stats.posioned = false
	stats.frosted = false
	stats.fired = false
end

---@param player Player
---@param effectName string
---@param state boolean
function StatsRepository:setEffect(player, effectName, state)
	local stats = self:getStats(player)
	stats[effectName] = state
end

return StatsRepository
