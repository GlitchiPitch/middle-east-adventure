---@class SkillsEntity
local Skills = {}
Skills.__index = Skills

---@param data table
---@return SkillsEntity
function Skills.new(data)
    local self = setmetatable({}, Skills)
    
    for i, v in data do
        self[i] = v
    end

    return self
end

function Skills:toData()
    return {}
end

return Skills