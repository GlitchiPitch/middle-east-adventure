---@class ClientInteractService
---@field diContainer DIContainer
---@field targetController TargetController
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
	self.constants = shared.constants
end

function InteractService:activate()
	local currentTarget = self.targetController:getCurrentTarget()
	if currentTarget:HasTag(self.constants.PLAYER_STATES.INTERACT) then
		local interactType = currentTarget:GetAttribute(self.constants.ATTRIBUTES.INTERACT_TYPE)
		if interactType == self.constants.INTERACT_TYPES.ALCHEMY then
			self.alchemyService:start(currentTarget)
		end
	end
end

return InteractService
