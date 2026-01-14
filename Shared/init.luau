local Infrastructure = require(script.Infrastructure)
local Application = require(script.Application)
local Constants = require(script.Constants)
local Config = require(script.Config)
local Domain = require(script.Domain)
local Data = require(script.Data)
local Assets = require(script.Assets)

local Types = require(script.Types)

---@class Shared
---@field remoteEventService RemoteEventService
---@field infrastructure SharedInfrastructure
---@field diContainer DIContainer
---@field eventBus EventBus
---@field domain SharedDomain
---@field application SharedApplication
---@field constants Constants
---@field config Config
---@field assets Assets
---@field data SharedData
local Shared = {}
Shared.__index = Shared

function Shared.new()
    local self = setmetatable({}, Shared)
    self.infrastructure = Infrastructure.new()
    self.domain = Domain.new()
    
    self.diContainer = self.infrastructure.diContainer
    self.remoteEventService = self.infrastructure.remoteEventService
    self.eventBus = self.infrastructure.eventBus

    self.application = Application.new()

    self.config = Config
    self.constants = Constants
    self.data = Data
    self.assets = Assets
    self.Types = Types
    return self
end

function Shared:init()
    self.infrastructure:init()
end

return Shared
