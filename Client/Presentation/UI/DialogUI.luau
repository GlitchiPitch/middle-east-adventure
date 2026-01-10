---@class DialogUI
---@field diContainer DIContainer
---@field bottom Frame
---@field characterHolder ViewportFrame
---@field _characterCFrame CFrame
---@field _dialogsCache table
---@field dialogService DialogService
local DialogUI = {}
DialogUI.__index = DialogUI

---@param diContainer DIContainer
---@return DialogUI
function DialogUI.new(diContainer)
	local self = setmetatable({}, DialogUI)
	self.diContainer = diContainer
	self._currentNpc = nil
	return self
end

function DialogUI:init()
	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	self.dialogService = application.services.dialogService

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

		self.bottom.TextLabel.Text = dialogData.dialogData[dialogData.index]
	else
		warn("not found")
	end
end

function DialogUI:hideDialog()
	self.characterHolder.WorldModel:ClearAllChildren()
	self._currentNpc = nil
end

return DialogUI
