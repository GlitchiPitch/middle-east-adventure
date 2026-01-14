---@class ClientClickInventoryItem
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local ClickInventoryItem = {}
ClickInventoryItem.__index = ClickInventoryItem

---@param diContainer DIContainer
---@return ClientClickInventoryItem
function ClickInventoryItem.new(diContainer)
	local self = setmetatable({}, ClickInventoryItem)
	self.diContainer = diContainer
	return self
end

function ClickInventoryItem:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command ClickInventoryItemCommand
function ClickInventoryItem:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.CLICK_INVENTORY_ITEM,
		data = command,
	})
end

return ClickInventoryItem