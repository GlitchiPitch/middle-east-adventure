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

---@class ClientUseLectern
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local UseLectern = {}
UseLectern.__index = UseLectern

---@param diContainer DIContainer
---@return ClientUseLectern
function UseLectern.new(diContainer)
	local self = setmetatable({}, UseLectern)
	self.diContainer = diContainer
	return self
end

function UseLectern:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
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
---@field diContainer DIContainer
---@field cache Cache
local EquipItem = {}
EquipItem.__index = EquipItem

---@param diContainer DIContainer
---@return ClientEquipItem
function EquipItem.new(diContainer)
	local self = setmetatable({}, EquipItem)
	self.diContainer = diContainer
	return self
end

function EquipItem:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
	self.playerService = application.services.playerService
	self.cache = shared.infrastructure.cache
end

---@param command EquipItemCommand
function EquipItem:execute(command)
	-- Try to get equipment data from cache first
	local player = game.Players.LocalPlayer
	local cacheKey = "Equipment:" .. player.UserId
	local cachedEquipment = self.cache:get(cacheKey)

	local equipmentSlots
	if cachedEquipment then
		equipmentSlots = cachedEquipment.slots
		print("Using cached equipment data for slot validation")
	else
		-- Fallback to direct access if not cached
		---@type ClientInfrastructure
		local infrastructure = self.diContainer:resolve("Infrastructure")
		local playerEntity = infrastructure.playerRepository:getPlayerEntity()
		equipmentSlots = playerEntity.equipment.slots
		print("Using direct equipment data for slot validation")
	end

	if equipmentSlots[command.slotIndex] then
		self.remoteEventService:fireServer({
			eventName = self.constants.REMOTE_EVENTS.EQUIP_ITEM,
			data = command,
		})
	end
end


---@class ClientToggleSprint
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local ToggleSprint = {}
ToggleSprint.__index = ToggleSprint

---@param diContainer DIContainer
---@return ClientToggleSprint
function ToggleSprint.new(diContainer)
	local self = setmetatable({}, ToggleSprint)
	self.diContainer = diContainer
	return self
end

function ToggleSprint:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command ToggleSprintCommand
function ToggleSprint:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.TOGGLE_SPRINT,
		data = command,
	})
end

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

---@class ClientStartAlchemy
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local StartAlchemy = {}
StartAlchemy.__index = StartAlchemy

---@param diContainer DIContainer
---@return ClientStartAlchemy
function StartAlchemy.new(diContainer)
	local self = setmetatable({}, StartAlchemy)
	self.diContainer = diContainer
	return self
end

function StartAlchemy:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command StartAlchemyCommand
function StartAlchemy:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.START_ALCHEMY,
		data = command,
	})
end

---@class ClientStartSmithing
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local StartSmithing = {}
StartSmithing.__index = StartSmithing

---@param diContainer DIContainer
---@return ClientStartSmithing
function StartSmithing.new(diContainer)
	local self = setmetatable({}, StartSmithing)
	self.diContainer = diContainer
	return self
end

function StartSmithing:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command StartSmithingCommand
function StartSmithing:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.START_SMITHING,
		data = command,
	})
end

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

---@class ClientSelectDialogOption
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local SelectDialogOption = {}
SelectDialogOption.__index = SelectDialogOption

---@param diContainer DIContainer
---@return ClientSelectDialogOption
function SelectDialogOption.new(diContainer)
	local self = setmetatable({}, SelectDialogOption)
	self.diContainer = diContainer
	return self
end

function SelectDialogOption:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command SelectDialogOptionCommand
function SelectDialogOption:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.SELECT_DIALOG_OPTION,
		data = command,
	})
end

---@class ClientContinueDialog
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field diContainer DIContainer
local ContinueDialog = {}
ContinueDialog.__index = ContinueDialog

---@param diContainer DIContainer
---@return ClientContinueDialog
function ContinueDialog.new(diContainer)
	local self = setmetatable({}, ContinueDialog)
	self.diContainer = diContainer
	return self
end

function ContinueDialog:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
end

---@param command ContinueDialogCommand
function ContinueDialog:execute(command)
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.CONTINUE_DIALOG,
		data = command,
	})
end

---@class ClientUseCases
---@field diContainer DIContainer
---@field clickInventoryItem ClientClickInventoryItem
---@field pickupLoot ClientPickupLoot
---@field useLectern ClientUseLectern
---@field equipItem ClientEquipItem
---@field unequipItem ClientUnequipItem
---@field toggleSprint ClientToggleSprint
---@field startAlchemy ClientStartAlchemy
---@field startSmithing ClientStartSmithing
---@field craftItem ClientCraftItem
---@field startTrade ClientStartTrade
---@field acceptTrade ClientAcceptTrade
---@field addItemToTrade ClientAddItemToTrade
---@field removeItemFromTrade ClientRemoveItemFromTrade
---@field selectDialogOption ClientSelectDialogOption
---@field continueDialog ClientContinueDialog
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
	self.clickInventoryItem = ClickInventoryItem.new(self.diContainer)
	self.clickInventoryItem:init()

	self.pickupLoot = PickupLoot.new(self.diContainer)
	self.pickupLoot:init()

	self.useLectern = UseLectern.new(self.diContainer)
	self.useLectern:init()

	self.equipItem = EquipItem.new(self.diContainer)
	self.equipItem:init()

	self.unequipItem = UnequipItem.new(self.diContainer)
	self.unequipItem:init()

	self.toggleSprint = ToggleSprint.new(self.diContainer)
	self.toggleSprint:init()

	self.startAlchemy = StartAlchemy.new(self.diContainer)
	self.startAlchemy:init()

	self.startSmithing = StartSmithing.new(self.diContainer)
	self.startSmithing:init()

	self.craftItem = CraftItem.new(self.diContainer)
	self.craftItem:init()

	self.startTrade = StartTrade.new(self.diContainer)
	self.startTrade:init()

	self.acceptTrade = AcceptTrade.new(self.diContainer)
	self.acceptTrade:init()

	self.addItemToTrade = AddItemToTrade.new(self.diContainer)
	self.addItemToTrade:init()

	self.removeItemFromTrade = RemoveItemFromTrade.new(self.diContainer)
	self.removeItemFromTrade:init()

	self.selectDialogOption = SelectDialogOption.new(self.diContainer)
	self.selectDialogOption:init()

	self.continueDialog = ContinueDialog.new(self.diContainer)
	self.continueDialog:init()
end

return UseCases
