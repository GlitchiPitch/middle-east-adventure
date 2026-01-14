---@class ServerUpdatePlayerData
---@field remoteEventService RemoteEventService
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local UpdatePlayerData = {}
UpdatePlayerData.__index = UpdatePlayerData

---@param diContainer DIContainer
---@return ServerUpdatePlayerData
function UpdatePlayerData.new(diContainer)
	local self = setmetatable({}, UpdatePlayerData)
	self.diContainer = diContainer
	return self
end

function UpdatePlayerData:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")

	self.remoteEventService = shared.remoteEventService
	self.playerService = application.services.playerService
	self.constants = shared.constants
end

---@param player Player
function UpdatePlayerData:execute(player)
	local playerData = self.playerService:getPlayerData(player)
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.UPDATE_PLAYER_DATA,
		data = playerData,
	})
end

return UpdatePlayerData
