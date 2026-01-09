---@class ClothEntity : ItemEntity
local Cloth = {}
Cloth.__index = Cloth

---@return ClothEntity
function Cloth.new()
    local self = setmetatable({}, Cloth)
    return self
end

return Cloth