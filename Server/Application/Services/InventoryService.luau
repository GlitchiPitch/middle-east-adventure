---@class ServerApplicationInventoryService
local InventoryService = {}
InventoryService.__index = InventoryService

---@return ServerApplicationInventoryService
function InventoryService.new()
    local self = setmetatable({}, InventoryService)
    return self
end

return InventoryService
