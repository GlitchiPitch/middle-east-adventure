---@class TradeUI
local TradeUI = {}
TradeUI.__index = TradeUI

---@return TradeUI
function TradeUI.new()
    local self = setmetatable({}, TradeUI)
    return self
end

return TradeUI