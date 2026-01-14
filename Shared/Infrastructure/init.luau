local Services = require(script.Services)
local Repositories = require(script.Repositories)
---@class SharedInfrastructure
---@field _services SharedInfrastructureServices
---@field diContainer DIContainer
---@field remoteEventService RemoteEventService
---@field eventBus EventBus
---@field repositories SharedRepositories
local Infrastructure = {}
Infrastructure.__index = Infrastructure

function Infrastructure.new()
    local self = setmetatable({}, Infrastructure)
    self._services = Services.new()
    
    self.diContainer = self._services.diContainer
    self.remoteEventService = self._services.remoteEventService
    self.eventBus = self._services.eventBus

    self.repositories = Repositories.new(self.diContainer)
    return self
end

function Infrastructure:init()
    warn(self.repositories)
    self.repositories:init()
end

return Infrastructure
