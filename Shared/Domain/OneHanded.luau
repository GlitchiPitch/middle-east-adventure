---@class OneHandedEntity
local OneHanded = {}
OneHanded.__index = OneHanded

---@return OneHandedEntity
function OneHanded.new()
	local self = setmetatable({}, OneHanded)
	return self
end

return OneHanded
