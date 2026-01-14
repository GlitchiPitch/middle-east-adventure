---@class ServerSetEquipmentSlot
---@field equipmentRepository ServerEquipmentRepository
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local SetEquipmentSlot = {}
SetEquipmentSlot.__index = SetEquipmentSlot

---@param diContainer DIContainer
---@return ServerSetEquipmentSlot
function SetEquipmentSlot.new(diContainer)
	local self = setmetatable({}, SetEquipmentSlot)
	self.diContainer = diContainer
	return self
end

function SetEquipmentSlot:init()
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
---@param itemName string
---@param slotKey string
function SetEquipmentSlot:execute(player, itemName, slotKey)
	local playerEntity = self.playerService:getPlayerEntity(player)
	self.equipmentRepository:setSlot(playerEntity, itemName, slotKey)
	self.playerService:updatePlayerData(player)
end

return SetEquipmentSlot
