local PathfindingService = game:GetService("PathfindingService")
---@class ClientPlayerService
---@field diContainer DIContainer
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ClientPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable({}, PlayerService)
	self.diContainer = diContainer
	return self
end

function PlayerService:callUpdatePlayerData()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	local remoteEventService = shared.remoteEventService

	remoteEventService:fireServer({
		eventName = shared.constants.REMOTE_EVENTS.UPDATE_PLAYER_DATA,
		data = {},
	})
end

---@param newData table
function PlayerService:updatePlayerData(newData)
	---@type ClientInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type SharedDomain
	local domain = self.diContainer:resolve("Domain")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	newData.inventory = domain.Inventory.new(newData.inventory)
	newData.skills = domain.Skills.new(newData.skills)
	newData.stats = domain.Stats.new(newData.stats)
	newData.equipment = domain.Equipment.new(newData.equipment)
	newData.playerProgress = domain.PlayerProgress.new(newData.playerProgress)
	newData.attributes = domain.Attributes.new(newData.attributes)

	infrastructure.playerRepository:updatePlayerEntity(newData)
	shared.eventBus:fire("updatePlayerData")
end

---@return PlayerEntity
function PlayerService:getPlayerEntity()
	---@type ClientInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	local playerEntity = infrastructure.playerRepository:getPlayerEntity()
	return playerEntity
end

---@return playerStateEnum
function PlayerService:getPlayerState()
	local playerEntity = self:getPlayerEntity()
	return playerEntity.state
end

---@param state playerStateEnum
function PlayerService:setPlayerState(state)
	local playerEntity = self:getPlayerEntity()
	playerEntity.state = state
end

---@return EquipmentEntity
function PlayerService:getPlayerEquipment()
	local playerEntity = self:getPlayerEntity()
	return playerEntity.equipment
end

---@param state boolean
function PlayerService:toggleRobloxControl(state)
	local playerEntity = self:getPlayerEntity()
	playerEntity:toggleRobloxControl(state)
end

---@param interactModel Model
function PlayerService:moveTo(interactModel)
	local playerEntity = self:getPlayerEntity()
	local humanoid = playerEntity._instance.Character.Humanoid
	local humanoidRootPart = playerEntity._instance.Character.HumanoidRootPart
	local playerPoint = interactModel.PlayerPoint
	local path = PathfindingService:CreatePath()
	path:ComputeAsync(humanoidRootPart.Position, playerPoint.Position)
	local way = path:GetWaypoints()
	local currentPoint = 1
	local _moveConn
	local _blockPathConn

	---@param reached boolean
	local function onFinished(reached)
		if reached then
			currentPoint += 1
			if way[currentPoint] then
				humanoid:MoveTo(way[currentPoint].Position)
			else
				_moveConn:Disconnect()
				_blockPathConn:Disconnect()
				playerEntity._instance.Character:PivotTo(
					CFrame.new(humanoidRootPart.Position, interactModel.PrimaryPart.Position)
				)

			end
		else
			humanoid:MoveTo(way[currentPoint].Position)
		end
	end

	-- When the path is blocked...
	local function OnPathBlocked(blockedWaypointIdx)
		-- Check if the obstacle is further down the path
		if blockedWaypointIdx > currentPoint then
			-- Recompute the path
			path:ComputeAsync(humanoidRootPart.Position, playerPoint.Position)
			if path.Status == Enum.PathStatus.Success then
				humanoid:MoveTo(way[currentPoint].Position)
			else
				warn("path not found")
			end
		end
	end

	_blockPathConn = path.Blocked:Connect(OnPathBlocked)

	humanoid:MoveTo(way[currentPoint].Position)
	_moveConn = humanoid.MoveToFinished:Connect(onFinished)

end

return PlayerService
