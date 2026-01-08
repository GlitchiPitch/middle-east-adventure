local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

---@class CameraService
local CameraService = {}
CameraService.__index = CameraService

---@return CameraService
function CameraService.new()
	local self = setmetatable({}, CameraService)
	self._freemouse = false
	self._targetCamera = false

	-- you can mess with these settings
	self.canToggleMouse = { allowed = true, activationkey = Enum.KeyCode.F } -- lets you move your mouse around in firstperson
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
	self.cameraMode = "Freecam"
	self.lockOnInfo = {
		range = 100, -- The range of the lock on
		speed = 20, -- The speed of which the lock on camera is moving
		offset = Vector3.new(3, 4, -9), -- The camera offset when using lock on
		lockOnPlayers = true, -- Lock on player in the world
		requiresLineOfSight = true, -- If the characer needs line of sight with target to use lock on.
		obstructionBreakTime = 0.5, -- The time without line of sight that takes to exit the lock on.
		switchDebounce = 0.3, -- The debounce or cooldown of switching targets
		switchSens = 5, -- How sensetive the switching should be
		switchRange = 50, -- How far away you can switch target
	}

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
	---@param deltaTime number
	local function onRender(deltaTime)
		self:_onRender(deltaTime)
	end
	self.mouse.Icon = "http://www.roblox.com/asset/?id=569021388" -- replaces mouse icon

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

	RunService.RenderStepped:Connect(onRender)
end

function CameraService:toggleTargetCamera()
	self._targetCamera = not self._targetCamera
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

	if not self._targetCamera then
		if self.running then
			self.camPos = self.camPos + (self.targetCamPos - self.camPos) * 0.20
			self.angleX = self.angleX + (self.targetAngleX - self.angleX) * 0.30
			local dist = self.targetAngleY - self.angleY
			dist = math.abs(dist) > 180 and dist - (dist / math.abs(dist)) * 360 or dist
			self.angleY = (self.angleY + dist * 0.35) % 360
			self.cam.CameraType = Enum.CameraType.Scriptable

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

		self.checkedTarget = self:_getTargetsClosestCrosshair()

		if self.checkedTarget then
			if self.currentCheckedTarget and self.currentCheckedTarget ~= self.checkedTarget then
				local humanoid = self.currentCheckedTarget:FindFirstChildOfClass("Humanoid") :: Humanoid
				if humanoid then
					humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				end
			end

			local distance = (self.checkedTarget.HumanoidRootPart.Position - self.character.HumanoidRootPart.Position).Magnitude
			if distance < 10 then
				local humanoid = self.checkedTarget:FindFirstChildOfClass("Humanoid") :: Humanoid
				if humanoid then
					humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
					self.currentCheckedTarget = self.checkedTarget
				end
			end
		end
	else
		self.target = self:_getTargetsClosestCrosshair()

		dt = (self.lastDelta + dt) / 2 -- Smooth the delta to prevent fps drops
		self.lastDelta = dt

		if not self.target then
			return
		end

		local distance = (self.target.HumanoidRootPart.Position - self.character.HumanoidRootPart.Position).Magnitude

		local requiresLineOfSight = self.lockOnInfo.requiresLineOfSight
		local hasLineOfSight = self:_isTargetInView()
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

		if distance < self.lockOnInfo.range and self.target.Humanoid.Health > 0 then
			local targetPosition = Vector3.new(
				self.target.HumanoidRootPart.Position.X,
				self.character.HumanoidRootPart.Position.Y,
				self.target.HumanoidRootPart.Position.Z
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

			local targetCFrame =
				CFrame.lookAt(cameraPosition, self.target.HumanoidRootPart.Position, newCFrame.UpVector)
			self.cam.CFrame = self.cam.CFrame:Lerp(targetCFrame, dt * self.lockOnInfo.speed)
			if tick() - self.lastTime > self.lockOnInfo.switchDebounce then
				local mouseDeltaX = UserInputService:GetMouseDelta().X

				if mouseDeltaX > self.lockOnInfo.switchSens or mouseDeltaX < -self.lockOnInfo.switchSens then
					local _, rightTarget, leftTarget = self:_getTargetsClosestCrosshair()

					if mouseDeltaX > self.lockOnInfo.switchSens and rightTarget and self:_isTargetInView() then -- Determine the direction of the mouse and switching target accordingly
						self.target = rightTarget
					elseif mouseDeltaX < -self.lockOnInfo.switchSens and leftTarget and self:_isTargetInView() then
						self.target = leftTarget
					end
				end

				self.lastTime = tick()
			end
		end
	end

	self:_followCharacterToCursor()
end

function CameraService:_getTargetsInRange()
	local targets = {}

	for _, part in
		pairs(workspace:GetPartBoundsInRadius(self.character.HumanoidRootPart.Position, self.lockOnInfo.range))
	do
		if part:IsA("BasePart") and part.Parent:FindFirstChild("Humanoid") then
			if game.Players:GetPlayerFromCharacter(part.Parent) then
				if self.lockOnInfo.lockOnPlayers == true then
					if not table.find(targets, part.Parent) then
						table.insert(targets, part.Parent)
					end
				end
			else
				if not table.find(targets, part.Parent) then
					table.insert(targets, part.Parent)
				end
			end
		end
	end

	return targets
end

function CameraService:_getTargetsClosestCrosshair()
	local targets = self:_getTargetsInRange()

	local nearest = 1
	self.target = nil

	for _, char in targets do
		if char and char ~= self.character then
			local distance = (char.HumanoidRootPart.Position - self.character.HumanoidRootPart.Position).Magnitude

			local cameraToTarget = (char.HumanoidRootPart.Position - self.cam.CFrame.Position).Unit
			local cameraLook = self.cam.CFrame.LookVector

			local dotProduct = cameraToTarget:Dot(cameraLook)
			local difference = math.abs(1 - dotProduct)

			if distance < self.lockOnInfo.range and dotProduct > 0.5 then
				if difference < nearest then
					nearest = difference
					self.target = char
				end
			end
		end
	end

	return self.target
end

function CameraService:_isTargetInView()
	local excludedCharacters = self:_getTargetsInRange()
	table.remove(excludedCharacters, table.find(excludedCharacters, self.target))

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = excludedCharacters

	local origin = self.character.HumanoidRootPart.Position
	local direction = (self.target.HumanoidRootPart.Position - origin).Unit

	local ray = workspace:Raycast(origin, direction * self.lockOnInfo.range, rayParams)

	if ray then
		if ray.Instance.Parent == self.target then
			return true
		end
	end

	return false
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
	-- if TurnCharacterToMouse == true then
	-- 	Hum.AutoRotate = false
	-- 	Core.CFrame = Core.CFrame:lerp(
	-- 		CFrame.new(Core.Position, Vector3.new(Mouse.Hit.Position.X, Core.Position.Y, Mouse.Hit.Position.Z)),
	-- 		UpdateSpeed / 2
	-- 	)
	-- else
	-- 	Hum.AutoRotate = true
	-- end
end

return CameraService
