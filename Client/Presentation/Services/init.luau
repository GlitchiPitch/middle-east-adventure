local PromptService = require(script.PromptService)
local EquippedSlotsService = require(script.EquippedSlotsService)

---@class PresentationServices
---@field promptService PromptService
---@field equippedSlotsService EquippedSlotsService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return PresentationServices
function Services.new(diContainer)
    local self = setmetatable({}, Services)
    self.promptService = PromptService.new()
    self.equippedSlotsService = EquippedSlotsService.new(diContainer)
    return self
end

return Services
