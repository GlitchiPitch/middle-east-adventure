---@class ServerApplicationFishingService
local FishingService = {}
FishingService.__index = FishingService

---@return ServerApplicationFishingService
function FishingService.new()
    local self = setmetatable({}, FishingService)
    return self
end

return FishingService