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

---@param command ClickInventoryItemCommand
function ClickInventoryItem:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.CLICK_INVENTORY_ITEM,
		data = command,
	})
end

---@class ClientPickupLoot
---@field remoteEventService RemoteEventService
---@field constants Constants
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

---@param command PickupLootCommand
function PickupLoot:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.PICKUP_LOOT,
		data = command,
	})
end

---@class ClientUseLectern
---@field remoteEventService RemoteEventService
---@field constants Constants
local UseLectern = {}
UseLectern.__index = UseLectern

---@param remoteEventService RemoteEventService
---@param constants Constants
---@return ClientUseLectern
function UseLectern.new(remoteEventService, constants)
	local self = setmetatable({}, UseLectern)
	self.remoteEventService = remoteEventService
	self.constants = constants
	return self
end

---@param command UseLecternCommand
function UseLectern:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.USE_LECTERN,
		data = command,
	})
end

---@class ClientEquipItem
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field playerService ClientPlayerService
local EquipItem = {}
EquipItem.__index = EquipItem

---@param remoteEventService RemoteEventService
---@param playerService ClientPlayerService
---@param constants Constants
---@return ClientEquipItem
function EquipItem.new(remoteEventService, playerService, constants)
	local self = setmetatable({}, EquipItem)
	self.remoteEventService = remoteEventService
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param command EquipItemCommand
function EquipItem:execute(command)
	local playerEntity = self.playerService:getPlayerEntity()
	if playerEntity.equipment.slots[command.slotIndex] then
		self.remoteEventService:fireServer({
			eventName = self.constants.REMOTE_EVENTS.EQUIP_ITEM,
			data = command,
		})
	end
end

---@class ClientUseCases
---@field diContainer DIContainer
---@field clickInventoryItem ClientClickInventoryItem
---@field pickupLoot ClientPickupLoot
---@field useLectern ClientUseLectern
---@field equipItem ClientEquipItem
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
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")

	self.clickInventoryItem = ClickInventoryItem.new(shared.remoteEventService, shared.constants)
	self.pickupLoot = PickupLoot.new(shared.remoteEventService, shared.constants)
	self.useLectern = UseLectern.new(shared.remoteEventService, shared.constants)
	self.equipItem = EquipItem.new(shared.remoteEventService, application.services.playerService, shared.constants)
end

return UseCases
