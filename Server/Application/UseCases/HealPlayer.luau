---@class ServerHealPlayer
---@field statsRepository ServerStatsRepository
---@field playerService ServerPlayerService
---@field constants Constants
local HealPlayer = {}
HealPlayer.__index = HealPlayer

---@param statsRepository ServerStatsRepository
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerHealPlayer
function HealPlayer.new(statsRepository, playerService, constants)
	local self = setmetatable({}, HealPlayer)
	self.statsRepository = statsRepository
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
---@param statName string
---@param amount number
function HealPlayer:execute(player, statName, amount)
	self.statsRepository:heal(player, statName, amount)
	self.playerService:updatePlayerData(player)
end

return HealPlayer