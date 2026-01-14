local BasePresenter = require(script.Parent.BasePresenter)

---@class StatsPresenter : BasePresenter
---@field statsUI StatsUI
local StatsPresenter = setmetatable({}, { __index = BasePresenter })
StatsPresenter.__index = StatsPresenter

---@param applicationFacade IApplicationFacade
---@param statsUI StatsUI
---@return StatsPresenter
function StatsPresenter.new(applicationFacade, statsUI)
	local self = setmetatable(BasePresenter.new(applicationFacade), StatsPresenter)
	self.statsUI = statsUI
	return self
end

function StatsPresenter:init()
	BasePresenter.init(self)

	-- Подписываемся на изменения данных статов
	self:subscribeToPlayerData("Stats", function(data)
		self:updateStatsDisplay()
	end)
end

--- Обновление отображения статов
function StatsPresenter:updateStatsDisplay()
	if self.isDestroyed then
		return
	end

	self.statsUI:updateUI()
end

return StatsPresenter
