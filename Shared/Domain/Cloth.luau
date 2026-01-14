---@class ClothEntity : ItemEntity
local Cloth = {}
Cloth.__index = Cloth
setmetatable(Cloth, { __index = require(script.Parent.Item) })

---@param data table
---@return ClothEntity
function Cloth.new(data)
	data = data or {}
	data.itemType = "cloth"
	data.equippable = true
    local self = setmetatable(require(script.Parent.Item).new(data), Cloth)
    return self
end

return Cloth