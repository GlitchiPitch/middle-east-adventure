local UI = require(script.UI)
local Services = require(script.Services)

---@class Presentation
---@field ui UI
---@field services PresentationServices
---@field diContainer DIContainer
local Presentation = {}
Presentation.__index = Presentation

---@param diContainer DIContainer
---@return Presentation
function Presentation.new(diContainer)
    local self = setmetatable({}, Presentation)
    self.diContainer = diContainer
    self.ui = UI.new(diContainer)
    self.services = Services.new(diContainer)
    return self
end

function Presentation:init()

    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    shared.eventBus:connect("updatePlayerData", function()
        self.ui.statsUI:updateUI()
    end)

    self.ui:init()
end

return Presentation
