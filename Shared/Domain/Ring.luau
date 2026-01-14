---@class RingEntity : ItemEntity
local Ring = {}
Ring.__index = Ring
setmetatable(Ring, { __index = require(script.Parent.Item) })

---@param data table
---@return RingEntity
function Ring.new(data)
	data = data or {}
	data.itemType = "ring"
	data.equippable = true
    local self = setmetatable(require(script.Parent.Item).new(data), Ring)
    return self
end

return Ring