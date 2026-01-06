---@class SwordEntity
local Sword = {}
Sword.__index = Sword

---@return SwordEntity
function Sword.new()
    local self = setmetatable({}, Sword)
    return self
end

return Sword