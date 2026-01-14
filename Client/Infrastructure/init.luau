local PlayerRepository = require(script.PlayerRepository)
local InventoryRepository = require(script.InventoryRepository)
local EquipmentRepository = require(script.EquipmentRepository)
local SkillsRepository = require(script.SkillsRepository)
local StatsRepository = require(script.StatsRepository)
local AttributesRepository = require(script.AttributesRepository)
local ItemRepository = require(script.ItemRepository)

---@class ClientInfrastructure
---@field playerRepository ClientPlayerRepository
---@field inventoryRepository ClientInventoryRepository
---@field equipmentRepository ClientEquipmentRepository
---@field skillsRepository ClientSkillsRepository
---@field statsRepository ClientStatsRepository
---@field attributesRepository ClientAttributesRepository
---@field itemRepository ClientItemRepository
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@param diContainer DIContainer
---@return ClientInfrastructure
function Infrastructure.new(diContainer)
	local self = setmetatable({}, Infrastructure)
	self.playerRepository = PlayerRepository.new(diContainer)
	self.inventoryRepository = InventoryRepository.new(diContainer)
	self.equipmentRepository = EquipmentRepository.new(diContainer)
	self.skillsRepository = SkillsRepository.new(diContainer)
	self.statsRepository = StatsRepository.new(diContainer)
	self.attributesRepository = AttributesRepository.new(diContainer)
	self.itemRepository = ItemRepository.new(diContainer)
	return self
end

function Infrastructure:init()
	self.attributesRepository:init()
	self.equipmentRepository:init()
	self.inventoryRepository:init()
	self.itemRepository:init()
	self.playerRepository:init()
	self.skillsRepository:init()
	self.statsRepository:init()
end

return Infrastructure
