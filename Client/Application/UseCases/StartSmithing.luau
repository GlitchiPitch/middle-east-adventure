---@class ClientStartSmithing
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local StartSmithing = {}
StartSmithing.__index = StartSmithing

---@param diContainer DIContainer
---@return ClientStartSmithing
function StartSmithing.new(diContainer)
	local self = setmetatable({}, StartSmithing)
	self.diContainer = diContainer
	return self
end

function StartSmithing:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command StartSmithingCommand
function StartSmithing:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.START_SMITHING,
		data = command,
	})
end

return StartSmithing