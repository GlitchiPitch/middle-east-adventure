local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

---@class CameraService
---@field diContainer DIContainer
---@field constants Constants
---@field playerService ClientApplicationPlayerService
---@field _cameraState '"Default"' | '"Target"' | '"Alchemy"'
local CameraService = {}
CameraService.__index = CameraService

---@param diContainer DIContainer
---@return CameraService
function CameraService.new(diContainer)
	local self = setmetatable({}, CameraService)
	self.diContainer = diContainer
	self._freemouse = false
	self._cameraState = ""

	-- you can mess with these settings
	self.sensitivity = 0.6 -- anything higher would make looking up and down harder; recommend anything between 0~1
	self.smoothness = 0.05 -- recommend anything between 0~1
	self.fieldOfView = 80 -- fov
	self.headOffset = CFrame.new(-1, 0.7, 10) -- how far your camera is from your head

	self.cam = game.Workspace.CurrentCamera
	self.player = Players.LocalPlayer
	self.mouse = self.player:GetMouse()

	self.angleX, self.targetAngleX = 0, 0
	self.angleY, self.targetAngleY = 0, 0

	self.running = true
	self.target = nil

	self.lastDelta = 0
	self.lastObstructed = nil
	self.lastTime = 0
	self.checkedTarget = nil
	self.currentCheckedTarget = nil

	self.charAngle = CFrame.Angles --[Storing these as variables so I dont have to type them out.]
	self.aSin = math.asin
	self.aTan = math.atan

	self.headHorFactor = 1
	self.headVertFactor = 0.6
	self.bodyHorFactor = 0.5
	self.bodyVertFactor = 0.4

	self.updateSpeed = 0.5

	return self
end

function CameraService:init()
	self.cam.CameraType = Enum.CameraType.Scriptable
	UserInputService.MouseBehavior = Enum.MouseBehavior.Default

	self.character = self.player.Character or self.player.CharacterAdded:wait()
	self.head = self.character:WaitForChild("Head")
	self.camPos, self.targetCamPos = self.cam.CFrame.Position, self.cam.CFrame.Position

	--[Setup]:
	self.humanoid = self.character:WaitForChild("Humanoid")
	self.humanoidRootPart = self.character:WaitForChild("HumanoidRootPart")
	self.torso = self.character:WaitForChild("UpperTorso")
	self.neck = self.head:WaitForChild("Neck") --[Once we know the Rig, we know what to find.]
	self.waist = self.torso:WaitForChild("Waist")

	self.neckOrgnC0 = self.neck.C0 --[Get the base C0 to manipulate off of.]
	self.waistOrgnC0 = self.waist.C0 --[Get the base C0 to manipulate off of.]

	self.neck.MaxVelocity = 1 / 3

	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants

	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	self.playerService = application.services.playerService
	self.targetService = application.services.targetService

	self.lockOnInfo = shared.config.Client.TargetService

	self:activateStartingCamera()
end

function CameraService:activateStartingCamera()
	self.cam.CFrame =
		CFrame.new(self.humanoidRootPart.Position - Vector3.new(0, -5, -10), self.humanoidRootPart.Position)
end

function CameraService:activateDefaultCamera()
	---@param deltaTime number
	local function onRender(deltaTime)
		self:_onRender(deltaTime)
	end

	self.mouse.Icon = "http://www.roblox.com/asset/?id=569021388" -- replaces mouse icon

	self._cameraState = self.constants.CAMERA_STATES.DEFAULT

	RunService.RenderStepped:Connect(onRender)
end

function CameraService:activateAlchemyCamera(alchemyPotCameraCFrame)
	self.cam.CFrame = alchemyPotCameraCFrame
	self._cameraState = self.constants.CAMERA_STATES.ALCHEMY
end

function CameraService:toggleTargetCamera()
	local currentTarget = self.targetService:getCurrentTarget()
	if currentTarget then
		if self._cameraState == self.constants.CAMERA_STATES.TARGET then
			self._cameraState = self.constants.CAMERA_STATES.DEFAULT
		else
			self._cameraState = self.constants.CAMERA_STATES.TARGET
		end
	else
		self._cameraState = self.constants.CAMERA_STATES.DEFAULT
	end
end

function CameraService:toggleFreeMouse()
	self.freemouse = not self.freemouse
end

---@param input InputObject
function CameraService:mouseMovement(input)
	local delta = Vector2.new(input.Delta.x / self.sensitivity, input.Delta.y / self.sensitivity) * self.smoothness

	local X = self.targetAngleX - delta.y
	self.targetAngleX = (X >= 80 and 80) or (X <= -80 and -80) or X
	self.targetAngleY = (self.targetAngleY - delta.x) % 360
end

function CameraService:_onRender(dt)
	if not self.character then
		return
	end

	if self._cameraState == self.constants.CAMERA_STATES.DEFAULT then
		self:_defaultCamera()
	elseif self._cameraState == self.constants.CAMERA_STATES.TARGET then
		self:_targetCamera(dt)
	end

	self:_followCharacterToCursor()
end

function CameraService:_followCharacterToCursor()
	local CamCF = self.cam.CFrame
	local TrsoLV = self.torso.CFrame.lookVector
	local HdPos = self.head.CFrame.Position

	local Dist = (self.head.CFrame.Position - CamCF.Position).Magnitude
	local Diff = self.head.CFrame.Y - CamCF.Y
	self.neck.C0 = self.neck.C0:lerp(
		self.neckOrgnC0
			* self.charAngle(
				(self.aSin(Diff / Dist) * self.headVertFactor),
				-(((HdPos - CamCF.Position).Unit):Cross(TrsoLV)).Y * self.headHorFactor,
				0
			),
		self.updateSpeed / 2
	)
	self.waist.C0 = self.waist.C0:lerp(
		self.waistOrgnC0
			* self.charAngle(
				(self.aSin(Diff / Dist) * self.bodyVertFactor),
				-(((HdPos - CamCF.Position).Unit):Cross(TrsoLV)).Y * self.bodyHorFactor,
				0
			),
		self.updateSpeed / 2
	)
end

function CameraService:_targetCamera(dt)
	self.target = self.targetService:getCurrentTarget()

	dt = (self.lastDelta + dt) / 2 -- Smooth the delta to prevent fps drops
	self.lastDelta = dt

	if not self.target then
		return
	end

	local distance = (self.target.PrimaryPart.Position - self.character.HumanoidRootPart.Position).Magnitude

	local requiresLineOfSight = self.lockOnInfo.requiresLineOfSight
	local hasLineOfSight = self.targetService:_isTargetInView()
	local lineOfSight = (hasLineOfSight and requiresLineOfSight) or not requiresLineOfSight -- Check for line of sight if required

	if not lineOfSight then
		if not self.lastObstructed then
			self.lastObstructed = tick()
		elseif tick() - self.lastObstructed > 1 then
			self.lastObstructed = nil
			return
		end
	else
		self.lastObstructed = nil
	end

	if distance < self.lockOnInfo.range then -- and self.target.Humanoid.Health > 0
		local targetPosition = Vector3.new(
			self.target.PrimaryPart.Position.X,
			self.character.HumanoidRootPart.Position.Y,
			self.target.PrimaryPart.Position.Z
		)
		local newCFrame = CFrame.lookAt(
			self.character.HumanoidRootPart.Position,
			targetPosition,
			self.character.HumanoidRootPart.CFrame.UpVector
		)

		local offsetX = newCFrame.RightVector * self.lockOnInfo.offset.X
		local offsetY = newCFrame.UpVector * self.lockOnInfo.offset.Y
		local offsetZ = newCFrame.LookVector * self.lockOnInfo.offset.Z

		local offset = offsetX + offsetY + offsetZ
		local cameraPosition = newCFrame.Position + offset

		local targetCFrame = CFrame.lookAt(cameraPosition, self.target.PrimaryPart.Position, newCFrame.UpVector)
		self.cam.CFrame = self.cam.CFrame:Lerp(targetCFrame, dt * self.lockOnInfo.speed)
	end
end

function CameraService:_defaultCamera()
	if self.running then
		self.camPos = self.camPos + (self.targetCamPos - self.camPos) * 0.2
		self.angleX = self.angleX + (self.targetAngleX - self.angleX) * 0.3
		local dist = self.targetAngleY - self.angleY
		dist = math.abs(dist) > 180 and dist - (dist / math.abs(dist)) * 360 or dist
		self.angleY = (self.angleY + dist * 0.3) % 360

		self.cam.CFrame = CFrame.new(self.head.Position)
			* CFrame.Angles(0, math.rad(self.angleY), 0)
			* CFrame.Angles(math.rad(self.angleX), 0, 0)
			* self.headOffset -- offset
	else
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	end

	if (self.cam.Focus.Position - self.cam.CFrame.Position).Magnitude < 1 then
		self.running = false
	else
		self.running = true
		if self._freemouse then
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		else
			UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		end
	end

	self.cam.FieldOfView = self.fieldOfView
end

return CameraService
