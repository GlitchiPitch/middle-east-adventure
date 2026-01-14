---@class ClientStartAlchemy
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local StartAlchemy = {}
StartAlchemy.__index = StartAlchemy

---@param diContainer DIContainer
---@return ClientStartAlchemy
function StartAlchemy.new(diContainer)
	local self = setmetatable({}, StartAlchemy)
	self.diContainer = diContainer
	return self
end

function StartAlchemy:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command StartAlchemyCommand
function StartAlchemy:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.START_ALCHEMY,
		data = command,
	})
end

return StartAlchemy