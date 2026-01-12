---@class ClientInteractService
---@field diContainer DIContainer
---@field targetController TargetController
---@field alchemyService ClientAlchemyService
---@field smithService ClientSmithService
---@field lecternService LecternService
---@field lootService ClientLootService
---@field chestService ClientChestService
---@field playerService ClientPlayerService
---@field cameraController CameraController
local InteractService = {}
InteractService.__index = InteractService

---@param diContainer DIContainer
---@return ClientInteractService
function InteractService.new(diContainer)
	local self = setmetatable({}, InteractService)
	self.diContainer = diContainer
	return self
end

function InteractService:init()
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.targetController = application.controllers.targetController
	self.alchemyService = application.services.alchemyService
	self.smithService = application.services.smithService
	self.lecternService = application.services.lecternService
	self.lootService = application.services.lootService
	self.chestService = application.services.chestService
	self.playerService = application.services.playerService

	self.constants = shared.constants
end

function InteractService:activate()
	local currentTarget = self.targetController:getCurrentTarget()
	if currentTarget:HasTag(self.constants.PLAYER_STATES.INTERACT) then
		local interactType = currentTarget:GetAttribute(self.constants.ATTRIBUTES.INTERACT_TYPE)

		self.playerService:toggleRobloxControl(false)

		if currentTarget:FindFirstChild("PlayerPoint") then
			self.playerService:moveTo(currentTarget)
		end

		if interactType == self.constants.INTERACT_TYPES.ALCHEMY then
			self.alchemyService:start(currentTarget)
			self.playerService:setPlayerState(self.constants.PLAYER_STATES.ALCHEMY)
		elseif interactType == self.constants.INTERACT_TYPES.LECTERN then
			self.lecternService:start(currentTarget)
			self.playerService:setPlayerState(self.constants.PLAYER_STATES.LECTERN)
		elseif interactType == self.constants.INTERACT_TYPES.SMITH then
			self.smithService:start(currentTarget)
			self.playerService:setPlayerState(self.constants.PLAYER_STATES.SMITH)
		elseif interactType == self.constants.INTERACT_TYPES.CHEST then
			self.chestService:openChest(currentTarget)
			self.playerService:setPlayerState(self.constants.PLAYER_STATES.CHEST)
		elseif interactType == self.constants.INTERACT_TYPES.LOOT then
			self.lootService:pickupLoot(currentTarget)
			self.playerService:setPlayerState(self.constants.PLAYER_STATES.LOOT)
		end
	end
end

return InteractService
