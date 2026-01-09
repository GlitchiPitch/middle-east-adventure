---@class ClientAlchemyService
local AlchemyService = {}
AlchemyService.__index = AlchemyService

---@return ClientAlchemyService
function AlchemyService.new()
    local self = setmetatable({},AlchemyService)
    return self
end

function AlchemyService:start()
    
end

function AlchemyService:finish()
    
end

return AlchemyService