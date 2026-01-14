---@class ServerSetEquipmentSlot
---@field equipmentRepository ServerEquipmentRepository
---@field playerService ServerPlayerService
---@field constants Constants
local SetEquipmentSlot = {}
SetEquipmentSlot.__index = SetEquipmentSlot

---@param equipmentRepository ServerEquipmentRepository
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerSetEquipmentSlot
function SetEquipmentSlot.new(equipmentRepository, playerService, constants)
	local self = setmetatable({}, SetEquipmentSlot)
	self.equipmentRepository = equipmentRepository
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
---@param itemName string
---@param slotKey string
function SetEquipmentSlot:execute(player, itemName, slotKey)
	self.equipmentRepository:setSlot(player, itemName, slotKey)
	self.playerService:updatePlayerData(player)
end

return SetEquipmentSlot