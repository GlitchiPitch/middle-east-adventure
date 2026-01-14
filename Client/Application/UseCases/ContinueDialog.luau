---@class ClientContinueDialog
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local ContinueDialog = {}
ContinueDialog.__index = ContinueDialog

---@param diContainer DIContainer
---@return ClientContinueDialog
function ContinueDialog.new(diContainer)
	local self = setmetatable({}, ContinueDialog)
	self.diContainer = diContainer
	return self
end

function ContinueDialog:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command ContinueDialogCommand
function ContinueDialog:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.CONTINUE_DIALOG,
		data = command,
	})
end

return ContinueDialog