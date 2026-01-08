local RemoteEventService = require(script.RemoteEventService)
local DIContainer = require(script.DIContainer)
local EventBus = require(script.EventBus)

---@class SharedInfrastructureServices
---@field remoteEventService RemoteEventService
---@field eventBus EventBus
local Services = {}
Services.__index = Services

function Services.new()
    local self = setmetatable({}, Services)
    self.diContainer = DIContainer.new()
    self.remoteEventService = RemoteEventService.new()
    self.eventBus = EventBus.new()
    return self
end

return Services
