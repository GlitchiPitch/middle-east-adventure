---@class ServerUpdateStat
---@field statsRepository ServerStatsRepository
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local UpdateStat = {}
UpdateStat.__index = UpdateStat

---@param diContainer DIContainer
---@return ServerUpdateStat
function UpdateStat.new(diContainer)
	local self = setmetatable({}, UpdateStat)
	self.diContainer = diContainer
	return self
end

function UpdateStat:init()
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
---@param value number
function UpdateStat:execute(player, statName, value)
	local playerEntity = self.playerService:getPlayerEntity(player)
	self.statsRepository:updateStat(playerEntity, statName, value)
	self.playerService:updatePlayerData(player)
end

return UpdateStat