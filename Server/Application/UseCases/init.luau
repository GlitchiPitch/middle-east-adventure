---@class ServerUpdatePlayerData
---@field remoteEventService RemoteEventService
---@field playerService ServerPlayerService
---@field constants Constants
local UpdatePlayerData = {}
UpdatePlayerData.__index = UpdatePlayerData

---@param remoteEventService RemoteEventService
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerUpdatePlayerData
function UpdatePlayerData.new(remoteEventService, playerService, constants)
	local self = setmetatable({}, UpdatePlayerData)
	self.remoteEventService = remoteEventService
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
function UpdatePlayerData:execute(player)
	local playerData = self.playerService:getPlayerData(player)
	warn(playerData)
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.UPDATE_PLAYER_DATA,
		data = playerData,
	})
end

---@class ServerUseCases
---@field diContainer DIContainer
local UseCases = {}
UseCases.__index = UseCases

---@param diContainer DIContainer
---@return ServerUseCases
function UseCases.new(diContainer)
	local self = setmetatable({}, UseCases)
	self.diContainer = diContainer
	return self
end

function UseCases:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")

	self.updatePlayerData =
		UpdatePlayerData.new(shared.remoteEventService, application.services.playerService, shared.constants)
end

return UseCases
