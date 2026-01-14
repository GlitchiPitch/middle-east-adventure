---@class ServerInventoryService
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
---@field equipmentRepository ServerEquipmentRepository
---@field inventoryRepository ServerInventoryRepository
---@field sharedData SharedData
---@field useCases ServerUseCases
local InventoryService = {}
InventoryService.__index = InventoryService

---@param diContainer DIContainer
---@return ServerInventoryService
function InventoryService.new(diContainer)
	local self = setmetatable({}, InventoryService)
	self.diContainer = diContainer
	return self
end

function InventoryService:init()
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")

	self.sharedData = shared.data
	self.playerRepository = infrastructure.playerRepository
	self.equipmentRepository = infrastructure.equipmentRepository
	self.inventoryRepository = infrastructure.inventoryRepository
	self.useCases = application.useCases
end

---@param player Player
---@param itemData table
function InventoryService:clickItem(player, itemData)
	self.useCases.clickInventoryItem:execute(player, itemData)
end

---@param player Player
---@param itemName string
function InventoryService:addItem(player, itemName)
	self.useCases.addItemToInventory:execute(player, itemName, {amount = 1})
end

return InventoryService
