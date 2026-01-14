local BasePresenter = require(script.Parent.BasePresenter)

---@class DialogPresenter : BasePresenter
---@field dialogUI DialogUI
local DialogPresenter = setmetatable({}, { __index = BasePresenter })
DialogPresenter.__index = DialogPresenter

---@param applicationFacade IApplicationFacade
---@param dialogUI DialogUI
---@return DialogPresenter
function DialogPresenter.new(applicationFacade, dialogUI)
	local self = setmetatable(BasePresenter.new(applicationFacade), DialogPresenter)
	self.dialogUI = dialogUI
	return self
end

function DialogPresenter:init()
	BasePresenter.init(self)
	-- Диалог презентер не подписывается на изменения данных,
	-- так как диалог управляется событиями

	-- Подписываемся на события диалога
	self:subscribeToFacadeEvent("showDialog", function(data)
		self:showDialog(data)
		self.applicationFacade.uiManager:setCurrentScreen("dialog")
	end)

	self:subscribeToFacadeEvent("showAnswers", function(data)
		self:showAnswers(data)
	end)

	self:subscribeToFacadeEvent("finishDialog", function(_)
		self:hideDialog()
		self.applicationFacade.uiManager:setCurrentScreen("primary")
	end)
end

--- Выбор опции диалога
---@param optionIndex number
function DialogPresenter:onDialogOptionSelected(optionIndex)
	if self.isDestroyed then
		return
	end

	self.applicationFacade.dialogCommands:selectDialogOption(optionIndex)
end

--- Продолжение диалога
function DialogPresenter:onDialogContinued()
	if self.isDestroyed then
		return
	end

	self.applicationFacade.dialogCommands:continueDialog()
end

--- Показать диалог
---@param dialogData table
function DialogPresenter:showDialog(dialogData)
	if self.isDestroyed then
		return
	end

	self.dialogUI:showDialog(dialogData)
end

--- Показать ответы
---@param answersData table
function DialogPresenter:showAnswers(answersData)
	if self.isDestroyed then
		return
	end

	self.dialogUI:showAnswers(answersData)
end

--- Скрыть диалог
function DialogPresenter:hideDialog()
	if self.isDestroyed then
		return
	end

	self.dialogUI:hideDialog()
end

return DialogPresenter
