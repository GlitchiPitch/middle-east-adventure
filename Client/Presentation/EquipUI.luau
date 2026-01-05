---@class EquipUI
local EquipUI = {}
EquipUI.__index = EquipUI

function EquipUI.new()
    local self = setmetatable({}, EquipUI)
    return self
end

return EquipUI