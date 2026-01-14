local BasePresenter = require(script.Parent.BasePresenter)

---@class EquipmentPresenter : BasePresenter
---@field equipmentUI EquipmentUI
local EquipmentPresenter = setmetatable({}, { __index = BasePresenter })
EquipmentPresenter.__index = EquipmentPresenter

---@param applicationFacade IApplicationFacade
---@param equipmentUI EquipmentUI
---@return EquipmentPresenter
function EquipmentPresenter.new(applicationFacade, equipmentUI)
	local self = setmetatable(BasePresenter.new(applicationFacade), EquipmentPresenter)
	self.equipmentUI = equipmentUI
	return self
end

function EquipmentPresenter:init()
	BasePresenter.init(self)

	-- Подписываемся на изменения данных экипировки
	self:subscribeToPlayerData("Equipment", function(data)
		self:updateEquipmentDisplay()
	end)

	-- Подписываемся на события кнопки действия
	self:subscribeToFacadeEvent("toggleActionButton", function(data)
		self:toggleActionButton(data.state)
	end)
end

--- Обработка клика по слоту экипировки
---@param slotIndex string
function EquipmentPresenter:onSlotClicked(slotIndex)
	if self.isDestroyed then
		return
	end

	-- Определяем, экипировать или снять предмет
	local equipmentData = self.applicationFacade.playerDataProvider:getEquipmentData()
	local currentItem = equipmentData.slots and equipmentData.slots[slotIndex]

	if currentItem then
		self.applicationFacade.equipmentCommands:unequipItem(slotIndex)
	else
		-- Здесь можно открыть интерфейс выбора предмета для экипировки
		-- Пока что просто ничего не делаем
	end
end

--- Обновление отображения экипировки
function EquipmentPresenter:updateEquipmentDisplay()
	if self.isDestroyed then
		return
	end

	self.equipmentUI:update()
end

--- Переключение кнопки действия
---@param state boolean
function EquipmentPresenter:toggleActionButton(state)
	if self.isDestroyed then
		return
	end

	self.equipmentUI:toggleActionButton(state)
	-- Команда toggleActionButton уже вызвана через событие, не дублируем
end

return EquipmentPresenter
