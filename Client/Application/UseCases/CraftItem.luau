---@class ClientCraftItem
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local CraftItem = {}
CraftItem.__index = CraftItem

---@param diContainer DIContainer
---@return ClientCraftItem
function CraftItem.new(diContainer)
	local self = setmetatable({}, CraftItem)
	self.diContainer = diContainer
	return self
end

function CraftItem:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command CraftItemCommand
function CraftItem:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.CRAFT_ITEM,
		data = command,
	})
end

return CraftItem