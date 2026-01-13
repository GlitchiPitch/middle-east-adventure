local RunService = game:GetService("RunService")

local MobController = require(script.MobController)
local PlayerController = require(script.PlayerController)

---@class ServerControllers
---@field _renderConn RBXScriptConnection
---@field _updateTime number
---@field _deltaTime number
---@field mobController ServerMobController
---@field playerController ServerPlayerController
---@field diContainer DIContainer
local Controllers = {}
Controllers.__index = Controllers

---@param diContainer DIContainer
---@return ServerControllers
function Controllers.new(diContainer)
	local self = setmetatable({}, Controllers)
	self.mobController = MobController.new(diContainer)
	self.playerController = PlayerController.new(diContainer)
	self.diContainer = diContainer
	self._updateTime = .5
	self._deltaTime = 0
	
	return self
end

function Controllers:init()

	local function _onRender(deltaTime)
		self:_onRender(deltaTime)
	end

	self.mobController:init()
	self.playerController:init()

	self._renderConn = RunService.Heartbeat:Connect(_onRender)
end

function Controllers:_onRender(deltaTime)
	self._deltaTime += deltaTime
	if self._deltaTime >= self._updateTime then
		self.mobController:update(self._deltaTime)
		self.playerController:update(self._deltaTime)
		self._deltaTime = 0
	end
end

return Controllers
