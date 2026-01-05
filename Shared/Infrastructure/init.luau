local Services = require(script.Services)

---@class SharedInfrastructure
---@field _services SharedInfrastructureServices
---@field diContainer DIContainer
---@field remoteEventService RemoteEventService
local Infrastructure = {}
Infrastructure.__index = Infrastructure

function Infrastructure.new()
    local self = setmetatable({}, Infrastructure)
    self._services = Services.new()

    self.diContainer = self._services.diContainer
    self.remoteEventService = self._services.remoteEventService
    return self
end

return Infrastructure
