---@class ClientSelectDialogOption
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local SelectDialogOption = {}
SelectDialogOption.__index = SelectDialogOption

---@param diContainer DIContainer
---@return ClientSelectDialogOption
function SelectDialogOption.new(diContainer)
	local self = setmetatable({}, SelectDialogOption)
	self.diContainer = diContainer
	return self
end

function SelectDialogOption:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command SelectDialogOptionCommand
function SelectDialogOption:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.SELECT_DIALOG_OPTION,
		data = command,
	})
end

return SelectDialogOption