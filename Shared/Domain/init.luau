---@class SharedDomain
---@field Player PlayerEntity
---@field Inventory InventoryEntity
---@field Skills SkillsEntity
---@field Stats StatsEntity
---@field Sword SwordEntity
local Domain = {}
Domain.__index = Domain

---@return SharedDomain
function Domain.new()
    local self = setmetatable({}, Domain)
    self.Player = require(script.Player)
    self.Inventory = require(script.Inventory)
    self.Skills = require(script.Skills)
    self.Stats = require(script.Stats)
    self.Sword = require(script.Sword)
    return self
end

return Domain
