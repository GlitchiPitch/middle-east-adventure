local TweenService = game:GetService("TweenService")
---@class DialogUI
local DialogUI = {}
DialogUI.__index = DialogUI

---@return DialogUI
function DialogUI.new()
    local self = setmetatable({}, DialogUI)
    return self
end

function DialogUI:init()
    
	self.UI = Instance.new("ScreenGui")
	self.UI.Name = "MiamiDialog"
	self.UI.IgnoreGuiInset = true
	self.UI.ResetOnSpawn = false
	self.UI.Parent = self.Player.PlayerGui

end

function DialogUI:showDialog()
    --// Create dialog UI
	local dialogUI = script.DialogMain:Clone()
	dialogUI.Parent = self.UI

	--// Set dialog container properties n stuff
	local dialogContainer = dialogUI.Bars.Bottom.DialogContainer
	dialogContainer.Label.TextColor3 = Color3.new(0.95, 0.95, 1) --DarkenColor(config.MAIN_COLOR, -90)
	dialogContainer.Continue.TextColor3 = DarkenColor(config.MAIN_COLOR, 50)

	--// Set text sizes
	dialogContainer.Label.TextSize = dialogContainer.Label.AbsoluteSize.Y / 5
	dialogContainer.Continue.TextSize = dialogContainer.Continue.AbsoluteSize.Y / 5
	dialogContainer.Label.Text = ""
	dialogContainer.Continue.Text = ""

	--// Set general dialog properties
	dialogUI.Bars.Top.Size = UDim2.fromScale(1, 0)
	dialogUI.Bars.Bottom.Size = UDim2.fromScale(1, 0)
	dialogUI.CharacterBackground.Position = UDim2.fromScale(1.35, 0.475)
	dialogUI.CharacterBackground.Color.BackgroundColor3 = config.SECONDARY_COLOR
	dialogUI.CharacterBackground.Rotation = 90
	dialogUI.CharacterHolder.Position = UDim2.fromScale(1.5, 0.4)
	dialogUI.CharacterHolder.Rotation = 5

	--// Setup viewport stuff
	local worldModel = Instance.new("WorldModel")
	worldModel.Parent = dialogUI.CharacterHolder
	-- DialogService.Character.Archivable = true

	--// Tween stuff
	TweenService:Create(dialogUI.Bars.Top, TweenInfo.new(0.25), { Size = UDim2.fromScale(1, 0.225) }):Play()
	TweenService:Create(dialogUI.Bars.Bottom, TweenInfo.new(0.25), { Size = UDim2.fromScale(1, 0.3) }):Play()
	TweenService:Create(
		dialogUI.CharacterBackground.Color,
		TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true),
		{ BackgroundColor3 = config.MAIN_COLOR }
	):Play()
	TweenService:Create(
		dialogUI.CharacterHolder,
		TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
		{ Rotation = -dialogUI.CharacterHolder.Rotation }
	):Play()
	TweenService:Create(
		dialogContainer.Label,
		TweenInfo.new(0.875, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true),
		{ Position = UDim2.fromOffset(-6, -6) }
	):Play()
	TweenService:Create(
		dialogContainer.Label,
		TweenInfo.new(3.5, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, -1, true),
		{ TextColor3 = config.MAIN_COLOR }
	):Play()
	TweenService:Create(
		dialogContainer.Continue,
		TweenInfo.new(3.5, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, -1, true),
		{ TextColor3 = config.SECONDARY_COLOR }
	):Play()

end

return DialogUI