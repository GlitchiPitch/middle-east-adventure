---@class AttributesEntity
local Attributes = {}
Attributes.__index = Attributes

---@param data table
---@return AttributesEntity
function Attributes.new(data)
    local self = setmetatable({}, Attributes)
    self.strength = data.strength or 100
    self.dexterity = data.dexterity or 100
    self.anchientKnowladge = data.anchientKnowladge or 0
    self.blacksmith = data.blacksmith or 0
    self.thief = data.thief or 0
    self.alchemy = data.alchemy or 0
    self.health = data.health or 100
    self.stamina = data.stamina or 100
    self.mana = data.mana or 100
    return self
end

function Attributes:toData()
    return self
end

return Attributes