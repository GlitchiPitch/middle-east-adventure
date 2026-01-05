---@class ServerApplicationCraftService
local CraftService = {}
CraftService.__index = CraftService

---@return ServerApplicationCraftService
function CraftService.new()
    local self = setmetatable({}, CraftService)
    return self
end

return CraftService