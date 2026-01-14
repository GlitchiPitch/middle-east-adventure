---@class ClientStartTrade
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local StartTrade = {}
StartTrade.__index = StartTrade

---@param diContainer DIContainer
---@return ClientStartTrade
function StartTrade.new(diContainer)
	local self = setmetatable({}, StartTrade)
	self.diContainer = diContainer
	return self
end

function StartTrade:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command StartTradeCommand
function StartTrade:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.START_TRADE,
		data = command,
	})
end

return StartTrade