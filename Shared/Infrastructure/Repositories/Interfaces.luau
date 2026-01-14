---@class IRepository
---@field diContainer DIContainer
local IRepository = {}

---@param diContainer DIContainer
---@return IRepository
function IRepository.new(diContainer)
	local self = setmetatable({}, { __index = IRepository })
	self.diContainer = diContainer
	return self
end

---@class IPlayerRepository : IRepository
local IPlayerRepository = setmetatable({}, { __index = IRepository })

-- Client-side method
---@return PlayerEntity
function IPlayerRepository:getPlayerEntity() end

-- Client-side methods
---@param newData table
function IPlayerRepository:updatePlayerEntity(newData) end

-- Server-side methods
---@param player Player
---@return PlayerEntity
function IPlayerRepository:getPlayerEntityByPlayer(player) end

---@param player Player
function IPlayerRepository:onPlayerAdded(player) end

---@param player Player
function IPlayerRepository:onPlayerRemoving(player) end

-- Shared methods for working with PlayerEntity
---@param playerEntity PlayerEntity
---@return InventoryEntity
function IPlayerRepository:getInventory(playerEntity) end

---@param playerEntity PlayerEntity
---@return EquipmentEntity
function IPlayerRepository:getEquipment(playerEntity) end

---@param playerEntity PlayerEntity
---@return SkillsEntity
function IPlayerRepository:getSkills(playerEntity) end

---@param playerEntity PlayerEntity
---@return StatsEntity
function IPlayerRepository:getStats(playerEntity) end

---@param playerEntity PlayerEntity
---@return AttributesEntity
function IPlayerRepository:getAttributes(playerEntity) end

---@param playerEntity PlayerEntity
---@param newData table
function IPlayerRepository:updatePlayerEntityByEntity(playerEntity, newData) end

---@param playerEntity PlayerEntity
---@return table
function IPlayerRepository:toData(playerEntity) end

---@class ISkillsRepository : IRepository
local ISkillsRepository = setmetatable({}, { __index = IRepository })

---@param playerEntity PlayerEntity
---@return SkillsEntity
function ISkillsRepository:getSkills(playerEntity) end

---@param playerEntity PlayerEntity
---@param skillType string
---@param skillName string
---@param value number
function ISkillsRepository:updateSkill(playerEntity, skillType, skillName, value) end

---@param playerEntity PlayerEntity
---@param skillType string
---@param skillName string
function ISkillsRepository:levelUpSkill(playerEntity, skillType, skillName) end

---@param playerEntity PlayerEntity
---@param skillType string
---@param skillName string
---@return number
function ISkillsRepository:getSkillLevel(playerEntity, skillType, skillName) end

---@param playerEntity PlayerEntity
---@param skillType string
---@return table
function ISkillsRepository:getSkillsByType(playerEntity, skillType) end

---@class IStatsRepository : IRepository
local IStatsRepository = setmetatable({}, { __index = IRepository })

---@param playerEntity PlayerEntity
---@return StatsEntity
function IStatsRepository:getStats(playerEntity) end

---@param playerEntity PlayerEntity
---@param statName string
---@param value number
function IStatsRepository:updateStat(playerEntity, statName, value) end

---@param playerEntity PlayerEntity
---@param statName string
---@param amount number
function IStatsRepository:heal(playerEntity, statName, amount) end

---@param playerEntity PlayerEntity
---@param statName string
---@param amount number
function IStatsRepository:damage(playerEntity, statName, amount) end

---@param playerEntity PlayerEntity
---@param statName string
---@return table
function IStatsRepository:getStat(playerEntity, statName) end

---@param playerEntity PlayerEntity
function IStatsRepository:resetStats(playerEntity) end

---@param playerEntity PlayerEntity
---@param effectName string
---@param state boolean
function IStatsRepository:setEffect(playerEntity, effectName, state) end

---@class IItemRepository : IRepository
local IItemRepository = setmetatable({}, { __index = IRepository })

---@param itemName string
---@return table
function IItemRepository:getItemData(itemName) end

---@return table<string, table>
function IItemRepository:getAllItems() end

---@param itemType string
---@return table<string, table>
function IItemRepository:getItemsByType(itemType) end

---@param itemName string
---@return string
function IItemRepository:getItemType(itemName) end

---@param itemName string
---@return boolean
function IItemRepository:itemExists(itemName) end

---@param itemType string
---@return table
function IItemRepository:getItemsOfType(itemType) end

---@class IInventoryRepository : IRepository
local IInventoryRepository = setmetatable({}, { __index = IRepository })

---@param playerEntity PlayerEntity
---@return InventoryEntity
function IInventoryRepository:getInventory(playerEntity) end

---@param playerEntity PlayerEntity
---@param itemName string
---@param itemData table
function IInventoryRepository:addItem(playerEntity, itemName, itemData) end

---@param playerEntity PlayerEntity
---@param itemName string
---@param amount number
function IInventoryRepository:removeItem(playerEntity, itemName, amount) end

---@param playerEntity PlayerEntity
---@param itemName string
---@param newData table
function IInventoryRepository:updateItem(playerEntity, itemName, newData) end

---@param playerEntity PlayerEntity
---@param itemName string
---@return table
function IInventoryRepository:getItem(playerEntity, itemName) end

---@param playerEntity PlayerEntity
---@return table<string, table>
function IInventoryRepository:getAllItems(playerEntity) end

---@class IEquipmentRepository : IRepository
local IEquipmentRepository = setmetatable({}, { __index = IRepository })

---@param playerEntity PlayerEntity
---@return EquipmentEntity
function IEquipmentRepository:getEquipment(playerEntity) end

---@param playerEntity PlayerEntity
---@param itemName string
---@param slot string
function IEquipmentRepository:equipItem(playerEntity, itemName, slot) end

---@param playerEntity PlayerEntity
---@param slot string
function IEquipmentRepository:unequipItem(playerEntity, slot) end

---@param playerEntity PlayerEntity
---@param itemName string
---@param slotKey string
function IEquipmentRepository:setSlot(playerEntity, itemName, slotKey) end

---@param playerEntity PlayerEntity
---@param ring RingEntity
function IEquipmentRepository:setRing(playerEntity, ring) end

---@param playerEntity PlayerEntity
---@param ring RingEntity
function IEquipmentRepository:removeRing(playerEntity, ring) end

---@param playerEntity PlayerEntity
---@return table<string, string>
function IEquipmentRepository:getSlots(playerEntity) end

---@class IAttributesRepository : IRepository
local IAttributesRepository = setmetatable({}, { __index = IRepository })

---@param playerEntity PlayerEntity
---@return AttributesEntity
function IAttributesRepository:getAttributes(playerEntity) end

---@param playerEntity PlayerEntity
---@param attributeName string
---@param value number
function IAttributesRepository:updateAttribute(playerEntity, attributeName, value) end

---@param playerEntity PlayerEntity
---@param expAmount number
function IAttributesRepository:addExp(playerEntity, expAmount) end

---@param playerEntity PlayerEntity
function IAttributesRepository:levelUp(playerEntity) end

---@param playerEntity PlayerEntity
---@param attributeName string
---@return number
function IAttributesRepository:getAttribute(playerEntity, attributeName) end

---@param playerEntity PlayerEntity
---@return number
function IAttributesRepository:getLevel(playerEntity) end

---@param playerEntity PlayerEntity
---@return number
function IAttributesRepository:getExp(playerEntity) end

---@param playerEntity PlayerEntity
---@param defenseType string
---@param value number
function IAttributesRepository:updateDefense(playerEntity, defenseType, value) end

---@class Interfaces
local Interfaces = {
	-- Export base interface directly
	IRepository = IRepository,
	IPlayerRepository = IPlayerRepository,
	IInventoryRepository = IInventoryRepository,
	IEquipmentRepository = IEquipmentRepository,
	ISkillsRepository = ISkillsRepository,
	IStatsRepository = IStatsRepository,
	IAttributesRepository = IAttributesRepository,
	IItemRepository = IItemRepository,
}

return Interfaces
