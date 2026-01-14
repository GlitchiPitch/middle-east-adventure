local InventoryPresenter = require(script.Parent.InventoryPresenter)
local EquipmentPresenter = require(script.Parent.EquipmentPresenter)
local DialogPresenter = require(script.Parent.DialogPresenter)
local AlchemyPresenter = require(script.Parent.AlchemyPresenter)
local SmithPresenter = require(script.Parent.SmithPresenter)
local TradePresenter = require(script.Parent.TradePresenter)
local StatsPresenter = require(script.Parent.StatsPresenter)
local AttributesPresenter = require(script.Parent.AttributesPresenter)

---@class PresenterFactory
---@field applicationFacade IApplicationFacade
---@field ui UI
local PresenterFactory = {}
PresenterFactory.__index = PresenterFactory

---@param applicationFacade IApplicationFacade
---@param ui UI
---@return PresenterFactory
function PresenterFactory.new(applicationFacade, ui)
	local self = setmetatable({}, PresenterFactory)
	self.applicationFacade = applicationFacade
	self.ui = ui
	return self
end

--- Создать презентер инвентаря
---@return InventoryPresenter
function PresenterFactory:createInventoryPresenter()
	return InventoryPresenter.new(self.applicationFacade, self.ui.inventoryUI)
end

--- Создать презентер экипировки
---@return EquipmentPresenter
function PresenterFactory:createEquipmentPresenter()
	return EquipmentPresenter.new(self.applicationFacade, self.ui.equipmentUI)
end

--- Создать презентер диалога
---@return DialogPresenter
function PresenterFactory:createDialogPresenter()
	return DialogPresenter.new(self.applicationFacade, self.ui.dialogUI)
end

--- Создать презентер алхимии
---@return AlchemyPresenter
function PresenterFactory:createAlchemyPresenter()
	return AlchemyPresenter.new(self.applicationFacade, self.ui.alchemyUI)
end

--- Создать презентер кузнечного дела
---@return SmithPresenter
function PresenterFactory:createSmithPresenter()
	return SmithPresenter.new(self.applicationFacade, self.ui.smithUI)
end

--- Создать презентер торговли
---@return TradePresenter
function PresenterFactory:createTradePresenter()
	return TradePresenter.new(self.applicationFacade, self.ui.tradeUI)
end

--- Создать презентер статов
---@return StatsPresenter
function PresenterFactory:createStatsPresenter()
	return StatsPresenter.new(self.applicationFacade, self.ui.statsUI)
end

--- Создать презентер атрибутов
---@return AttributesPresenter
function PresenterFactory:createAttributesPresenter()
	return AttributesPresenter.new(self.applicationFacade, self.ui.attributesUI)
end

return PresenterFactory
