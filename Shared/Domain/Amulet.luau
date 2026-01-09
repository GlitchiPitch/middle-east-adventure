---@class AmuletEntity : ItemEntity
local Amulet = {}
Amulet.__index = Amulet

---@return AmuletEntity
function Amulet.new()
    local self = setmetatable({}, Amulet)
    return self
end

return Amulet
