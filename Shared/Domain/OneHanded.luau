---@class OneHandedEntity : ItemEntity
local OneHanded = {}
OneHanded.__index = OneHanded
setmetatable(OneHanded, { __index = require(script.Parent.Item) })

---@param data table
---@return OneHandedEntity
function OneHanded.new(data)
	data = data or {}
	data.itemType = "oneHanded"
	data.equippable = true
	local self = setmetatable(require(script.Parent.Item).new(data), OneHanded)
	return self
end

return OneHanded
