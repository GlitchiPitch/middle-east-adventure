local BasePresenter = require(script.BasePresenter)
local InventoryPresenter = require(script.InventoryPresenter)
local EquipmentPresenter = require(script.EquipmentPresenter)
local DialogPresenter = require(script.DialogPresenter)
local AlchemyPresenter = require(script.AlchemyPresenter)
local SmithPresenter = require(script.SmithPresenter)
local TradePresenter = require(script.TradePresenter)
local StatsPresenter = require(script.StatsPresenter)
local AttributesPresenter = require(script.AttributesPresenter)
local PresenterFactory = require(script.PresenterFactory)

---@class Presenters
local Presenters = {
	-- Base classes
	BasePresenter = BasePresenter,

	-- Concrete presenters
	InventoryPresenter = InventoryPresenter,
	EquipmentPresenter = EquipmentPresenter,
	DialogPresenter = DialogPresenter,
	AlchemyPresenter = AlchemyPresenter,
	SmithPresenter = SmithPresenter,
	TradePresenter = TradePresenter,
	StatsPresenter = StatsPresenter,
	AttributesPresenter = AttributesPresenter,

	-- Factory
	PresenterFactory = PresenterFactory,
}

return Presenters