local Interfaces = require(script.Parent.Interfaces)
local IRepository = Interfaces.IRepository

---@class EquipmentRepository : IRepository
---@field playerRepository IPlayerRepository
local EquipmentRepository = setmetatable({}, { __index = IRepository })
EquipmentRepository.__index = EquipmentRepository

---@param diContainer DIContainer
---@return EquipmentRepository
function EquipmentRepository.new(diContainer)
	local self = setmetatable(IRepository.new(diContainer), EquipmentRepository)
	return self
end

function EquipmentRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.playerRepository = shared.infrastructure.repositories.playerRepository
end

---@param playerEntity PlayerEntity
---@return EquipmentEntity
function EquipmentRepository:getEquipment(playerEntity)
	return playerEntity.equipment
end

---@param playerEntity PlayerEntity
---@param itemName string
---@param slot string
function EquipmentRepository:equipItem(playerEntity, itemName, slot)
	local equipment = self:getEquipment(playerEntity)
	equipment:setSlot(slot, itemName)
end

---@param playerEntity PlayerEntity
---@param slot string
function EquipmentRepository:unequipItem(playerEntity, slot)
	local equipment = self:getEquipment(playerEntity)
	equipment:setSlot(slot, nil)
end

---@param playerEntity PlayerEntity
---@param itemName string
---@param slotKey string
function EquipmentRepository:setSlot(playerEntity, itemName, slotKey)
	local equipment = self:getEquipment(playerEntity)
	equipment:setSlot(slotKey, itemName)
end

---@param playerEntity PlayerEntity
---@param ring RingEntity
function EquipmentRepository:setRing(playerEntity, ring)
	local equipment = self:getEquipment(playerEntity)
	equipment:setRing(ring)
end

---@param playerEntity PlayerEntity
---@param ring RingEntity
function EquipmentRepository:removeRing(playerEntity, ring)
	local equipment = self:getEquipment(playerEntity)

	-- Ищем кольцо в слотах и удаляем
	for side, equippedRing in pairs(equipment.rings) do
		if equippedRing == ring then
			equipment.rings[side] = nil
			break
		end
	end
end

---@param playerEntity PlayerEntity
---@return table<string, string>
function EquipmentRepository:getSlots(playerEntity)
	local equipment = self:getEquipment(playerEntity)
	return equipment.slots
end

return EquipmentRepository
