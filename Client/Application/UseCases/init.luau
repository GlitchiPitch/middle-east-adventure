---@class ClientClickInventoryItem
---@field remoteEventService RemoteEventService
---@field constants Constants
local ClickInventoryItem = {}
ClickInventoryItem.__index = ClickInventoryItem

---@param remoteEventService RemoteEventService
---@param constants Constants
---@return ClientClickInventoryItem
function ClickInventoryItem.new(remoteEventService, constants)
	local self = setmetatable({}, ClickInventoryItem)
	self.remoteEventService = remoteEventService
	self.constants = constants
	return self
end

---@class ClientPickupLoot
local PickupLoot = {}
PickupLoot.__index = PickupLoot

---@param remoteEventService RemoteEventService
---@param constants Constants
---@return ClientPickupLoot
function PickupLoot.new(remoteEventService, constants)
	local self = setmetatable({}, PickupLoot)
	self.remoteEventService = remoteEventService
	self.constants = constants
	return self
end

---@param command any
function PickupLoot:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.PICKUP_LOOT,
		data = command,
	})
end

---@param command ClickInventoryItemCommand
function ClickInventoryItem:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.CLICK_INVENTORY_ITEM,
		data = command,
	})
end

---@class ClientUseCases
---@field diContainer DIContainer
local UseCases = {}
UseCases.__index = UseCases

---@param diContainer DIContainer
---@return ClientUseCases
function UseCases.new(diContainer)
	local self = setmetatable({}, UseCases)
	self.diContainer = diContainer
	return self
end

function UseCases:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.clickInventoryItem = ClickInventoryItem.new(shared.remoteEventService, shared.constants)
	self.pickupLoot = PickupLoot.new(shared.remoteEventService, shared.constants)
	
end

return UseCases
