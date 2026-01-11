local CameraController = require(script.CameraController)
local SprintController = require(script.SprintController)
local TargetController = require(script.TargetController)

---@class ClientControllers
---@field cameraController CameraController
---@field sprintController SprintController
---@field targetController TargetController
local Controllers = {}
Controllers.__index = Controllers

---@param diContainer DIContainer
---@return ClientControllers
function Controllers.new(diContainer)
	local self = setmetatable({}, Controllers)
	self.cameraController = CameraController.new(diContainer)
	self.sprintController = SprintController.new(diContainer)
	self.targetController = TargetController.new(diContainer)
	return self
end

function Controllers:init()
	self.targetController:init()
end

return Controllers
