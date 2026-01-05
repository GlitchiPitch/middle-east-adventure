local RemoteEventService = require(script.RemoteEventService)
local DIContainer = require(script.DIContainer)

---@class SharedInfrastructureServices
local Services = {}
Services.__index = Services

function Services.new()
    local self = setmetatable({}, Services)
    self.diContainer = DIContainer.new()
    self.remoteEventService = RemoteEventService.new()
    return self
end

return Services
