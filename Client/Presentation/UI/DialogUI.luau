---@class DialogUI
---@field diContainer DIContainer
---@field bottom Frame
---@field characterHolder ViewportFrame
---@field _characterCFrame CFrame
---@field _dialogsCache table
---@field dialogService DialogService
---@field playerService ClientPlayerService
---@field dialogAnswerButtonTemplate TextButton
---@field _answersButtonConn table<string, RBXScriptConnection>
local DialogUI = {}
DialogUI.__index = DialogUI

---@param diContainer DIContainer
---@return DialogUI
function DialogUI.new(diContainer)
	local self = setmetatable({}, DialogUI)
	self.diContainer = diContainer
	self._currentNpc = nil
	self._answersButtonConn = {}
	return self
end

function DialogUI:init()
	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")

	self.dialogService = application.services.dialogService
	self.playerService = application.services.playerService
	self.dialogAnswerButtonTemplate = presentation.ui.components.DialogAnswerButtonTemplate

	local dialogUI = presentation.ui.uiManager.dialog
	self.bottom = dialogUI.Bottom
	self.characterHolder = dialogUI.CharacterHolder
	self._characterCFrame = self.characterHolder:GetAttribute("CharacterCFrame")
end

---@class showDialogData
---@field npc Model
---@field index number

---@param data showDialogData
function DialogUI:showDialog(data)
	local dialogData = self.dialogService.dialogsCache[data.npc]
	if dialogData then
		if self._currentNpc and self._currentNpc ~= dialogData.npc then
			local rig = dialogData.npc:Clone()
			self.characterHolder.WorldModel:ClearAllChildren()
			rig:PivotTo(self._characterCFrame)
			rig.Parent = self.characterHolder.WorldModel
			self._currentNpc = dialogData.npc
		elseif not self._currentNpc then
			local _rig = dialogData.npc:Clone()
			self.characterHolder.WorldModel:ClearAllChildren()
			_rig:PivotTo(self._characterCFrame)
			_rig.Parent = self.characterHolder.WorldModel
			self._currentNpc = dialogData.npc
		end

		-- TweenService:Create(self.characterHolder, TweenInfo.new(0.4), { Position = UDim2.fromScale(1, 0.4) }):Play()

		self.bottom.TextLabel.Text = dialogData.dialogData.phrases[dialogData.index]
		self.bottom.TextLabel.Visible = true
		self.bottom.Answers.Visible = false
	else
		warn("not found")
	end
end

function DialogUI:hideDialog()
	self.characterHolder.WorldModel:ClearAllChildren()
	self._currentNpc = nil
end

function DialogUI:showAnswers(data)
	local dialogData = self.dialogService.dialogsCache[data.npc]
	if dialogData then
		local playerEntity = self.playerService:getPlayerEntity()
		local rig = playerEntity._instance.Character:Clone()
		for _, v in rig:GetDescendants() do
			if v:IsA("Script") or v:IsA("LocalScript") then
				v:Destroy()
			end
		end

		self.characterHolder.WorldModel:ClearAllChildren()
		rig:PivotTo(self._characterCFrame)
		rig.Parent = self.characterHolder.WorldModel
		self._currentNpc = playerEntity._instance.Character

		self:_fillAnswers(dialogData.dialogData.answers)
		self.bottom.TextLabel.Visible = false
		self.bottom.Answers.Visible = true
	end
end

function DialogUI:_fillAnswers(answers)
	for _, v in self.bottom.Answers:GetChildren() do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end

	if not answers then
		return
	end

	for i, answer in answers do
		local answerButton = self.dialogAnswerButtonTemplate:Clone()
		answerButton.Parent = self.bottom.Answers
		answerButton.Body.TextLabel.Text = answer.text
		answerButton.MouseButton1Click:Connect(function()
			self.dialogService:selectAnswer(i)
		end)
	end
end

return DialogUI
