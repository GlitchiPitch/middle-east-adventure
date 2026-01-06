---@class Config
local Config = {
    PlayerDataStoreKey = "PlayerData",

    Client = {
        PopupLifeTime = 2,
        Control = {
            Action = Enum.KeyCode.MouseLeftButton,
        },
        UpdateBarTweenInfo = TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
    },
}
return Config
