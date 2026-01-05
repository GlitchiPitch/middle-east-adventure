---@class ServerApplicationAlchemyService
local AlchemyService = {}
AlchemyService.__index = AlchemyService

---@return ServerApplicationAlchemyService
function AlchemyService.new()
    local self = setmetatable({}, AlchemyService)
    return self
end

return AlchemyService
