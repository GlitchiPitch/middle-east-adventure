---@class ClientPickupLoot
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local PickupLoot = {}
PickupLoot.__index = PickupLoot

---@param diContainer DIContainer
---@return ClientPickupLoot
function PickupLoot.new(diContainer)
	local self = setmetatable({}, PickupLoot)
	self.diContainer = diContainer
	return self
end

function PickupLoot:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command PickupLootCommand
function PickupLoot:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.PICKUP_LOOT,
		data = command,
	})
end

return PickupLoot