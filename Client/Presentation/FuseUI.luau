---@class FuseUI
local FuseUI = {}
FuseUI.__index = FuseUI

function FuseUI.new()
    local self = setmetatable({}, FuseUI)
    return self
end

return FuseUI