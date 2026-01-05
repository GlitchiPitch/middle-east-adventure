---@class ServerApplicationHuntingService
local HuntingService = {}
HuntingService.__index = HuntingService

---@return ServerApplicationHuntingService
function HuntingService.new()
    local self = setmetatable({}, HuntingService)
    return self
end

return HuntingService
