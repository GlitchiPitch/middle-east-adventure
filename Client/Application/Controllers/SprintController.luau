local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
---@class SprintController
---@field diContainer DIContainer
local SprintController = {}
SprintController.__index = SprintController

---@param diContainer DIContainer
---@return SprintController
function SprintController.new(diContainer)
	local self = setmetatable({}, SprintController)
	self.player = Players.LocalPlayer
	self.diContainer = diContainer
	self.walkSpeed = 13
	self.runSpeed = 25 -- Speed while runninh
	self.walkFov = workspace.Camera.FieldOfView
	self.runFov = 80 -- Camera FieldOfView while running
	self.canRun = true -- If the player is able to run
	self.transitionSpeed = 0.5 -- Time it takes to go from walking to running

	return self
end

function SprintController:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	local function onRender()
		if self.humanoid.MoveDirection.Magnitude > 0 then
			self.walking = true
		else
			self.walking = false

			if self.running then
				self:walk()
			end
		end
	end

	self.character = self.player.Character
	self.humanoid = self.character:WaitForChild("Humanoid")
	self.animator = self.humanoid:WaitForChild("Animator")

	self.runAnimation = shared.assets.Animations.Run

	self.runTrack = self.animator:LoadAnimation(self.runAnimation)
	self.runTrack.Priority = Enum.AnimationPriority.Action

	RunService.RenderStepped:Connect(onRender)
end

function SprintController:run()
	if self.walking and self.canRun then
		self.running = true

		local runTween = TweenService:Create(
			self.humanoid,
			TweenInfo.new(self.transitionSpeed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{ WalkSpeed = self.runSpeed }
		)
		--local FovTween = tweenService:Create(camera, TweenInfo.new(RunConfig.TransitionSpeed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {FieldOfView = RunConfig.RunFov})
		runTween:Play()
		--FovTween:Play()
		self.runTrack:Play()
	end
end

function SprintController:walk()
	self.running = false

	local walkTween = TweenService:Create(
		self.humanoid,
		TweenInfo.new(self.transitionSpeed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
		{ WalkSpeed = self.walkSpeed }
	)
	--local fovTween = tweenService:Create(camera, TweenInfo.new(RunConfig.TransitionSpeed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {FieldOfView = RunConfig.WalkFov})
	walkTween:Play()
	--fovTween:Play()
	self.runTrack:Stop()
end

return SprintController
