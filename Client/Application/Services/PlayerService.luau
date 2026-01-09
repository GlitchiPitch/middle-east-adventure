---@class ClientApplicationPlayerService
---@field diContainer DIContainer
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ClientApplicationPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable({}, PlayerService)
	self.diContainer = diContainer
	return self
end

function PlayerService:callUpdatePlayerData()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	local remoteEventService = shared.remoteEventService

	remoteEventService:fireServer({
		eventName = shared.constants.REMOTE_EVENTS.UPDATE_PLAYER_DATA,
		data = {},
	})
end

---@param newData table
function PlayerService:updatePlayerData(newData)
	warn(newData)
	---@type ClientInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type SharedDomain
	local domain = self.diContainer:resolve("Domain")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	newData.inventory = domain.Inventory.new(newData.inventory)
	newData.skills = domain.Skills.new(newData.skills)
	newData.stats = domain.Stats.new(newData.stats)
	newData.equipment = domain.Equipment.new()

	infrastructure.playerRepository:updatePlayerEntity(newData)
	shared.eventBus:fire("updatePlayerData")
end

---@return PlayerEntity
function PlayerService:getPlayerEntity()
	---@type ClientInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	local playerEntity = infrastructure.playerRepository:getPlayerEntity()
	return playerEntity
end

---@return playerStateEnum
function PlayerService:getPlayerState()
	local playerEntity = self:getPlayerEntity()
	return playerEntity.state
end

---@param state playerStateEnum
function PlayerService:setPlayerState(state)
	local playerEntity = self:getPlayerEntity()
	playerEntity.state = state
end

---@return EquipmentEntity
function PlayerService:getPlayerEquipment()
	local playerEntity = self:getPlayerEntity()
	return playerEntity.equipment
end

---@param state boolean
function PlayerService:toggleRobloxControl(state)
	local playerEntity = self:getPlayerEntity()
	playerEntity:toggleRobloxControl(state)
end

return PlayerService
