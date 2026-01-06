local PromptService = require(script.PromptService)
local InputService = require(script.InputService)

---@class PresentationServices
---@field promptService PromptService
---@field inputService InputService
local Services = {}
Services.__index = Services

---@return PresentationServices
function Services.new()
    local self = setmetatable({}, Services)
    self.promptService = PromptService.new()
    self.inputService = InputService.new()
    return self
end

return Services
