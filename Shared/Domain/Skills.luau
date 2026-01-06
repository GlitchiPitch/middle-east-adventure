---@class SkillsEntity
local Skills = {}
Skills.__index = Skills

---@param data table
---@return SkillsEntity
function Skills.new(data)
    local self = setmetatable({}, Skills)
    self.combat = {}
    self.magic = {}
    self.thief = {}
    self.hunting = {}
    self.alchemy = {}
    self.misc = {}
    return self
end

function Skills:toData()
    return {}
end

return Skills