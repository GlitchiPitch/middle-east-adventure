---@class ServerApplicationTradeService
local TradeService = {}
TradeService.__index = TradeService

---@return ServerApplicationTradeService
function TradeService.new()
    local self = setmetatable({},TradeService)
    return self
end

return TradeService