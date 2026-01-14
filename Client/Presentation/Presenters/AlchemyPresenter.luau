local BasePresenter = require(script.Parent.BasePresenter)

---@class AlchemyPresenter : BasePresenter
---@field alchemyUI AlchemyUI
local AlchemyPresenter = setmetatable({}, { __index = BasePresenter })
AlchemyPresenter.__index = AlchemyPresenter

---@param applicationFacade IApplicationFacade
---@param alchemyUI AlchemyUI
---@return AlchemyPresenter
function AlchemyPresenter.new(applicationFacade, alchemyUI)
	local self = setmetatable(BasePresenter.new(applicationFacade), AlchemyPresenter)
	self.alchemyUI = alchemyUI
	return self
end

function AlchemyPresenter:init()
	BasePresenter.init(self)

	-- Подписываемся на изменения данных игрока для обновления рецептов
	self:subscribeToPlayerData("Skills", function(data)
		self:updateRecipesDisplay()
	end)

	self:subscribeToPlayerData("Inventory", function(data)
		self:updateRecipesDisplay()
	end)

	-- Подписываемся на события режима алхимии
	self:subscribeToFacadeEvent("setAlchemyMode", function(data)
		if data.isActive then
			self:onAlchemyStarted()
			self.applicationFacade.uiManager:setCurrentScreen("alchemy")
		else
			self:onAlchemyStopped()
			self.applicationFacade.uiManager:setCurrentScreen("primary")
		end
	end)
end

--- Начало алхимии
function AlchemyPresenter:onAlchemyStarted()
	if self.isDestroyed then
		return
	end

	self.applicationFacade.gameCommands:startAlchemy()
end

--- Остановка алхимии
function AlchemyPresenter:onAlchemyStopped()
	if self.isDestroyed then
		return
	end

	-- Здесь можно добавить логику остановки алхимии
	-- Переключение экрана обрабатывается в подписке на событие
end

--- Обновление рецептов
function AlchemyPresenter:updateRecipesDisplay()
	if self.isDestroyed then
		return
	end

	self.alchemyUI:updatePlayerRecipes()
end

return AlchemyPresenter
