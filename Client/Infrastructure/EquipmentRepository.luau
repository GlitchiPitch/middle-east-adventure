---@class ClientEquipmentRepository
---@field diContainer DIContainer
---@field playerRepository ClientPlayerRepository
local EquipmentRepository = {}
EquipmentRepository.__index = EquipmentRepository

---@param diContainer DIContainer
---@return ClientEquipmentRepository
function EquipmentRepository.new(diContainer)
    local self = setmetatable({}, EquipmentRepository)
    self.diContainer = diContainer
    return self
end

function EquipmentRepository:init()
    ---@type ClientInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
    self.playerRepository = infrastructure.playerRepository
end

---@return EquipmentEntity
function EquipmentRepository:getEquipment()
    local playerEntity = self.playerRepository:getPlayerEntity()
    return playerEntity:getEquipment()
end

---@param itemName string
---@param slot string
function EquipmentRepository:equipItem(itemName, slot)
    -- Client-side implementation - would typically use RemoteEvent
    local equipment = self:getEquipment()
    equipment:setSlot(slot, itemName)
end

---@param slot string
function EquipmentRepository:unequipItem(slot)
    local equipment = self:getEquipment()
    equipment:setSlot(slot, nil)
end

---@param itemName string
---@param slotKey string
function EquipmentRepository:setSlot(itemName, slotKey)
    local equipment = self:getEquipment()
    equipment:setSlot(slotKey, itemName)
end

---@param ring RingEntity
function EquipmentRepository:setRing(ring)
    local equipment = self:getEquipment()
    equipment:setRing(ring)
end

---@param ring RingEntity
function EquipmentRepository:removeRing(ring)
    local equipment = self:getEquipment()

    -- Ищем кольцо в слотах и удаляем
    for side, equippedRing in pairs(equipment.rings) do
        if equippedRing == ring then
            equipment.rings[side] = nil
            break
        end
    end
end

---@return table<string, string>
function EquipmentRepository:getSlots()
    local equipment = self:getEquipment()
    return equipment.slots
end

return EquipmentRepository