local BasePresenter = require(script.Parent.BasePresenter)

---@class TradePresenter : BasePresenter
---@field tradeUI TradeUI
local TradePresenter = setmetatable({}, { __index = BasePresenter })
TradePresenter.__index = TradePresenter

---@param applicationFacade IApplicationFacade
---@param tradeUI TradeUI
---@return TradePresenter
function TradePresenter.new(applicationFacade, tradeUI)
	local self = setmetatable(BasePresenter.new(applicationFacade), TradePresenter)
	self.tradeUI = tradeUI
	return self
end

function TradePresenter:init()
	BasePresenter.init(self)
	-- Торговля презентер пока что не имеет подписок,
	-- так как TradeUI еще не реализован
end

--- Начало торговли
function TradePresenter:onTradeStarted()
	if self.isDestroyed then
		return
	end

	self.applicationFacade.gameCommands:startTrade()
end

--- Принятие торговли
function TradePresenter:onTradeAccepted()
	if self.isDestroyed then
		return
	end

	self.applicationFacade.gameCommands:acceptTrade()
end

--- Добавление предмета в торговлю
---@param itemName string
function TradePresenter:onItemAddedToTrade(itemName)
	if self.isDestroyed then
		return
	end

	self.applicationFacade.gameCommands:addItemToTrade(itemName)
end

--- Удаление предмета из торговли
---@param itemName string
function TradePresenter:onItemRemovedFromTrade(itemName)
	if self.isDestroyed then
		return
	end

	self.applicationFacade.gameCommands:removeItemFromTrade(itemName)
end

return TradePresenter
