---@class Presentation
local Presentation = {}
Presentation.__index = Presentation

---@return Presentation
function Presentation.new()
    local self = setmetatable({}, Presentation)
    return self
end

function Presentation:init()
    
end

return Presentation
