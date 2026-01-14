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

	-- Инициализируем базовый репозиторий для получения UnitOfWork и EventEmitter
	IRepository.init(self)
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
	-- Validation
	if not playerEntity then
		error("playerEntity is required")
	end
	if not itemName or itemName == "" then
		error("itemName is required and cannot be empty")
	end
	if not slot or slot == "" then
		error("slot is required and cannot be empty")
	end

	local equipment = self:getEquipment(playerEntity)
	if not equipment then
		error("Failed to get equipment for player")
	end

	equipment:setSlot(slot, itemName)

	-- Регистрируем изменение в UnitOfWork
	if self.unitOfWork:isInTransaction() then
		self.unitOfWork:registerDirty(equipment)
	end

	-- Публикуем событие об изменении экипировки
	self.eventEmitter:emit("EntityUpdated", {
		entityType = "Equipment",
		entityId = tostring(playerEntity.id),
		changes = {
			equipment = true,
			slot = slot,
			itemName = itemName,
			action = "equipped",
		},
	})
end

---@param playerEntity PlayerEntity
---@param slot string
function EquipmentRepository:unequipItem(playerEntity, slot)
	local equipment = self:getEquipment(playerEntity)
	local previousItem = equipment.slots[slot]
	equipment:setSlot(slot, nil)

	-- Регистрируем изменение в UnitOfWork
	if self.unitOfWork:isInTransaction() then
		self.unitOfWork:registerDirty(equipment)
	end

	-- Публикуем событие об изменении экипировки
	self.eventEmitter:emit("EntityUpdated", {
		entityType = "Equipment",
		entityId = tostring(playerEntity.id),
		changes = {
			equipment = true,
			slot = slot,
			previousItem = previousItem,
			action = "unequipped",
		},
	})
end

---@param playerEntity PlayerEntity
---@param itemName string
---@param slotKey string
function EquipmentRepository:setSlot(playerEntity, itemName, slotKey)
	local equipment = self:getEquipment(playerEntity)
	local previousItem = equipment.slots[slotKey]
	equipment:setSlot(slotKey, itemName)

	-- Регистрируем изменение в UnitOfWork
	if self.unitOfWork:isInTransaction() then
		self.unitOfWork:registerDirty(equipment)
	end

	-- Публикуем событие об изменении экипировки
	self.eventEmitter:emit("EntityUpdated", {
		entityType = "Equipment",
		entityId = tostring(playerEntity.id),
		changes = {
			equipment = true,
			slot = slotKey,
			itemName = itemName,
			previousItem = previousItem,
			action = "slot_changed",
		},
	})
end

---@param playerEntity PlayerEntity
---@param ring RingEntity
function EquipmentRepository:setRing(playerEntity, ring)
	-- Validation
	if not playerEntity then
		error("playerEntity is required")
	end
	if not ring then
		error("ring entity is required")
	end

	local equipment = self:getEquipment(playerEntity)
	if not equipment then
		error("Failed to get equipment for player")
	end

	local previousRing = equipment:getRing(ring.side)
	equipment:setRing(ring)

	-- Регистрируем изменение в UnitOfWork
	if self.unitOfWork:isInTransaction() then
		self.unitOfWork:registerDirty(equipment)
	end

	-- Публикуем событие об изменении экипировки
	self.eventEmitter:emit("EntityUpdated", {
		entityType = "Equipment",
		entityId = tostring(playerEntity.id),
		changes = {
			equipment = true,
			ringSide = ring.side,
			ring = ring,
			previousRing = previousRing,
			action = "ring_equipped",
		},
	})
end

---@param playerEntity PlayerEntity
---@param ring RingEntity
function EquipmentRepository:removeRing(playerEntity, ring)
	local equipment = self:getEquipment(playerEntity)

	-- Ищем кольцо в слотах и удаляем
	local removedSide = nil
	for side, equippedRing in pairs(equipment.rings) do
		if equippedRing == ring then
			equipment.rings[side] = nil
			removedSide = side
			break
		end
	end

	-- Регистрируем изменение в UnitOfWork
	if self.unitOfWork:isInTransaction() and removedSide then
		self.unitOfWork:registerDirty(equipment)
	end

	-- Публикуем событие об изменении экипировки
	if removedSide then
		self.eventEmitter:emit("EntityUpdated", {
			entityType = "Equipment",
			entityId = tostring(playerEntity.id),
			changes = {
				equipment = true,
				ringSide = removedSide,
				removedRing = ring,
				action = "ring_removed",
			},
		})
	end
end

---@param playerEntity PlayerEntity
---@return table<string, string>
function EquipmentRepository:getSlots(playerEntity)
	local equipment = self:getEquipment(playerEntity)
	return equipment.slots
end

return EquipmentRepository
