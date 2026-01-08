---@class TwoHandedEntity
local TwoHanded = {}
TwoHanded.__index = TwoHanded

---@return TwoHandedEntity
function TwoHanded.new()
	local self = setmetatable({}, TwoHanded)
	return self
end

return TwoHanded
