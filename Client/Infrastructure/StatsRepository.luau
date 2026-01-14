---@class ClientStatsRepository
---@field diContainer DIContainer
---@field playerRepository ClientPlayerRepository
local StatsRepository = {}
StatsRepository.__index = StatsRepository

---@param diContainer DIContainer
---@return ClientStatsRepository
function StatsRepository.new(diContainer)
    local self = setmetatable({}, StatsRepository)
    self.diContainer = diContainer
    return self
end

function StatsRepository:init()
	---@type ClientInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.playerRepository
end

---@return StatsEntity
function StatsRepository:getStats()
    local playerEntity = self.playerRepository:getPlayerEntity()
    return playerEntity:getStats()
end

---@param statName string
---@param value number
function StatsRepository:updateStat(statName, value)
    -- Client-side implementation - would typically use RemoteEvent
    local stats = self:getStats()

    if stats[statName] and typeof(stats[statName]) == "table" then
        stats[statName].current = math.clamp(value, 0, stats[statName].max)
    elseif typeof(stats[statName]) == "boolean" then
        stats[statName] = value
    end
end

---@param statName string
---@param amount number
function StatsRepository:heal(statName, amount)
    local stats = self:getStats()

    if stats[statName] and typeof(stats[statName]) == "table" then
        stats[statName].current = math.min(stats[statName].current + amount, stats[statName].max)
    end
end

---@param statName string
---@param amount number
function StatsRepository:damage(statName, amount)
    local stats = self:getStats()

    if stats[statName] and typeof(stats[statName]) == "table" then
        stats[statName].current = math.max(stats[statName].current - amount, 0)
    end
end

---@param statName string
---@return table
function StatsRepository:getStat(statName)
    local stats = self:getStats()
    return stats[statName]
end

function StatsRepository:resetStats()
    local stats = self:getStats()

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

---@param effectName string
---@param state boolean
function StatsRepository:setEffect(effectName, state)
    local stats = self:getStats()
    stats[effectName] = state
end

return StatsRepository