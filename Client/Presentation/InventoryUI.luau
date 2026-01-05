---@class InventoryUI
local InventoryUI = {}
InventoryUI.__index = InventoryUI

function InventoryUI.new()
    local self = setmetatable({}, InventoryUI)
    return self
end

return InventoryUI