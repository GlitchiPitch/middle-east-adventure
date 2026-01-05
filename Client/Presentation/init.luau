local UI = require(script.UI)
local Services = require(script.Services)

---@class Presentation
---@field ui UI
---@field services PresentationServices
local Presentation = {}
Presentation.__index = Presentation

---@return Presentation
function Presentation.new()
    local self = setmetatable({}, Presentation)
    self.ui = UI.new()
    self.services = Services.new()
    return self
end

function Presentation:init()
    
end

return Presentation
