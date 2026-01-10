local TweenService = game:GetService("TweenService")
---@class StatsUI
---@field healthBar Frame
---@field manaBar Frame
---@field staminaBar Frame
---@field diContainer DIContainer
local StatsUI = {}
StatsUI.__index = StatsUI

---@param diContainer DIContainer
---@return StatsUI
function StatsUI.new(diContainer)
	local self = setmetatable({}, StatsUI)
	self.diContainer = diContainer
	return self
end

function StatsUI:init()
	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")
	local primary = presentation.ui.uiManager.primary
	self.healthBar = primary.Stats.Health
	self.manaBar = primary.Stats.Mana
	self.staminaBar = primary.Stats.Stamina
end

function StatsUI:updateUI()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	local playerEntity = application.services.playerService:getPlayerEntity()
	for i, v in
		{
			stamina = self.staminaBar,
			health = self.healthBar,
			mana = self.manaBar,
		}
	do
		local tween = TweenService:Create(v.Bar, shared.config.Client.UpdateBarTweenInfo, {
			Size = UDim2.fromScale(math.min(1, playerEntity.stats[i].current / playerEntity.stats[i].max), 1),
		})
		tween:Play()
	end
end

return StatsUI
