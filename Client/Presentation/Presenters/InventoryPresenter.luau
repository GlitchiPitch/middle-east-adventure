local BasePresenter = require(script.Parent.BasePresenter)

---@class InventoryPresenter : BasePresenter
---@field inventoryUI InventoryUI
---@field currentTab string Текущая активная вкладка
local InventoryPresenter = setmetatable({}, { __index = BasePresenter })
InventoryPresenter.__index = InventoryPresenter

---@param applicationFacade IApplicationFacade
---@param inventoryUI InventoryUI
---@return InventoryPresenter
function InventoryPresenter.new(applicationFacade, inventoryUI)
	local self = setmetatable(BasePresenter.new(applicationFacade), InventoryPresenter)
	self.inventoryUI = inventoryUI
	self.currentTab = "items"
	return self
end

function InventoryPresenter:init()
	BasePresenter.init(self)

	-- Подписываемся на изменения данных инвентаря
	self:subscribeToPlayerData("Inventory", function(data)
		self:updateInventoryDisplay()
	end)

	-- Подписываемся на изменения золота игрока
	self:subscribeToPlayerData("Stats", function(data)
		self:updateGoldDisplay()
	end)

	-- Подписываемся на события переключения инвентаря
	self:subscribeToFacadeEvent("toggleInventoryView", function(data)
		if data.isActive then
			self:onInventoryToggled()
			self.applicationFacade.uiManager:setCurrentScreen("inventory")
		else
			self.applicationFacade.uiManager:setCurrentScreen("primary")
		end
	end)
end

--- Обработка клика по предмету в инвентаре
---@param itemName string
function InventoryPresenter:onInventoryItemClicked(itemName)
	if self.isDestroyed then
		return
	end

	self.applicationFacade.inventoryCommands:clickInventoryItem(itemName)
end

--- Обработка переключения видимости инвентаря
function InventoryPresenter:onInventoryToggled()
	if self.isDestroyed then
		return
	end

	self.applicationFacade.inventoryCommands:toggleInventoryView()
end

--- Обновление отображения инвентаря
function InventoryPresenter:updateInventoryDisplay()
	if self.isDestroyed then
		return
	end

	self.inventoryUI:updateInventory()
end

--- Обновление отображения золота
function InventoryPresenter:updateGoldDisplay()
	if self.isDestroyed then
		return
	end

	-- Получаем данные статов и обновляем золото
	local statsData = self.applicationFacade.playerDataProvider:getStatsData()
	if statsData and statsData.gold then
		self.inventoryUI:updateGoldDisplay(statsData.gold)
	end
end

--- Переключение вкладки инвентаря
---@param tabName string
function InventoryPresenter:switchTab(tabName)
	if self.isDestroyed then
		return
	end

	self.currentTab = tabName
	self.inventoryUI:switchToTab(tabName)
end

return InventoryPresenter
