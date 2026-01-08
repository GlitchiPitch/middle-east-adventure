local UserInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")

repeat
	task.wait()
until game:GetService("Players").LocalPlayer.Character ~= nil

local function onInputChanged(inputObject)
	if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = Vector2.new(inputObject.Delta.x / Sensitivity, inputObject.Delta.y / Sensitivity) * Smoothness

		local X = TargetAngleX - delta.y
		TargetAngleX = (X >= 80 and 80) or (X <= -80 and -80) or X
		TargetAngleY = (TargetAngleY - delta.x) % 360
	end
end

local function getTargetsInRange()
	local targets = {}

	for _, part in pairs(workspace:GetPartBoundsInRadius(character.HumanoidRootPart.Position, lockOnInfo.Range)) do
		if part:IsA("BasePart") and part.Parent:FindFirstChild("Humanoid") then
			if game.Players:GetPlayerFromCharacter(part.Parent) then
				if lockOnInfo.LockOnPlayers == true then
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

local function getTargetsClosestCrosshair()
	local targets = getTargetsInRange()

	local nearest = 1
	target = nil

	for _, char in targets do
		if char and char ~= character then
			local distance = (char.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude

			local cameraToTarget = (char.HumanoidRootPart.Position - cam.CFrame.Position).Unit
			local cameraLook = cam.CFrame.LookVector

			local dotProduct = cameraToTarget:Dot(cameraLook)
			local difference = math.abs(1 - dotProduct)

			if distance < lockOnInfo.Range and dotProduct > 0.5 then
				if difference < nearest then
					nearest = difference
					target = char
				end
			end
		end
	end

	local rightTarget = nil
	local leftTarget = nil

	local nearestRight = lockOnInfo.SwitchRange
	local nearestLeft = -lockOnInfo.SwitchRange

	for _, char in targets do
		if char and target and char ~= target then
			local distance = character.HumanoidRootPart.CFrame:ToObjectSpace(char.HumanoidRootPart.CFrame)
			if distance.Z < 0 then
				if distance.X > 0 then
					if nearestRight then
						if distance.X < nearestRight then
							nearestRight = distance.X
							rightTarget = char
						end
					else
						nearestRight = distance.X
						rightTarget = char
					end
				elseif distance.X < 0 then
					if nearestLeft then
						if distance.X > nearestLeft then
							nearestLeft = distance.X
							leftTarget = char
						end
					else
						nearestLeft = distance.X
						leftTarget = char
					end
				end
			end
		end
	end

	return target, rightTarget, leftTarget
end

local function isTargetInView()
	local excludedCharacters = getTargetsInRange()
	table.remove(excludedCharacters, table.find(excludedCharacters, target))

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = excludedCharacters

	local origin = character.HumanoidRootPart.Position
	local direction = (target.HumanoidRootPart.Position - origin).Unit

	local ray = workspace:Raycast(origin, direction * lockOnInfo.Range, rayParams)

	if ray then
		if ray.Instance.Parent == target then
			return true
		end
	end

	return false
end

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
	self.player = players.LocalPlayer
	self.m = self.player:GetMouse()

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

	return self
end

function CameraService:init()
	---@param deltaTime number
	local function onRender(deltaTime)
		self:_onRender(deltaTime)
	end
	self.m.Icon = "http://www.roblox.com/asset/?id=569021388" -- replaces mouse icon

	self.character = self.player.Character or self.player.CharacterAdded:wait()
	self.head = self.character:WaitForChild("Head")
	self.camPos, self.targetCamPos = self.cam.CFrame.Position, self.cam.CFrame.Position

	runService.RenderStepped:Connect(onRender)
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
			local dist = TargetAngleY - AngleY
			dist = math.abs(dist) > 180 and dist - (dist / math.abs(dist)) * 360 or dist
			AngleY = (AngleY + dist * 0.35) % 360
			cam.CameraType = Enum.CameraType.Scriptable

			cam.CoordinateFrame = CFrame.new(head.Position)
				* CFrame.Angles(0, math.rad(AngleY), 0)
				* CFrame.Angles(math.rad(AngleX), 0, 0)
				* HeadOffset -- offset
		else
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		end

		if (cam.Focus.Position - cam.CFrame.Position).Magnitude < 1 then
			running = false
		else
			running = true
			if freemouse == true then
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			else
				UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
			end
		end

		if not CanToggleMouse.allowed then
			freemouse = false
		end

		cam.FieldOfView = FieldOfView

		checkedTarget = getTargetsClosestCrosshair()

		if checkedTarget then
			if currentCheckedTarget and currentCheckedTarget ~= checkedTarget then
				local humanoid = currentCheckedTarget:FindFirstChildOfClass("Humanoid") :: Humanoid
				if humanoid then
					humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				end
			end

			local distance = (checkedTarget.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
			if distance < 15 then
				local humanoid = checkedTarget:FindFirstChildOfClass("Humanoid") :: Humanoid
				if humanoid then
					humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
					currentCheckedTarget = checkedTarget
				end
			end
		end
	else
		target = getTargetsClosestCrosshair()

		dt = (lastDelta + dt) / 2 -- Smooth the delta to prevent fps drops
		lastDelta = dt

		if not target then
			return
		end

		local distance = (target.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude

		local requiresLineOfSight = lockOnInfo.RequiresLineOfSight
		local hasLineOfSight = isTargetInView()
		local lineOfSight = (hasLineOfSight and requiresLineOfSight) or not requiresLineOfSight -- Check for line of sight if required

		if not lineOfSight then
			if not lastObstructed then
				lastObstructed = tick()
			elseif tick() - lastObstructed > 1 then
				lastObstructed = nil
				return
			end
		else
			lastObstructed = nil
		end

		if distance < lockOnInfo.Range and target.Humanoid.Health > 0 then
			local targetPosition = Vector3.new(
				target.HumanoidRootPart.Position.X,
				character.HumanoidRootPart.Position.Y,
				target.HumanoidRootPart.Position.Z
			)
			local newCFrame = CFrame.lookAt(
				character.HumanoidRootPart.Position,
				targetPosition,
				character.HumanoidRootPart.CFrame.UpVector
			)

			local offsetX = newCFrame.RightVector * lockOnInfo.Offset.X
			local offsetY = newCFrame.UpVector * lockOnInfo.Offset.Y
			local offsetZ = newCFrame.LookVector * lockOnInfo.Offset.Z

			local offset = offsetX + offsetY + offsetZ
			local cameraPosition = newCFrame.Position + offset

			local targetCFrame = CFrame.lookAt(cameraPosition, target.HumanoidRootPart.Position, newCFrame.UpVector)
			cam.CFrame = cam.CFrame:Lerp(targetCFrame, dt * lockOnInfo.Speed)
			if tick() - lastTime > lockOnInfo.SwitchDebounce then
				local mouseDeltaX = UserInputService:GetMouseDelta().X

				if mouseDeltaX > lockOnInfo.SwitchSens or mouseDeltaX < -lockOnInfo.SwitchSens then
					local _, rightTarget, leftTarget = getTargetsClosestCrosshair()

					if mouseDeltaX > lockOnInfo.SwitchSens and rightTarget and isTargetInView() then -- Determine the direction of the mouse and switching target accordingly
						target = rightTarget
					elseif mouseDeltaX < -lockOnInfo.SwitchSens and leftTarget and isTargetInView() then
						target = leftTarget
					end
				end

				lastTime = tick()
			end
		end
	end
end


return CameraService
