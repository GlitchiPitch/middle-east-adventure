local Infrastructure = require(script.Infrastructure)
local Constants = require(script.Constants)
local Config = require(script.Config)
local Domain = require(script.Domain)

---@class Shared
---@field remoteEventService RemoteEventService
---@field _infrastructure SharedInfrastructure
---@field diContainer DIContainer
---@field domain SharedDomain
---@field constants Constants
---@field config Config
local Shared = {}
Shared.__index = Shared

function Shared.new()
    local self = setmetatable({}, Shared)
    self._infrastructure = Infrastructure.new()
    self.domain = Domain.new()

    self.diContainer = self._infrastructure.diContainer
    self.remoteEventService = self._infrastructure.remoteEventService

    self.config = Config
    self.constants = Constants
    return self
end

return Shared
