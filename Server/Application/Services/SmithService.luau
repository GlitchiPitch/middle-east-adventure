---@class ServerApplicationSmithService
local SmithService = {}
SmithService.__index = SmithService

---@return ServerApplicationSmithService
function SmithService.new()
    local self = setmetatable({}, SmithService)
    return self
end

return SmithService