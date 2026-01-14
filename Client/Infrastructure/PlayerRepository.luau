local Players = game:GetService("Players")

---@class ClientPlayerRepository
---@field diContainer DIContainer
---@field player Player
---@field playerEntity PlayerEntity
---@field inventoryRepository ClientInventoryRepository
---@field equipmentRepository ClientEquipmentRepository
---@field skillsRepository ClientSkillsRepository
---@field statsRepository ClientStatsRepository
---@field attributesRepository ClientAttributesRepository
local PlayerRepository = {}
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return ClientPlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable({}, PlayerRepository)
	self.diContainer = diContainer
	self.player = Players.LocalPlayer
	self.playerEntity = nil

	return self
end

function PlayerRepository:init()
	-- Initialize repositories
	---@type ClientInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.inventoryRepository = infrastructure.inventoryRepository
	self.equipmentRepository = infrastructure.equipmentRepository
	self.skillsRepository = infrastructure.skillsRepository
	self.statsRepository = infrastructure.statsRepository
	self.attributesRepository = infrastructure.attributesRepository
end

---@return PlayerEntity
function PlayerRepository:getPlayerEntity()
	if not self.playerEntity then
		---@type SharedDomain
		local domain = self.diContainer:resolve("Domain")
		self.playerEntity = domain.Player.new(self.player)
	end

	return self.playerEntity
end

---@param playerEntity PlayerEntity
---@return InventoryEntity
function PlayerRepository:getInventory(playerEntity)
	return self.inventoryRepository:getInventory()
end

---@param playerEntity PlayerEntity
---@return EquipmentEntity
function PlayerRepository:getEquipment(playerEntity)
	return self.equipmentRepository:getEquipment()
end

---@param playerEntity PlayerEntity
---@return SkillsEntity
function PlayerRepository:getSkills(playerEntity)
	return self.skillsRepository:getSkills()
end

---@param playerEntity PlayerEntity
---@return StatsEntity
function PlayerRepository:getStats(playerEntity)
	return self.statsRepository:getStats()
end

---@param playerEntity PlayerEntity
---@return AttributesEntity
function PlayerRepository:getAttributes(playerEntity)
	return self.attributesRepository:getAttributes()
end

---@param newData table
function PlayerRepository:updatePlayerEntity(newData)
	local playerEntity = self:getPlayerEntity()
	playerEntity:fromData(newData)
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

---@param playerEntity PlayerEntity
---@param data table
function PlayerRepository:fromData(playerEntity, data)
	playerEntity:fromData(data)
end

return PlayerRepository
