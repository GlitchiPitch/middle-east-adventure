---@class ClientUseLectern
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local UseLectern = {}
UseLectern.__index = UseLectern

---@param diContainer DIContainer
---@return ClientUseLectern
function UseLectern.new(diContainer)
	local self = setmetatable({}, UseLectern)
	self.diContainer = diContainer
	return self
end

function UseLectern:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command UseLecternCommand
function UseLectern:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.USE_LECTERN,
		data = command,
	})
end

return UseLectern