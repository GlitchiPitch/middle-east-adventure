---@class ServerUnequipItem
---@field equipmentRepository ServerEquipmentRepository
---@field playerService ServerPlayerService
---@field constants Constants
local UnequipItem = {}
UnequipItem.__index = UnequipItem

---@param equipmentRepository ServerEquipmentRepository
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerUnequipItem
function UnequipItem.new(equipmentRepository, playerService, constants)
	local self = setmetatable({}, UnequipItem)
	self.equipmentRepository = equipmentRepository
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
---@param slot string
function UnequipItem:execute(player, slot)
	self.equipmentRepository:unequipItem(player, slot)
	self.playerService:updatePlayerData(player)
end

return UnequipItem