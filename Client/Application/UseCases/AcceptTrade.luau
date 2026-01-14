---@class ClientAcceptTrade
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local AcceptTrade = {}
AcceptTrade.__index = AcceptTrade

---@param diContainer DIContainer
---@return ClientAcceptTrade
function AcceptTrade.new(diContainer)
	local self = setmetatable({}, AcceptTrade)
	self.diContainer = diContainer
	return self
end

function AcceptTrade:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command AcceptTradeCommand
function AcceptTrade:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.ACCEPT_TRADE,
		data = command,
	})
end

return AcceptTrade