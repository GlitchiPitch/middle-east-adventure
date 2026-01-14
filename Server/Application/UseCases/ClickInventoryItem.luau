---@class ServerClickInventoryItem
---@field equipmentRepository ServerEquipmentRepository
---@field constants Constants
local ClickInventoryItem = {}
ClickInventoryItem.__index = ClickInventoryItem

---@param equipmentRepository ServerEquipmentRepository
---@param constants Constants
---@return ServerClickInventoryItem
function ClickInventoryItem.new(equipmentRepository, constants)
	local self = setmetatable({}, ClickInventoryItem)
	self.equipmentRepository = equipmentRepository
	self.constants = constants
	return self
end

---@param player Player
---@param itemData table
function ClickInventoryItem:execute(player, itemData)
	local equipment = self.equipmentRepository:getEquipment(player)
	local keys = {
		Enum.KeyCode.One.Name,
		Enum.KeyCode.Two.Name,
		Enum.KeyCode.Three.Name,
		Enum.KeyCode.Four.Name,
	}

	for _, key in keys do
		if not equipment.slots[key] then
			self.equipmentRepository:setSlot(player, itemData.name, key)
			return
		end
	end
end

return ClickInventoryItem