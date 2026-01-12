---@alias _zoneType '"Mob"' | '"Plant"' | '"Mine"'


---@class ZoneEntity
---@field type _zoneType
---@field _instance Part
local Zone = {}
Zone.__index = Zone

---@class zoneData
---@field type _zoneType
---@field _instance Part

---@param data zoneData
---@return ZoneEntity
function Zone.new(data)
	local self = setmetatable({}, Zone)
    self.type = data.type
	self._instance = data._instance
	return self
end

function Zone:spawn()
	
end

return Zone
