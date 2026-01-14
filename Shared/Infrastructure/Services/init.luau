local RemoteEventService = require(script.RemoteEventService)
local DIContainer = require(script.DIContainer)
local EventBus = require(script.EventBus)
local UnitOfWork = require(script.UnitOfWork)
local EventEmitter = require(script.EventEmitter)
local Cache = require(script.Cache)

---@class SharedInfrastructureServices
---@field remoteEventService RemoteEventService
---@field eventBus EventBus
---@field unitOfWork UnitOfWork
---@field eventEmitter EventEmitter
---@field cache Cache
local Services = {}
Services.__index = Services

function Services.new()
	local self = setmetatable({}, Services)
	self.diContainer = DIContainer.new()
	self.remoteEventService = RemoteEventService.new()
	self.eventBus = EventBus.new()
	self.unitOfWork = UnitOfWork.new(self.diContainer)
	self.eventEmitter = EventEmitter.new(self.diContainer)
	self.cache = Cache.new(self.diContainer)
	return self
end

return Services
