---@class ApplicationFacade : IApplicationFacade
---@field application ClientApplication
---@field shared Shared
local ApplicationFacade = {}
ApplicationFacade.__index = ApplicationFacade

---@param application ClientApplication
---@param shared Shared
---@return ApplicationFacade
function ApplicationFacade.new(application, shared)
	local self = setmetatable({}, ApplicationFacade)

	-- Data providers and observers
	self.playerDataProvider = {
		getInventoryData = function()
			local playerEntity = application.services.playerService:getPlayerEntity()
			return playerEntity and playerEntity.inventory:toData() or {}
		end,

		getEquipmentData = function()
			local playerEntity = application.services.playerService:getPlayerEntity()
			return playerEntity and playerEntity.equipment:toData() or {}
		end,

		getStatsData = function()
			local playerEntity = application.services.playerService:getPlayerEntity()
			return playerEntity and playerEntity.stats:toData() or {}
		end,

		getAttributesData = function()
			local playerEntity = application.services.playerService:getPlayerEntity()
			return playerEntity and playerEntity.attributes:toData() or {}
		end,

		getSkillsData = function()
			local playerEntity = application.services.playerService:getPlayerEntity()
			return playerEntity and playerEntity.skills:toData() or {}
		end,
	}

	self.playerDataObserver = {
		subscribeToInventoryChanges = function(callback)
			return shared.eventBus:connect("updatePlayerData", callback)
		end,

		subscribeToEquipmentChanges = function(callback)
			return shared.eventBus:connect("updatePlayerData", callback)
		end,

		subscribeToStatsChanges = function(callback)
			return shared.eventBus:connect("updatePlayerData", callback)
		end,

		subscribeToAttributesChanges = function(callback)
			return shared.eventBus:connect("updatePlayerData", callback)
		end,

		subscribeToSkillsChanges = function(callback)
			return shared.eventBus:connect("updatePlayerData", callback)
		end,

		unsubscribe = function(subscriptionId)
			shared.eventBus:disconnect(subscriptionId)
		end,
	}

	-- Command interfaces
	self.inventoryCommands = {
		clickInventoryItem = function(itemName)
			application.useCases.clickInventoryItem:execute(itemName)
		end,

		toggleInventoryView = function()
			application.useCases.toggleInventoryView:execute()
		end,
	}

	self.equipmentCommands = {
		equipItem = function(slotIndex)
			application.useCases.equipItem:execute(slotIndex)
		end,

		unequipItem = function(slotIndex)
			application.useCases.unequipItem:execute(slotIndex)
		end,

		toggleActionButton = function(state)
			shared.eventBus:fire("toggleActionButton", { state = state })
		end,
	}

	self.dialogCommands = {
		selectDialogOption = function(optionIndex)
			application.useCases.selectDialogOption:execute(optionIndex)
		end,

		continueDialog = function()
			application.useCases.continueDialog:execute()
		end,
	}

	self.gameCommands = {
		toggleSprint = function()
			application.useCases.toggleSprint:execute()
		end,

		startAlchemy = function()
			application.useCases.startAlchemy:execute()
		end,

		startSmithing = function()
			application.useCases.startSmithing:execute()
		end,

		startTrade = function()
			application.useCases.startTrade:execute()
		end,

		acceptTrade = function()
			application.useCases.acceptTrade:execute()
		end,

		addItemToTrade = function(itemName)
			application.useCases.addItemToTrade:execute(itemName)
		end,

		removeItemFromTrade = function(itemName)
			application.useCases.removeItemFromTrade:execute(itemName)
		end,

		pickupLoot = function(loot)
			application.useCases.pickupLoot:execute(loot)
		end,

		useLectern = function(lectern)
			application.useCases.useLectern:execute(lectern)
		end,

		craftItem = function(itemName)
			application.useCases.craftItem:execute(itemName)
		end,
	}

	-- UI Manager (предполагаем, что он будет в shared или где-то еще)
	-- Пока что создам заглушку
	self.uiManager = {
		setCurrentScreen = function(screenName)
			shared.eventBus:fire("setScreen", { screen = screenName })
		end,

		showScreen = function(screenName)
			shared.eventBus:fire("showScreen", { screen = screenName })
		end,

		hideScreen = function(screenName)
			shared.eventBus:fire("hideScreen", { screen = screenName })
		end,

		toggleScreen = function(screenName)
			shared.eventBus:fire("toggleScreen", { screen = screenName })
		end,

		getCurrentScreen = function()
			return "primary" -- заглушка
		end,
	}

	-- Event subscriptions
	self.eventSubscriptions = {}

	-- Сохраняем ссылки для внутреннего использования
	self.application = application
	self.shared = shared

	return self
end

---@param eventName string
---@param callback function
---@return string subscriptionId
function ApplicationFacade:subscribeToEvent(eventName, callback)
	local subscriptionId = self.shared.eventBus:connect(eventName, callback)
	self.eventSubscriptions[subscriptionId] = eventName
	return subscriptionId
end

---@param subscriptionId string
function ApplicationFacade:unsubscribeFromEvent(subscriptionId)
	if self.eventSubscriptions[subscriptionId] then
		self.shared.eventBus:disconnect(subscriptionId)
		self.eventSubscriptions[subscriptionId] = nil
	end
end

--- Уничтожение фасада и отписка от всех событий
function ApplicationFacade:destroy()
	for subscriptionId in pairs(self.eventSubscriptions) do
		self.shared.eventBus:disconnect(subscriptionId)
	end
	self.eventSubscriptions = {}
end

return ApplicationFacade
