local TweenService = game:GetService("TweenService")
---@class StatsUI
---@field healthBar Frame
---@field manaBar Frame
---@field staminaBar Frame
---@field diContainer DIContainer
local StatsUI = {}
StatsUI.__index = StatsUI

---@param diContainer DIContainer
---@param statsUI Frame
---@return StatsUI
function StatsUI.new(diContainer, statsUI)
    local self = setmetatable({}, StatsUI)
    self._instance = statsUI
    self.diContainer = diContainer
    self:_registerUI()
    return self
end

function StatsUI:_registerUI()
    self.healthBar = self._instance.HealthBar
    self.manaBar = self._instance.ManaBar
    self.staminaBar = self._instance.StaminaBar
end

---@param statsData statsData
function StatsUI:updateUI(statsData)
    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    ---@type ClientApplication
    local application = self.diContainer:resolve("Application")
    local playerEntity = 

    for i, v in {
        [statsData.stamina] = self.staminaBar,
        [statsData.health] = self.healthBar,
        [statsData.mana] = self.manaBar,
    } do
        local tween = TweenService:Create(
            v.Bar,
            shared.config.Client.UpdateBarTweenInfo,
            { Size = UDim2.fromScale(i / ) }
        )
    end
end

return StatsUI
