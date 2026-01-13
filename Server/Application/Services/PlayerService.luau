---@class ServerPlayerService
---@field diContainer DIContainer
---@field playerRepository PlayerRepository
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field useCases ServerUseCases
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ServerPlayerService
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
	self.useCases = application.useCases
end

---@param player Player
function PlayerService:onPlayerAdded(player)
	---@param character Model
	local function onCharacterAdded(character)
		self.ragdollHandler:setRagdollToCharacter(character)
		self:updatePlayerData(player)

		-- crook
		player.Backpack.ChildAdded:Connect(function(child)
			child:Destroy()
		end)
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

function PlayerService:getPlayers()
	return self.playerRepository._players
end

function PlayerService:updatePlayerData(player)
	self.useCases.updatePlayerData:execute(player)
end

return PlayerService
