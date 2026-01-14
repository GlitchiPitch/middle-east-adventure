---@class ClientToggleSprint
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local ToggleSprint = {}
ToggleSprint.__index = ToggleSprint

---@param diContainer DIContainer
---@return ClientToggleSprint
function ToggleSprint.new(diContainer)
	local self = setmetatable({}, ToggleSprint)
	self.diContainer = diContainer
	return self
end

function ToggleSprint:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command ToggleSprintCommand
function ToggleSprint:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.TOGGLE_SPRINT,
		data = command,
	})
end

return ToggleSprint