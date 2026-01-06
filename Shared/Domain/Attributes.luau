---@class AttributesEntity
local Attributes = {}
Attributes.__index = Attributes

---@param data table
---@return AttributesEntity
function Attributes.new(data)
    local self = setmetatable({}, Attributes)
    self.strength = data.strength
    self.dexterity = data.dexterity
    self.anchient_knowladge = data.anchient_knowladge
    self.blacksmith = data.blacksmith
    self.thief = data.thief
    self.alchemy = data.alchemy
    self.health = data.health
    self.stamina = data.stamina
    self.mana = data.mana
    return self
end

return Attributes