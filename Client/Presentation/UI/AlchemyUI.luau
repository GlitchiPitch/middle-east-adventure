---@class AlchemyUI
local AlchemyUI = {}
AlchemyUI.__index = AlchemyUI

---@return AlchemyUI
function AlchemyUI.new()
    local self = setmetatable({}, AlchemyUI)
    return self
end

return AlchemyUI