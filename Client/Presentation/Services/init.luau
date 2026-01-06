local PromptService = require(script.PromptService)
local InputService = require(script.InputService)
local InventoryService = require(script.InventoryService)

---@class PresentationServices
---@field promptService PromptService
---@field inputService InputService
---@field inventoryService ClientPresentationInventoryService
local Services = {}
Services.__index = Services

---@return PresentationServices
function Services.new()
    local self = setmetatable({}, Services)
    self.promptService = PromptService.new()
    self.inputService = InputService.new()
    self.inventoryService = InventoryService.new()
    return self
end

return Services
