---@class LecternService
---@field _lectern Model
---@field diContainer DIContainer
---@field constants Constants
---@field cameraController CameraController
---@field playerService ClientPlayerService
local LecternService = {}
LecternService.__index = LecternService

---@param diContainer DIContainer
---@return LecternService
function LecternService.new(diContainer)
	local self = setmetatable({}, LecternService)
	self.diContainer = diContainer
	self._lectern = nil
	return self
end

function LecternService:init()
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.constants = shared.constants
	self.cameraController = application.controllers.cameraController
	self.playerService = application.services.playerService
end

function LecternService:start(lectern)
	self._lectern = lectern
	task.wait(5)
	self:finish()
end

function LecternService:finish()
	self._lectern = nil
	self.playerService:toggleRobloxControl(true)
	self.cameraController:activateDefaultCamera()
	self.playerService:setPlayerState("")
end

return LecternService
