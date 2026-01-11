---@class ClientAlchemyService
---@field _alchemyPot Model
---@field diContainer DIContainer
---@field eventBus EventBus
---@field cameraController CameraController
---@field playerService ClientPlayerService
---@field constants Constants
---@field isActive boolean
local AlchemyService = {}
AlchemyService.__index = AlchemyService

---@param diContainer DIContainer
---@return ClientAlchemyService
function AlchemyService.new(diContainer)
	local self = setmetatable({}, AlchemyService)
	self.diContainer = diContainer
	self._alchemyPot = nil
	self.isActive = false
	return self
end

function AlchemyService:init()
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.constants = shared.constants
	self.eventBus = shared.eventBus
	self.cameraController = application.controllers.cameraController
	self.playerService = application.services.playerService
end

---@param alchemyPot Model
function AlchemyService:start(alchemyPot)
	self.isActive = true
	self._alchemyPot = alchemyPot
	self.cameraController:activateAlchemyCamera(self._alchemyPot.CameraPart.CFrame)
	self.eventBus:fire("setAlchemyMode", { isActive = self.isActive })
end

function AlchemyService:finish()
	self.isActive = false
	self._alchemyPot = nil
	self.eventBus:fire("setAlchemyMode", { isActive = self.isActive })
	self.playerService:toggleRobloxControl(true)
	self.cameraController:activateDefaultCamera()
	self.playerService:setPlayerState("")
end

return AlchemyService
