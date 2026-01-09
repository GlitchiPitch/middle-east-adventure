---@class RingEntity : ItemEntity
local Ring = {}
Ring.__index = Ring

---@return RingEntity
function Ring.new()
    local self = setmetatable({}, Ring)
    return self
end

return Ring