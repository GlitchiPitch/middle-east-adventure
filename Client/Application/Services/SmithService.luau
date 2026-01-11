---@class ClientSmithService
---@field diContainer DIContainer
---@field eventBus EventBus
---@field cameraController CameraController
---@field playerService ClientApplicationPlayerService
---@field constants Constants
---@field isActive boolean
---@field _blacksmith Model
local SmithService = {}
SmithService.__index = SmithService

---@param diContainer DIContainer
---@return ClientSmithService
function SmithService.new(diContainer)
	local self = setmetatable({}, SmithService)
	self.diContainer = diContainer
	self.isActive = false
	self._blacksmith = nil
	return self
end

function SmithService:init()
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.constants = shared.constants
	self.eventBus = shared.eventBus
	self.cameraController = application.controllers.cameraController
	self.playerService = application.services.playerService
end

function SmithService:start(blacksmith)
	self.isActive = true
	self._blacksmith = blacksmith

	self.cameraController:activateAlchemyCamera(self._alchemyPot.CameraPart.CFrame)
	self.eventBus:fire("setSmithMode", { isActive = self.isActive })
	self.playerService:toggleRobloxControl(false)
	self.playerService:setPlayerState(self.constants.PLAYER_STATES.SMITH)
end

function SmithService:finish()
	self.isActive = false

	self.eventBus:fire("setSmithMode", { isActive = self.isActive })
	self.playerService:toggleRobloxControl(true)
	self.playerService:setPlayerState("")
end

return SmithService
