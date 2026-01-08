local PlayerService = require(script.PlayerService)
local InventoryService = require(script.InventoryService)
local ToolService = require(script.ToolService)
local AnimationService = require(script.AnimationService)
local CameraService = require(script.CameraService)
local InputService = require(script.InputService)
local SprintService = require(script.SprintService)

---@class ClientApplicationServices
---@field playerService ClientApplicationPlayerService
---@field inventoryService ClientApplicationInventoryService
---@field toolService ClientToolService
---@field animationService AnimationService
---@field camerService CameraService
---@field inputService InputService
---@field sprintService SprintService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ClientApplicationServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.playerService = PlayerService.new(diContainer)
	self.inventoryService = InventoryService.new(diContainer)
	self.toolService = ToolService.new(diContainer)
	self.animationService = AnimationService.new(diContainer)
	self.camerService = CameraService.new()
	self.inputService = InputService.new(diContainer)
	self.sprintService = SprintService.new(diContainer)
	return self
end

function Services:init()
	self.animationService:init()
	self.inputService:init()
end

return Services
