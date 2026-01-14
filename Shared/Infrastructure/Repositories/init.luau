local PlayerRepository = require(script.PlayerRepository)
local InventoryRepository = require(script.InventoryRepository)
local EquipmentRepository = require(script.EquipmentRepository)
local SkillsRepository = require(script.SkillsRepository)
local StatsRepository = require(script.StatsRepository)
local AttributesRepository = require(script.AttributesRepository)
local ItemRepository = require(script.ItemRepository)

---@class SharedRepositories
---@field playerRepository PlayerRepository
---@field inventoryRepository InventoryRepository
---@field equipmentRepository EquipmentRepository
---@field skillsRepository SkillsRepository
---@field statsRepository StatsRepository
---@field attributesRepository AttributesRepository
---@field itemRepository ItemRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return SharedRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)

	-- Repositories
	self.playerRepository = PlayerRepository.new(diContainer)
	self.inventoryRepository = InventoryRepository.new(diContainer)
	self.equipmentRepository = EquipmentRepository.new(diContainer)
	self.skillsRepository = SkillsRepository.new(diContainer)
	self.statsRepository = StatsRepository.new(diContainer)
	self.attributesRepository = AttributesRepository.new(diContainer)
	self.itemRepository = ItemRepository.new(diContainer)

	return self
end

function Repositories:init()
	self.playerRepository:init()
	self.inventoryRepository:init()
	self.equipmentRepository:init()
	self.skillsRepository:init()
	self.statsRepository:init()
	self.attributesRepository:init()
	self.itemRepository:init()
end

return Repositories
