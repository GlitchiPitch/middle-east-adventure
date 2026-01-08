---@class SharedDomain
---@field Player PlayerEntity
---@field Inventory InventoryEntity
---@field Skills SkillsEntity
---@field Stats StatsEntity
---@field OneHanded OneHandedEntity
---@field Cloth ClothEntity
---@field TwoHanded TwoHandedEntity
---@field Equipment EquipmentEntity
local Domain = {}
Domain.__index = Domain

---@return SharedDomain
function Domain.new()
	local self = setmetatable({}, Domain)
	self.Player = require(script.Player)
	self.Inventory = require(script.Inventory)
	self.Skills = require(script.Skills)
	self.Stats = require(script.Stats)
	self.OneHanded = require(script.OneHanded)
	self.Equipment = require(script.Equipment)
	self.TwoHanded = require(script.TwoHanded)
	self.Cloth = require(script.Cloth)
	return self
end

return Domain
