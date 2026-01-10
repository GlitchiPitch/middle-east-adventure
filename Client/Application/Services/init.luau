local PlayerService = require(script.PlayerService)
local InventoryService = require(script.InventoryService)
local ToolService = require(script.ToolService)
local AnimationService = require(script.AnimationService)
local CameraService = require(script.CameraService)
local InputService = require(script.InputService)
local SprintService = require(script.SprintService)
local LootService = require(script.LootService)
local DialogService = require(script.DialogService)
local InteractService = require(script.InteractService)
local AlchemyService = require(script.AlchemyService)
local TargetService = require(script.TargetService)

---@class ClientApplicationServices
---@field playerService ClientApplicationPlayerService
---@field inventoryService ClientApplicationInventoryService
---@field toolService ClientToolService
---@field animationService AnimationService
---@field cameraService CameraService
---@field inputService InputService
---@field sprintService SprintService
---@field lootService ClientLootService
---@field dialogService DialogService
---@field interactService ClientInteractService
---@field alchemyService ClientAlchemyService
---@field targetService TargetService
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
	self.cameraService = CameraService.new(diContainer)
	self.inputService = InputService.new(diContainer)
	self.sprintService = SprintService.new(diContainer)
	self.lootService = LootService.new()
	self.dialogService = DialogService.new()
	self.interactService = InteractService.new()
	self.alchemyService = AlchemyService.new()
	self.targetService = TargetService.new(diContainer)
	return self
end

function Services:init()
	self.animationService:init()
	self.inputService:init()
	self.targetService:init()
end

return Services
