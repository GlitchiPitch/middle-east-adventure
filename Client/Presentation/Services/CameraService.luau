local UserInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")

repeat
	task.wait()
until game:GetService("Players").LocalPlayer.Character ~= nil

-- you can mess with these settings
local CanToggleMouse = { allowed = true, activationkey = Enum.KeyCode.F } -- lets you move your mouse around in firstperson
local Sensitivity = 0.6 -- anything higher would make looking up and down harder; recommend anything between 0~1
local Smoothness = 0.05 -- recommend anything between 0~1
local FieldOfView = 80 -- fov
local HeadOffset = CFrame.new(-1, 0.7, 10) -- how far your camera is from your head

local cam = game.Workspace.CurrentCamera
local player = players.LocalPlayer
local m = player:GetMouse()
m.Icon = "http://www.roblox.com/asset/?id=569021388" -- replaces mouse icon
local character = player.Character or player.CharacterAdded:wait()

local head = character:WaitForChild("Head")
local CamPos, TargetCamPos = cam.CFrame.Position, cam.CFrame.Position
local AngleX, TargetAngleX = 0, 0
local AngleY, TargetAngleY = 0, 0

local running = true
local freemouse = false

local target
local cameraMode = "Freecam"

local function onInputChanged(inputObject)
	if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = Vector2.new(inputObject.Delta.x / Sensitivity, inputObject.Delta.y / Sensitivity) * Smoothness

		local X = TargetAngleX - delta.y
		TargetAngleX = (X >= 80 and 80) or (X <= -80 and -80) or X
		TargetAngleY = (TargetAngleY - delta.x) % 360
	end
end

local lockOnInfo = {
	Range = 100, -- The range of the lock on
	Speed = 20, -- The speed of which the lock on camera is moving
	Offset = Vector3.new(3, 4, -9), -- The camera offset when using lock on
	LockOnPlayers = true, -- Lock on player in the world
	RequiresLineOfSight = true, -- If the characer needs line of sight with target to use lock on.
	ObstructionBreakTime = 0.5, -- The time without line of sight that takes to exit the lock on.
	SwitchDebounce = 0.3, -- The debounce or cooldown of switching targets
	SwitchSens = 5, -- How sensetive the switching should be
	SwitchRange = 50, -- How far away you can switch target
}

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

local lastDelta = 0
local lastObstructed = nil
local lastTime = 0
local function onRender(dt)
	if cameraMode == "Freecam" then
		if running then
			CamPos = CamPos + (TargetCamPos - CamPos) * 0.20
			AngleX = AngleX + (TargetAngleX - AngleX) * 0.30
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

local function onInputBegan(inputObject)
	if inputObject.UserInputType == Enum.UserInputType.Keyboard then
		if inputObject.KeyCode == CanToggleMouse.activationkey then
			if CanToggleMouse.allowed and freemouse == false then
				freemouse = true
			else
				freemouse = false
			end
		elseif inputObject.KeyCode == Enum.KeyCode.E then
			if cameraMode == "Freecam" then
				cameraMode = "LockNearest"
			else
				cameraMode = "Freecam"
			end
		end
	end
end

UserInputService.InputChanged:Connect(onInputChanged)
UserInputService.InputBegan:Connect(onInputBegan)
runService.RenderStepped:Connect(onRender)
