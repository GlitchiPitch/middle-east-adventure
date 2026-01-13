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
			InventoryKey = Enum.KeyCode.I,
			EquippmentKeys = {
				One = Enum.KeyCode.One.Name,
				Two = Enum.KeyCode.Two.Name,
				Three = Enum.KeyCode.Three.Name,
				Four = Enum.KeyCode.Four.Name,
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

	Player = {
		walkSpeed = 13,
		runSpeed = 25,
		runFov = 80,
		transitionSpeed = 0.5,
		restoreStaminaValue = 5,
		restoreWeakStaminaValue = 1,
		spendStaminaValue = 5,
	},
}
return Config
