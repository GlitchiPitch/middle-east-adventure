--- Базовый презентер с общей логикой для всех презентеров
---@class BasePresenter
---@field applicationFacade IApplicationFacade
---@field uiManager IUIManager
---@field eventSubscriptions table<string, string> Таблица подписок на события
---@field facadeEventSubscriptions table<string, string> Таблица подписок на события фасада
---@field isDestroyed boolean Флаг уничтожения презентера
local BasePresenter = {}
BasePresenter.__index = BasePresenter

---@param applicationFacade IApplicationFacade
---@return BasePresenter
function BasePresenter.new(applicationFacade)
	local self = setmetatable({}, BasePresenter)
	self.applicationFacade = applicationFacade
	self.uiManager = applicationFacade.uiManager
	self.eventSubscriptions = {}
	self.facadeEventSubscriptions = {}
	self.isDestroyed = false
	return self
end

--- Инициализация презентера
function BasePresenter:init()
	-- Переопределяется в наследниках
end

--- Подписка на события через фасад с автоматической отпиской при уничтожении
---@param eventName string
---@param callback function
---@return string subscriptionId
function BasePresenter:subscribeToFacadeEvent(eventName, callback)
	if self.isDestroyed then
		return ""
	end

	local subscriptionId = self.applicationFacade:subscribeToEvent(eventName, callback)
	self.facadeEventSubscriptions[subscriptionId] = eventName
	return subscriptionId
end

--- Уничтожение презентера и отписка от всех событий
function BasePresenter:destroy()
	if self.isDestroyed then
		return
	end

	-- Отписываемся от событий данных игрока
	for eventName, subscriptionId in pairs(self.eventSubscriptions) do
		self.applicationFacade.playerDataObserver:unsubscribe(subscriptionId)
		self.eventSubscriptions[eventName] = nil
	end

	-- Отписываемся от событий фасада
	for subscriptionId in pairs(self.facadeEventSubscriptions) do
		self.applicationFacade:unsubscribeFromEvent(subscriptionId)
	end
	self.facadeEventSubscriptions = {}

	self.isDestroyed = true
end

--- Подписка на изменения данных игрока с автоматической отпиской при уничтожении
---@param eventName string
---@param callback function
---@return string subscriptionId
function BasePresenter:subscribeToPlayerData(eventName, callback)
	if self.isDestroyed then
		return ""
	end

	local subscriptionId = self.applicationFacade.playerDataObserver["subscribeTo" .. eventName .. "Changes"](callback)
	self.eventSubscriptions[eventName] = subscriptionId
	return subscriptionId
end

--- Проверка, уничтожен ли презентер
---@return boolean
function BasePresenter:getIsDestroyed()
	return self.isDestroyed
end

return BasePresenter
