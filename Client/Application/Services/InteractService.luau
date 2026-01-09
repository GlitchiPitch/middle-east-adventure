---@class ClientInteractService
local InteractService = {}
InteractService.__index = InteractService

---@return ClientInteractService
function InteractService.new()
    local self = setmetatable({}, InteractService)
    return self
end

function InteractService:activate()
    
end

return InteractService