---@class Config
local Config = {
	PlayerDataStoreKey = "PlayerData",

	Client = {
		PopupLifeTime = 2,
		Control = {
			MainAction = Enum.UserInputType.MouseButton1,
			SecondAction = Enum.UserInputType.MouseButton2,
			FreeMouse = Enum.KeyCode.F,
			TargetCamera = Enum.KeyCode.E,
			RunKey = Enum.KeyCode.LeftShift,
		},
		UpdateBarTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
	},
}
return Config
