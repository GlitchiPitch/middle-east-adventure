local PromptService = require(script.PromptService)

---@class PresentationServices
---@field promptService PromptService
local Services = {}
Services.__index = Services

---@return PresentationServices
function Services.new()
    local self = setmetatable({}, Services)
    self.promptService = PromptService.new()
    return self
end

return Services
