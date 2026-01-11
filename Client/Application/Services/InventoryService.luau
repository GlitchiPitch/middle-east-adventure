local StarterGui = game:GetService("StarterGui")
---@class ClientInventoryService
---@field diContainer DIContainer
---@field eventBus EventBus
---@field isActive boolean
---@field cameraController CameraController
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
	self.cameraController = application.controllers.cameraController

	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
end

function InventoryService:clickItem(itemData)
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	local command = shared.application.commands.ClickItemCommand.new(itemData.name)
	shared.application.useCases.clickItemUseCase:execute(command)
end

function InventoryService:updateInventory()
end

function InventoryService:getInventory()
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	local playerEntity = application.services.playerService:getPlayerEntity()
	return playerEntity.inventory
end

function InventoryService:toggleInventoryView()
	self.isActive = not self.isActive
	if self.isActive then
		self.cameraController:activateInventoryCamera()
	else
		self.cameraController:activateDefaultCamera()
	end
	self.eventBus:fire("toggleInventoryView", { isActive = self.isActive })
end

return InventoryService
