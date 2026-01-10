local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
---@class TargetService
---@field diContainer DIContainer
local TargetService = {}
TargetService.__index = TargetService

---@param diContainer DIContainer
---@return TargetService
function TargetService.new(diContainer)
	local self = setmetatable({}, TargetService)
	self.diContainer = diContainer
	self.checkedTarget = nil
	self.currentCheckedTarget = nil
	self.player = Players.LocalPlayer
	self.cam = game.Workspace.CurrentCamera
	
	return self
end

function TargetService:init()
	local function onRender(_)
		self:_onRender()
	end

	self.character = self.player.Character or self.player.CharacterAdded:wait()

	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants

    self.lockOnInfo = shared.config.Client.TargetService

	RunService.RenderStepped:Connect(onRender)
end

function TargetService:getCurrentTarget()
	return self.currentCheckedTarget
end

function TargetService:_onRender()
	self.checkedTarget = self:_getTargetsClosestCrosshair()
	if self.checkedTarget then
		if self.currentCheckedTarget and self.currentCheckedTarget ~= self.checkedTarget then
			self:_toogleTargetView(false)
			self.currentCheckedTarget = nil
		end

		self.currentCheckedTarget = self.checkedTarget
		self:_toogleTargetView(true)
	else
		if self.currentCheckedTarget then
			self:_toogleTargetView(false)
			self.currentCheckedTarget = nil
		end
	end
end

function TargetService:_toogleTargetView(state)
	if state then
		if
			self.currentCheckedTarget:HasTag(self.constants.PLAYER_STATES.INTERACT)
			or self.currentCheckedTarget:HasTag(self.constants.PLAYER_STATES.LOOT)
		then
			local ui = self.currentCheckedTarget:FindFirstChildOfClass("BillboardGui")
			if ui then
				ui.Enabled = true
			end
		elseif self.currentCheckedTarget:HasTag(self.constants.PLAYER_STATES.NPC) then
			local humanoid = self.currentCheckedTarget:FindFirstChildOfClass("Humanoid") :: Humanoid
			if humanoid then
				humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
			end
		end
	else
		if
			self.currentCheckedTarget:HasTag(self.constants.PLAYER_STATES.INTERACT)
			or self.currentCheckedTarget:HasTag(self.constants.PLAYER_STATES.LOOT)
		then
			local ui = self.currentCheckedTarget:FindFirstChildOfClass("BillboardGui")
			if ui then
				ui.Enabled = false
			end
		elseif self.currentCheckedTarget:HasTag(self.constants.PLAYER_STATES.NPC) then
			local humanoid = self.currentCheckedTarget:FindFirstChildOfClass("Humanoid") :: Humanoid
			if humanoid then
				humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			end
		end
	end
end

function TargetService:_getTargetsInRange()
	local targets = {}

	for _, part in
		pairs(workspace:GetPartBoundsInRadius(self.character.HumanoidRootPart.Position, self.lockOnInfo.range))
	do
		if part:IsA("BasePart") then
			if game.Players:GetPlayerFromCharacter(part.Parent) then
				if self.lockOnInfo.lockOnPlayers == true then
					if not table.find(targets, part.Parent) then
						table.insert(targets, part.Parent)
					end
				end
			elseif
				part.Parent:HasTag(self.constants.PLAYER_STATES.NPC)
				or part.Parent:HasTag(self.constants.PLAYER_STATES.LOOT)
			then
				if not table.find(targets, part.Parent) then
					table.insert(targets, part.Parent)
				end
			end
		end
	end

	return targets
end

function TargetService:_getTargetsClosestCrosshair()
	local targets = self:_getTargetsInRange()

	local nearest = 1
	self.target = nil

	for _, char in targets do
		if char and char ~= self.character then
			local distance = (char.PrimaryPart.Position - self.character.HumanoidRootPart.Position).Magnitude

			local cameraToTarget = (char.PrimaryPart.Position - self.cam.CFrame.Position).Unit
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

function TargetService:_isTargetInView()
	local excludedCharacters = self:_getTargetsInRange()
	table.remove(excludedCharacters, table.find(excludedCharacters, self.target))

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = excludedCharacters

	local origin = self.character.HumanoidRootPart.Position
	local direction = (self.target.PrimaryPart.Position - origin).Unit

	local ray = workspace:Raycast(origin, direction * self.lockOnInfo.range, rayParams)

	if ray then
		if ray.Instance.Parent == self.target then
			return true
		end
	end

	return false
end

return TargetService
