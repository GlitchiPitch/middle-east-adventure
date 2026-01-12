---@class ClientInventoryService
---@field diContainer DIContainer
---@field eventBus EventBus
---@field isActive boolean
---@field cameraController CameraController
---@field playerService ClientPlayerService
---@field useCases ClientUseCases
local InventoryService = {}
InventoryService.__index = InventoryService

---@param diContainer DIContainer
---@return ClientInventoryService
function InventoryService.new(diContainer)
	local self = setmetatable({}, InventoryService)
	self.diContainer = diContainer
	self.isActive = false
	return self
end

function InventoryService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")

	self.eventBus = shared.eventBus
	self.playerService = application.services.playerService
	self.cameraController = application.controllers.cameraController
	self.useCases = application.useCases
	self.commands = shared.application.commands
end

function InventoryService:clickItem(itemName)
	local command = self.commands.ClickInventoryItemCommand.new(itemName)
	self.useCases.clickInventoryItem:execute(command)
end

function InventoryService:getInventory()
	local playerEntity = self.playerService:getPlayerEntity()
	return playerEntity.inventory
end

function InventoryService:toggleInventoryView()
	self.isActive = not self.isActive
	if self.isActive then
		self.cameraController:activateInventoryCamera()
		self.playerService:toggleRobloxControl(false)
	else
		self.cameraController:activateDefaultCamera()
		self.playerService:toggleRobloxControl(true)
	end
	self.eventBus:fire("toggleInventoryView", { isActive = self.isActive })
end

return InventoryService
