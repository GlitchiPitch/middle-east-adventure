---@class SkillsEntity
local Skills = {}
Skills.__index = Skills

---@param data table
---@return SkillsEntity
function Skills.new(data)
    local self = setmetatable({}, Skills)
    self.combat = data.combat or {}
    self.magic = data.magic or {}
    self.thief = data.thief or {}
    self.hunting = data.hunting or {}
    self.alchemy = data.alchemy or {}
    self.misc = data.misc or {}
    return self
end

function Skills:toData()
    return self
end

return Skills