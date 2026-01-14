---@class ServerEquipItem
---@field equipmentRepository ServerEquipmentRepository
---@field toolService ServerToolService
---@field playerService ServerPlayerService
---@field constants Constants
local EquipItem = {}
EquipItem.__index = EquipItem

---@param equipmentRepository ServerEquipmentRepository
---@param toolService ServerToolService
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerEquipItem
function EquipItem.new(equipmentRepository, toolService, playerService, constants)
	local self = setmetatable({}, EquipItem)
	self.equipmentRepository = equipmentRepository
	self.toolService = toolService
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
---@param command EquipItemCommand
function EquipItem:execute(player, command)
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

---@param playerEntity PlayerEntity
function EquipItem:_setToolToPlayer(playerEntity)
	if playerEntity.equipment.equippedItem then
		self.toolService:equipItem(playerEntity)
	else
		self.toolService:unequipItem(playerEntity)
	end
end

return EquipItem