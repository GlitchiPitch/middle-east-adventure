local UI = require(script.UI)
local Presenters = require(script.Presenters)
local ApplicationFacade = require(script.ApplicationFacade)

---@class Presentation
---@field ui UI
---@field presenters Presenters
---@field presenterFactory table
---@field applicationFacade ApplicationFacade
---@field diContainer DIContainer
local Presentation = {}
Presentation.__index = Presentation

---@param diContainer DIContainer
---@return Presentation
function Presentation.new(diContainer)
	local self = setmetatable({}, Presentation)
	self.diContainer = diContainer
	self.ui = UI.new(diContainer)

	-- Создаем Application Facade
	---@type ClientApplication
	local application = diContainer:resolve("Application")
	---@type Shared
	local shared = diContainer:resolve("Shared")
	self.applicationFacade = ApplicationFacade.new(application, shared)

	-- Создаем фабрику презентеров
	self.presenterFactory = Presenters.PresenterFactory.new(self.applicationFacade, self.ui)

	-- Создаем презентеры
	self.presenters = {
		inventory = self.presenterFactory:createInventoryPresenter(),
		equipment = self.presenterFactory:createEquipmentPresenter(),
		dialog = self.presenterFactory:createDialogPresenter(),
		alchemy = self.presenterFactory:createAlchemyPresenter(),
		smith = self.presenterFactory:createSmithPresenter(),
		trade = self.presenterFactory:createTradePresenter(),
		stats = self.presenterFactory:createStatsPresenter(),
		attributes = self.presenterFactory:createAttributesPresenter(),
	}

	return self
end

function Presentation:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	-- Инициализируем UI
	self.ui:init()

	-- Инициализируем презентеры
	for _, presenter in pairs(self.presenters) do
		presenter:init()
	end

	-- Подписываемся на события обновления данных игрока для UI
	shared.eventBus:connect("updatePlayerData", function()
		self.ui:update()
	end)
end

--- Уничтожение всех презентеров и фасада при уничтожении Presentation
function Presentation:destroy()
	-- Уничтожаем презентеры
	for _, presenter in pairs(self.presenters) do
		if presenter.destroy then
			presenter:destroy()
		end
	end

	-- Уничтожаем фасад
	if self.applicationFacade and self.applicationFacade.destroy then
		self.applicationFacade:destroy()
	end
end

return Presentation
