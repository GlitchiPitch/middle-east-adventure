---@class ServerEquipmentRepository
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
local EquipmentRepository = {}
EquipmentRepository.__index = EquipmentRepository

---@param diContainer DIContainer
---@return ServerEquipmentRepository
function EquipmentRepository.new(diContainer)
    local self = setmetatable({}, EquipmentRepository)
    self.diContainer = diContainer
    return self
end

function EquipmentRepository:init()
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.playerRepository
end

---@param player Player
---@return EquipmentEntity
function EquipmentRepository:getEquipment(player)
    local playerEntity = self.playerRepository:getPlayerEntity(player)
    return playerEntity:getEquipment()
end

---@param player Player
---@param itemName string
---@param slot string
function EquipmentRepository:equipItem(player, itemName, slot)
    local equipment = self:getEquipment(player)
    equipment:setSlot(slot, itemName)
end

---@param player Player
---@param slot string
function EquipmentRepository:unequipItem(player, slot)
    local equipment = self:getEquipment(player)
    equipment:setSlot(slot, nil)
end

---@param player Player
---@param itemName string
---@param slotKey string
function EquipmentRepository:setSlot(player, itemName, slotKey)
    local equipment = self:getEquipment(player)
    equipment:setSlot(slotKey, itemName)
end

---@param player Player
---@param ring RingEntity
function EquipmentRepository:setRing(player, ring)
    local equipment = self:getEquipment(player)
    equipment:setRing(ring)
end

---@param player Player
---@param ring RingEntity
function EquipmentRepository:removeRing(player, ring)
    local equipment = self:getEquipment(player)

    -- Ищем кольцо в слотах и удаляем
    for side, equippedRing in pairs(equipment.rings) do
        if equippedRing == ring then
            equipment.rings[side] = nil
            break
        end
    end
end

---@param player Player
---@return table<string, string>
function EquipmentRepository:getSlots(player)
    local equipment = self:getEquipment(player)
    return equipment.slots
end

return EquipmentRepository