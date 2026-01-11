---@class ClientTradeService
---@field diContainer DIContainer
local TradeService = {}
TradeService.__index = TradeService

---@param diContainer DIContainer
---@return ClientTradeService
function TradeService.new(diContainer)
    local self = setmetatable({}, TradeService)
    self.diContainer = diContainer
    return self
end

function TradeService:init()
    
end

function TradeService:start()
    
end

function TradeService:finish()
    
end

return TradeService