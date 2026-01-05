---@class InventoryUI
local InventoryUI = {}
InventoryUI.__index = InventoryUI

---@return InventoryUI
function InventoryUI.new()
    local self = setmetatable({}, InventoryUI)
    return self
end

return InventoryUI