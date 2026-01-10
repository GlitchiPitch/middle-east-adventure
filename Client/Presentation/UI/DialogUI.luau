local TweenService = game:GetService("TweenService")
---@class DialogUI
---@field diContainer DIContainer
---@field bottom Frame
---@field characterHolder ViewportFrame
---@field _characterCFrame CFrame
---@field _dialogsCache table
local DialogUI = {}
DialogUI.__index = DialogUI

---@param diContainer DIContainer
---@return DialogUI
function DialogUI.new(diContainer)
	local self = setmetatable({}, DialogUI)
	self.diContainer = diContainer
	self._dialogsCache = {}
	return self
end

function DialogUI:init()
	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")
	local dialogUI = presentation.ui.uiManager.dialog
	self.bottom = dialogUI.Bottom
	self.characterHolder = dialogUI.CharacterHolder
	self._characterCFrame = self.characterHolder:GetAttribute("CharacterCFrame")
end

---@class createDialogData
---@field dialogData table
---@field npc Model

---@param data createDialogData
function DialogUI:createDialog(data)
	self._dialogsCache[data.npc] = {
		dialogData = data.dialogData,
		npc = data.npc,
	}

	--// Add character rig to viewport if needed

	-- --// Cleanup
	-- clickConnection:Disconnect()
	-- clickConnection = nil
	-- dialogContainer.Label.Text = ""
	-- dialogContainer.Continue.Text = ""
end

---@class showDialogData
---@field npc Model

---@param data showDialogData
function DialogUI:showDialog(data)
	local dialogData = self._dialogsCache[data.npc]
	if dialogData then
		local rig = dialogData.npc:Clone()

		self.characterHolder.WorldModel:ClearAllChildren()
		--// Continue on with editing rig properties
		rig:PivotTo(self._characterCFrame)
		rig.Parent = self.characterHolder.WorldModel
		-- TweenService:Create(self.characterHolder, TweenInfo.new(0.4), { Position = UDim2.fromScale(1, 0.4) }):Play()

		self.bottom.TextLabel.Text = data.Text
	else
		warn("not found")
	end
end

function DialogUI:hideDialog()
	self.characterHolder.WorldModel:ClearAllChildren()
end

return DialogUI
