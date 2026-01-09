local UI = require(script.UI)
local Services = require(script.Services)

---@class Presentation
---@field ui UI
---@field services PresentationServices
local Presentation = {}
Presentation.__index = Presentation

---@param diContainer DIContainer
---@return Presentation
function Presentation.new(diContainer)
    local self = setmetatable({}, Presentation)
    self.ui = UI.new(diContainer)
    self.services = Services.new(diContainer)
    return self
end

function Presentation:init()
    self.ui:init()
end

return Presentation
