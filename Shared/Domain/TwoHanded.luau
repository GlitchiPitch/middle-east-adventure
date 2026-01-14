---@class TwoHandedEntity : ItemEntity
local TwoHanded = {}
TwoHanded.__index = TwoHanded
setmetatable(TwoHanded, { __index = require(script.Parent.Item) })

---@param data table
---@return TwoHandedEntity
function TwoHanded.new(data)
	data = data or {}
	data.itemType = "twoHanded"
	data.equippable = true
	local self = setmetatable(require(script.Parent.Item).new(data), TwoHanded)
	return self
end

return TwoHanded
