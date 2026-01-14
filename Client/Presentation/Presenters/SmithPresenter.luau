local BasePresenter = require(script.Parent.BasePresenter)

---@class SmithPresenter : BasePresenter
---@field smithUI SmithUI
local SmithPresenter = setmetatable({}, { __index = BasePresenter })
SmithPresenter.__index = SmithPresenter

---@param applicationFacade IApplicationFacade
---@param smithUI SmithUI
---@return SmithPresenter
function SmithPresenter.new(applicationFacade, smithUI)
	local self = setmetatable(BasePresenter.new(applicationFacade), SmithPresenter)
	self.smithUI = smithUI
	return self
end

function SmithPresenter:init()
	BasePresenter.init(self)

	-- Подписываемся на изменения данных игрока для обновления рецептов
	self:subscribeToPlayerData("Skills", function(data)
		self:updateRecipesDisplay()
	end)

	self:subscribeToPlayerData("Inventory", function(data)
		self:updateRecipesDisplay()
	end)

	-- Подписываемся на события режима кузнечного дела
	self:subscribeToFacadeEvent("setSmithMode", function(data)
		if data.isActive then
			self:onSmithingStarted()
			self.applicationFacade.uiManager:setCurrentScreen("smith")
		else
			self:onSmithingStopped()
			self.applicationFacade.uiManager:setCurrentScreen("primary")
		end
	end)
end

--- Начало кузнечного дела
function SmithPresenter:onSmithingStarted()
	if self.isDestroyed then
		return
	end

	self.applicationFacade.gameCommands:startSmithing()
end

--- Остановка кузнечного дела
function SmithPresenter:onSmithingStopped()
	if self.isDestroyed then
		return
	end

	-- Здесь можно добавить логику остановки кузнечного дела
	-- Переключение экрана обрабатывается в подписке на событие
end

--- Обновление рецептов
function SmithPresenter:updateRecipesDisplay()
	if self.isDestroyed then
		return
	end

	-- SmithUI:start() - обновляет рецепты
	self.smithUI:start()
end

return SmithPresenter
