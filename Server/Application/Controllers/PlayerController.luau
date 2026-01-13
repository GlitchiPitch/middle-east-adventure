local TweenService = game:GetService("TweenService")
---@class ServerPlayerController
---@field _deltaTime number
---@field _updateTime number
---@field diContainer DIContainer
---@field config Config
---@field playerService ServerPlayerService
local PlayerController = {}
PlayerController.__index = PlayerController

---@param diContainer DIContainer
---@return ServerPlayerController
function PlayerController.new(diContainer)
	local self = setmetatable({}, PlayerController)
	self.diContainer = diContainer
	self._deltaTime = 0
	self._updateTime = 1
	return self
end

function PlayerController:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")
	self.config = shared.config
	self.playerService = application.services.playerService
end

function PlayerController:update(deltaTime)
	self._deltaTime += deltaTime
	if self._deltaTime >= self._updateTime then
		self._deltaTime = 0
		self:_checkPlayersState()
	end
end

function PlayerController:_checkPlayersState()
	local players = self.playerService:getPlayers()
	---@param i number
	---@param v PlayerEntity
	for _, v in players do
		if v._instance.Character then
			local humanoid = v._instance.Character.Humanoid
			if humanoid.WalkSpeed > self.config.Player.walkSpeed then
				v.stats.stamina.current = math.max(v.stats.stamina.current - self.config.Player.spendStaminaValue, 0)
				if v.stats.stamina.current <= 0 then
					self:_walk(v, humanoid)
				end
			else
				if v.stats.stamina.current < v.stats.stamina.max then
					local staminaRestore = if v.stats.weak
						then self.config.Player.restoreWeakStaminaValue
						else self.config.Player.restoreStaminaValue
					v.stats.stamina.current = math.min(v.stats.stamina.current + staminaRestore, v.stats.stamina.max)
				end
			end

			self.playerService:updatePlayerData(v._instance)
		end
	end
end

---@param player Player
---@param command ToggleSprintCommand
function PlayerController:toggleSprint(player, command)
	local playerEntity = self.playerService:getPlayerEntity(player)
	if playerEntity._instance.Character then
		local humanoid = playerEntity._instance.Character.Humanoid

		if playerEntity.stats.stamina.current > 0 then
			playerEntity.isRunning = command.isRunning
			if playerEntity.isRunning then
				self:_run(playerEntity, humanoid)
			else
				self:_walk(playerEntity, humanoid)
			end
		else
			self:_walk(playerEntity, humanoid)
		end
	end
end

function PlayerController:_walk(playerEntity, humanoid)
	local walkTween = TweenService:Create(
		humanoid,
		TweenInfo.new(self.config.Player.transitionSpeed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
		{ WalkSpeed = self.config.Player.walkSpeed }
	)
	walkTween:Play()
	playerEntity.isRunning = false
end

function PlayerController:_run(playerEntity, humanoid)
	local runTween = TweenService:Create(
		humanoid,
		TweenInfo.new(self.config.Player.transitionSpeed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
		{ WalkSpeed = self.config.Player.runSpeed }
	)
	runTween:Play()
	playerEntity.isRunning = true
end

return PlayerController
