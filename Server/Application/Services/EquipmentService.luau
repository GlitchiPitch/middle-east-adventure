---@class ServerEquipmentService
---@field diContainer DIContainer
---@field playerService ServerPlayerService
---@field toolService ServerToolService
local EquipmentService = {}
EquipmentService.__index = EquipmentService

---@param diContainer DIContainer
---@return ServerEquipmentService
function EquipmentService.new(diContainer)
	local self = setmetatable({}, EquipmentService)
	self.diContainer = diContainer
	return self
end

function EquipmentService:init()
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.sharedData = shared.data
	self.playerService = application.services.playerService
	self.toolService = application.services.toolService
end

---@param player Player
---@param command EquipItemCommand
function EquipmentService:equipItem(player, command)
	local playerEntity = self.playerService:getPlayerEntity(player)
	if playerEntity.equipment.slots[command.slotIndex] then
		if playerEntity.equipment.equippedItem then
			playerEntity.equipment:equipItem(nil)
		else
			playerEntity.equipment:equipItem(playerEntity.equipment.slots[command.slotIndex])
		end

		self:_setToolToPlayer(playerEntity)
	end
end

---@param player Player
---@param itemData table
function EquipmentService:setPlayerSlot(player, itemData)
	local playerEntity = self.playerService:getPlayerEntity(player)
	playerEntity.equipment:setSlot(itemData)
end

---@param playerEntity PlayerEntity
function EquipmentService:_setToolToPlayer(playerEntity)
	if playerEntity.equipment.equippedItem then
		self.toolService:equipItem(playerEntity)
	else
		self.toolService:unequipItem(playerEntity)
	end
end

function EquipmentService:useFood()
	
end

return EquipmentService
