---@class ServerUnequipItem
---@field equipmentRepository ServerEquipmentRepository
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local UnequipItem = {}
UnequipItem.__index = UnequipItem

---@param diContainer DIContainer
---@return ServerUnequipItem
function UnequipItem.new(diContainer)
	local self = setmetatable({}, UnequipItem)
	self.diContainer = diContainer
	return self
end

function UnequipItem:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")

	self.equipmentRepository = infrastructure.equipmentRepository
	self.playerService = application.services.playerService
	self.constants = shared.constants
end

---@param player Player
---@param slot string
function UnequipItem:execute(player, slot)
	local playerEntity = self.playerService:getPlayerEntity(player)
	self.equipmentRepository:unequipItem(playerEntity, slot)
	self.playerService:updatePlayerData(player)
end

return UnequipItem
