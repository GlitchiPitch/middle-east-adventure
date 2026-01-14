local Interfaces = require(script.Parent.Interfaces)
local IRepository = Interfaces.IRepository

---@class PlayerRepository : IRepository
---@field inventoryRepository InventoryRepository
---@field equipmentRepository EquipmentRepository
---@field skillsRepository SkillsRepository
---@field statsRepository StatsRepository
---@field attributesRepository AttributesRepository
local PlayerRepository = setmetatable({}, { __index = IRepository })
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return PlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable(IRepository.new(diContainer), PlayerRepository)
	return self
end

function PlayerRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.inventoryRepository = shared.infrastructure.repositories.inventoryRepository
	self.equipmentRepository = shared.infrastructure.repositories.equipmentRepository
	self.skillsRepository = shared.infrastructure.repositories.skillsRepository
	self.statsRepository = shared.infrastructure.repositories.statsRepository
	self.attributesRepository = shared.infrastructure.repositories.attributesRepository
end

---@param playerEntity PlayerEntity
---@return InventoryEntity
function PlayerRepository:getInventory(playerEntity)
	return self.inventoryRepository:getInventory(playerEntity)
end

---@param playerEntity PlayerEntity
---@return EquipmentEntity
function PlayerRepository:getEquipment(playerEntity)
	return self.equipmentRepository:getEquipment(playerEntity)
end

---@param playerEntity PlayerEntity
---@return SkillsEntity
function PlayerRepository:getSkills(playerEntity)
	return self.skillsRepository:getSkills(playerEntity)
end

---@param playerEntity PlayerEntity
---@return StatsEntity
function PlayerRepository:getStats(playerEntity)
	return self.statsRepository:getStats(playerEntity)
end

---@param playerEntity PlayerEntity
---@return AttributesEntity
function PlayerRepository:getAttributes(playerEntity)
	return self.attributesRepository:getAttributes(playerEntity)
end

---@param playerEntity PlayerEntity
---@param newData table
function PlayerRepository:updatePlayerEntityByEntity(playerEntity, newData)
	playerEntity:fromData(newData)
end

---@param playerEntity PlayerEntity
---@return table
function PlayerRepository:toData(playerEntity)
	return playerEntity:toData()
end

return PlayerRepository
