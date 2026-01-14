---@class ClientRemoveItemFromTrade
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local RemoveItemFromTrade = {}
RemoveItemFromTrade.__index = RemoveItemFromTrade

---@param diContainer DIContainer
---@return ClientRemoveItemFromTrade
function RemoveItemFromTrade.new(diContainer)
	local self = setmetatable({}, RemoveItemFromTrade)
	self.diContainer = diContainer
	return self
end

function RemoveItemFromTrade:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command RemoveItemFromTradeCommand
function RemoveItemFromTrade:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.REMOVE_ITEM_FROM_TRADE,
		data = command,
	})
end

return RemoveItemFromTrade