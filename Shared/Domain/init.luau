local Player = require(script.Player)
local Inventory = require(script.Inventory)
local Skills = require(script.Skills)
local Stats = require(script.Stats)

---@class SharedDomain
---@field Player PlayerEntity
---@field Inventory InventoryEntity
---@field Skills SkillsEntity
---@field Stats StatsEntity
local Domain = {}
Domain.__index = Domain

---@return SharedDomain
function Domain.new()
    local self = setmetatable({}, Domain)
    self.Player = Player
    self.Inventory = Inventory
    self.Skills = Skills
    self.Stats = Stats
    return self
end

return Domain
