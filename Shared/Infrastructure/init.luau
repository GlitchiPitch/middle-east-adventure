local Services = require(script.Services)
local Repositories = require(script.Repositories)
---@class SharedInfrastructure
---@field _services SharedInfrastructureServices
---@field diContainer DIContainer
---@field remoteEventService RemoteEventService
---@field eventBus EventBus
---@field unitOfWork UnitOfWork
---@field eventEmitter EventEmitter
---@field cache Cache
---@field repositories SharedRepositories
local Infrastructure = {}
Infrastructure.__index = Infrastructure

function Infrastructure.new()
	local self = setmetatable({}, Infrastructure)
	self._services = Services.new()

	self.diContainer = self._services.diContainer
	self.remoteEventService = self._services.remoteEventService
	self.eventBus = self._services.eventBus
	self.unitOfWork = self._services.unitOfWork
	self.eventEmitter = self._services.eventEmitter
	self.cache = self._services.cache

	self.repositories = Repositories.new(self.diContainer)
	return self
end

function Infrastructure:init()
	self.repositories:init()
	self.cache:init() -- Инициализируем кеш с подписками на события
end

return Infrastructure
