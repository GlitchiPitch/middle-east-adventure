--- Интерфейсы для взаимодействия между Presentation и Application слоями
--- Решают проблемы тесной связанности и отсутствия абстракций

---@alias ScreenName '"primary"' | '"inventory"' | '"equipment"' | '"alchemy"' | '"smith"' | '"trade"' | '"dialog"' | '"startingScreen"'

--------------------------------------------------------------------------------
--- Интерфейсы для доступа к данным игрока
--------------------------------------------------------------------------------

--- Интерфейс для получения данных игрока
---@class IPlayerDataProvider
local IPlayerDataProvider = {}
function IPlayerDataProvider:getEquipmentData() end -- -> table: Данные экипировки
function IPlayerDataProvider:getInventoryData() end -- -> table: Данные инвентаря
function IPlayerDataProvider:getStatsData() end -- -> table: Данные статов
function IPlayerDataProvider:getAttributesData() end -- -> table: Данные атрибутов
function IPlayerDataProvider:getSkillsData() end -- -> table: Данные навыков

--- Интерфейс для подписки на изменения данных игрока
---@class IPlayerDataObserver
local IPlayerDataObserver = {}
---@param callback fun(data: table)
function IPlayerDataObserver:subscribeToInventoryChanges(callback) end -- -> string
---@param callback fun(data: table)
function IPlayerDataObserver:subscribeToEquipmentChanges(callback) end -- -> string
---@param callback fun(data: table)
function IPlayerDataObserver:subscribeToStatsChanges(callback) end -- -> string
---@param callback fun(data: table)
function IPlayerDataObserver:subscribeToAttributesChanges(callback) end -- -> string
---@param callback fun(data: table)
function IPlayerDataObserver:subscribeToSkillsChanges(callback) end -- -> string
---@param observerId string
function IPlayerDataObserver:unsubscribe(observerId) end

--------------------------------------------------------------------------------
--- Интерфейсы для команд (Use Cases)
--------------------------------------------------------------------------------

--- Интерфейс команд инвентаря
---@class IInventoryCommands
local IInventoryCommands = {}
function IInventoryCommands:clickInventoryItem(itemName: string) end -- - Клик по предмету в инвентаре
function IInventoryCommands:toggleInventoryView() end -- - Переключение видимости инвентаря

--- Интерфейс команд экипировки
---@class IEquipmentCommands
local IEquipmentCommands = {}
function IEquipmentCommands:equipItem(slotIndex: string) end -- - Экипировать предмет
function IEquipmentCommands:unequipItem(slotIndex: string) end -- - Снять предмет
function IEquipmentCommands:toggleActionButton(state: boolean) end -- - Переключить кнопку действия

--- Интерфейс команд диалога
---@class IDialogCommands
local IDialogCommands = {}
function IDialogCommands:selectDialogOption(optionIndex: number) end -- - Выбрать опцию диалога
function IDialogCommands:continueDialog() end -- - Продолжить диалог

--- Интерфейс игровых команд
---@class IGameCommands
local IGameCommands = {}
function IGameCommands:toggleSprint() end -- - Переключить бег
function IGameCommands:startAlchemy() end -- - Начать алхимию
function IGameCommands:startSmithing() end -- - Начать кузнечное дело
function IGameCommands:startTrade() end -- - Начать торговлю
function IGameCommands:acceptTrade() end -- - Принять торговлю
function IGameCommands:addItemToTrade(itemName: string) end -- - Добавить предмет в торговлю
function IGameCommands:removeItemFromTrade(itemName: string) end -- - Убрать предмет из торговли
function IGameCommands:pickupLoot(loot: Model) end -- - Подобрать лут
function IGameCommands:useLectern(lectern: Model) end -- - Использовать лекторн
function IGameCommands:craftItem(itemName: string) end -- - Создать предмет

--------------------------------------------------------------------------------
--- Интерфейсы для UI состояния
--------------------------------------------------------------------------------

--- Интерфейс управления UI экранами
---@class IUIManager
local IUIManager = {}
function IUIManager:setCurrentScreen(screenName: string) end -- - Установить текущий экран
function IUIManager:showScreen(screenName: string) end -- - Показать экран
function IUIManager:hideScreen(screenName: string) end -- - Скрыть экран
function IUIManager:toggleScreen(screenName: string) end -- - Переключить экран
function IUIManager:getCurrentScreen() end -- -> string - Получить текущий экран

--------------------------------------------------------------------------------
--- Интерфейсы для презентеров
--------------------------------------------------------------------------------

--- Базовый интерфейс презентера
---@class IPresenter
local IPresenter = {}
function IPresenter:init() end -- - Инициализация презентера
function IPresenter:destroy() end -- - Уничтожение презентера

--- Интерфейс презентера инвентаря
---@class IInventoryPresenter
local IInventoryPresenter = {}
function onInventoryItemClicked(itemName: string) end -- - Обработка клика по предмету
function onInventoryToggled() end -- - Обработка переключения инвентаря
function updateInventoryDisplay() end -- - Обновление отображения инвентаря

--- Интерфейс презентера экипировки
---@class IEquipmentPresenter
local IEquipmentPresenter = {}
function IEquipmentPresenter:onSlotClicked(slotIndex: string) end -- - Обработка клика по слоту
function IEquipmentPresenter:updateEquipmentDisplay() end -- - Обновление отображения экипировки
function IEquipmentPresenter:toggleActionButton(state: boolean) end -- - Переключение кнопки действия

--- Интерфейс презентера диалога
---@class IDialogPresenter
local IDialogPresenter = {}
function IDialogPresenter:onDialogOptionSelected(optionIndex: number) end -- - Выбор опции диалога
function IDialogPresenter:onDialogContinued() end -- - Продолжение диалога
---@param dialogData table
function IDialogPresenter:showDialog(dialogData) end -- - Показать диалог
---@param answersData table
function IDialogPresenter:showAnswers(answersData) end -- - Показать ответы
function IDialogPresenter:hideDialog() end -- - Скрыть диалог

--- Интерфейс презентера алхимии
---@class IAlchemyPresenter
local IAlchemyPresenter = {}
function IAlchemyPresenter:onAlchemyStarted() end -- - Начало алхимии
function IAlchemyPresenter:onAlchemyStopped() end -- - Остановка алхимии
function IAlchemyPresenter:updateRecipesDisplay() end -- - Обновление рецептов

--- Интерфейс презентера кузнечного дела
---@class ISmithPresenter
local ISmithPresenter = {}
function ISmithPresenter:onSmithingStarted() end -- - Начало кузнечного дела
function ISmithPresenter:onSmithingStopped() end -- - Остановка кузнечного дела
function ISmithPresenter:updateRecipesDisplay() end -- - Обновление рецептов

--- Интерфейс презентера торговли
---@class ITradePresenter
local ITradePresenter = {}
function ITradePresenter:onTradeStarted() end -- - Начало торговли
function ITradePresenter:onTradeAccepted() end -- - Принятие торговли
function ITradePresenter:onItemAddedToTrade(itemName: string) end -- - Добавление предмета в торговлю
function ITradePresenter:onItemRemovedFromTrade(itemName: string) end -- - Удаление предмета из торговли

--- Интерфейс презентера статов
---@class IStatsPresenter
local IStatsPresenter = {}
function IStatsPresenter:updateStatsDisplay() end -- - Обновление отображения статов

--- Интерфейс презентера атрибутов
---@class IAttributesPresenter
local IAttributesPresenter = {}
function IAttributesPresenter:updateAttributesDisplay() end -- - Обновление отображения атрибутов

--------------------------------------------------------------------------------
--- Интерфейсы для фабрик презентеров
--------------------------------------------------------------------------------

--- Интерфейс фабрики презентеров
---@class IPresenterFactory
local IPresenterFactory = {}
function IPresenterFactory:createInventoryPresenter() end -- -> table - Создать презентер инвентаря
function IPresenterFactory:createEquipmentPresenter() end -- -> table - Создать презентер экипировки
function IPresenterFactory:createDialogPresenter() end -- -> table - Создать презентер диалога
function IPresenterFactory:createAlchemyPresenter() end -- -> table - Создать презентер алхимии
function IPresenterFactory:createSmithPresenter() end -- -> table - Создать презентер кузнечного дела
function IPresenterFactory:createTradePresenter() end -- -> table - Создать презентер торговли
function IPresenterFactory:createStatsPresenter() end -- -> table - Создать презентер статов
function IPresenterFactory:createAttributesPresenter() end -- -> table - Создать презентер атрибутов

--------------------------------------------------------------------------------
--- Общий фасад Application для Presentation
--------------------------------------------------------------------------------

--- Основной фасад Application слоя для Presentation
---@class IApplicationFacade
---@field playerDataProvider table - Провайдер данных игрока
---@field playerDataObserver table - Наблюдатель за данными игрока
---@field inventoryCommands table - Команды инвентаря
---@field equipmentCommands table - Команды экипировки
---@field dialogCommands table - Команды диалога
---@field gameCommands table - Игровые команды
---@field uiManager table - Менеджер UI
---@field presenterFactory table - Фабрика презентеров
local IApplicationFacade = {}
function IApplicationFacade:subscribeToEvent(eventName: string, callback) end -- -> string - Подписка на событие
function IApplicationFacade:unsubscribeFromEvent(subscriptionId: string) end -- - Отписка от события
function IApplicationFacade:destroy() end -- - Уничтожение фасада

--------------------------------------------------------------------------------
--- Экспорт интерфейсов
--------------------------------------------------------------------------------

---@class PresentationInterfaces
local PresentationInterfaces = {
	-- Data interfaces
	IPlayerDataProvider = IPlayerDataProvider,
	IPlayerDataObserver = IPlayerDataObserver,

	-- Command interfaces
	IInventoryCommands = IInventoryCommands,
	IEquipmentCommands = IEquipmentCommands,
	IDialogCommands = IDialogCommands,
	IGameCommands = IGameCommands,

	-- UI interfaces
	IUIManager = IUIManager,

	-- Presenter interfaces
	IPresenter = IPresenter,
	IInventoryPresenter = IInventoryPresenter,
	IEquipmentPresenter = IEquipmentPresenter,
	IDialogPresenter = IDialogPresenter,
	IAlchemyPresenter = IAlchemyPresenter,
	ISmithPresenter = ISmithPresenter,
	ITradePresenter = ITradePresenter,
	IStatsPresenter = IStatsPresenter,
	IAttributesPresenter = IAttributesPresenter,

	-- Factory interfaces
	IPresenterFactory = IPresenterFactory,

	-- Facade interface
	IApplicationFacade = IApplicationFacade,
}

return PresentationInterfaces
