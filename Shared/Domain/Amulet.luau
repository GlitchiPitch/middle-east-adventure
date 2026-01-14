---@class AmuletEntity : ItemEntity
local Amulet = {}
Amulet.__index = Amulet
setmetatable(Amulet, { __index = require(script.Parent.Item) })

---@param data table
---@return AmuletEntity
function Amulet.new(data)
	data = data or {}
	data.itemType = "amulet"
	data.equippable = true
    local self = setmetatable(require(script.Parent.Item).new(data), Amulet)
    return self
end

return Amulet
