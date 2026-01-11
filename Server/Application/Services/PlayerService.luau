---@class ServerApplicationPlayerService
---@field diContainer DIContainer
---@field playerRepository PlayerRepository
---@field remoteEventService RemoteEventService
---@field constants Constants
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ServerApplicationPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable({}, PlayerService)
	self.diContainer = diContainer
	return self
end

function PlayerService:init()
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")

	self.constants = shared.constants
	self.remoteEventService = shared.remoteEventService
	self.playerRepository = infrastructure.playerRepository
	self.ragdollHandler = application.handlers.ragdoll
end

---@param player Player
function PlayerService:onPlayerAdded(player)
	---@param character Model
	local function onCharacterAdded(character)
		local playerEntity = self.playerRepository:getPlayerEntity(player)
		self.ragdollHandler:setRagdollToCharacter(character)
		self.remoteEventService:fireClient(player, {
			eventName = self.constants.REMOTE_EVENTS.UPDATE_PLAYER_DATA,
			data = playerEntity:toData(),
		})
	end

	self.playerRepository:onPlayerAdded(player)
	player.CharacterAdded:Connect(onCharacterAdded)
end

---@param player Player
function PlayerService:onPlayerRemoving(player)
	self.playerRepository:onPlayerRemoving(player)
end

---@param player Player
---@return table
function PlayerService:getPlayerData(player)
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	return playerEntity:toData()
end

---@param player Player
---@return PlayerEntity
function PlayerService:getPlayerEntity(player)
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	return playerEntity
end

return PlayerService
