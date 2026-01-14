---@class ClientUnequipItem
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local UnequipItem = {}
UnequipItem.__index = UnequipItem

---@param diContainer DIContainer
---@return ClientUnequipItem
function UnequipItem.new(diContainer)
	local self = setmetatable({}, UnequipItem)
	self.diContainer = diContainer
	return self
end

function UnequipItem:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command UnequipItemCommand
function UnequipItem:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.UNEQUIP_ITEM,
		data = command,
	})
end

return UnequipItem