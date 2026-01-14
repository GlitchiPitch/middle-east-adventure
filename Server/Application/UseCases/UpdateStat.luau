---@class ServerUpdateStat
---@field statsRepository ServerStatsRepository
---@field playerService ServerPlayerService
---@field constants Constants
local UpdateStat = {}
UpdateStat.__index = UpdateStat

---@param statsRepository ServerStatsRepository
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerUpdateStat
function UpdateStat.new(statsRepository, playerService, constants)
	local self = setmetatable({}, UpdateStat)
	self.statsRepository = statsRepository
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
---@param statName string
---@param value number
function UpdateStat:execute(player, statName, value)
	self.statsRepository:updateStat(player, statName, value)
	self.playerService:updatePlayerData(player)
end

return UpdateStat