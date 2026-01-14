---@class ServerLevelUpPlayer
---@field attributesRepository ServerAttributesRepository
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local LevelUpPlayer = {}
LevelUpPlayer.__index = LevelUpPlayer

---@param diContainer DIContainer
---@return ServerLevelUpPlayer
function LevelUpPlayer.new(diContainer)
	local self = setmetatable({}, LevelUpPlayer)
	self.diContainer = diContainer
	return self
end

function LevelUpPlayer:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")

	self.attributesRepository = infrastructure.attributesRepository
	self.playerService = application.services.playerService
	self.constants = shared.constants
end

---@param player Player
function LevelUpPlayer:execute(player)
	local playerEntity = self.playerService:getPlayerEntity(player)
	self.attributesRepository:levelUp(playerEntity)
	self.playerService:updatePlayerData(player)
end

return LevelUpPlayer