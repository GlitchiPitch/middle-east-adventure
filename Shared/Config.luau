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

			EquippmentKeys = {
				One = Enum.KeyCode.One,
				Two = Enum.KeyCode.Two,
				Three = Enum.KeyCode.Three,
				Four = Enum.KeyCode.Four,
			},
		},
		UpdateBarTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),

		TargetController = {
			range = 15, -- The range of the lock on
			speed = 20, -- The speed of which the lock on camera is moving
			offset = Vector3.new(3, 4, -9), -- The camera offset when using lock on
			lockOnPlayers = true, -- Lock on player in the world
			requiresLineOfSight = true, -- If the characer needs line of sight with target to use lock on.
		},
	},
}
return Config
