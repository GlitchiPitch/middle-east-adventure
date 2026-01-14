---@class ServerHealPlayer
---@field statsRepository ServerStatsRepository
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local HealPlayer = {}
HealPlayer.__index = HealPlayer

---@param diContainer DIContainer
---@return ServerHealPlayer
function HealPlayer.new(diContainer)
	local self = setmetatable({}, HealPlayer)
	self.diContainer = diContainer
	return self
end

function HealPlayer:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")

	self.statsRepository = infrastructure.statsRepository
	self.playerService = application.services.playerService
	self.constants = shared.constants
end

---@param player Player
---@param statName string
---@param amount number
function HealPlayer:execute(player, statName, amount)
	local playerEntity = self.playerService:getPlayerEntity(player)
	self.statsRepository:heal(playerEntity, statName, amount)
	self.playerService:updatePlayerData(player)
end

return HealPlayer