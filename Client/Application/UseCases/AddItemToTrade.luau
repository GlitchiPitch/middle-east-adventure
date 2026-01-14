---@class ClientAddItemToTrade
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local AddItemToTrade = {}
AddItemToTrade.__index = AddItemToTrade

---@param diContainer DIContainer
---@return ClientAddItemToTrade
function AddItemToTrade.new(diContainer)
	local self = setmetatable({}, AddItemToTrade)
	self.diContainer = diContainer
	return self
end

function AddItemToTrade:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command AddItemToTradeCommand
function AddItemToTrade:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.ADD_ITEM_TO_TRADE,
		data = command,
	})
end

return AddItemToTrade