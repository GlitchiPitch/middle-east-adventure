---@class ClientAlchemyService
---@field alchemyPot Model
local AlchemyService = {}
AlchemyService.__index = AlchemyService

---@return ClientAlchemyService
function AlchemyService.new()
    local self = setmetatable({},AlchemyService)
    self.alchemyPot = nil
    return self
end

---@param alchemyPot Model
function AlchemyService:start(alchemyPot)
    self.alchemyPot = alchemyPot    
end

function AlchemyService:finish()
    
end

return AlchemyService