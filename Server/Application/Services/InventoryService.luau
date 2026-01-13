---@class ServerInventoryService
---@field diContainer DIContainer
---@field playerService ServerPlayerService
---@field equipmentService ServerEquipmentService
---@field sharedData SharedData
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
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.sharedData = shared.data
	self.playerService = application.services.playerService
	self.equipmentService = application.services.equipmentService
end

---@param player Player
---@param itemData table
function InventoryService:clickItem(player, itemData)
	itemData.state = "set"
	
	self.equipmentService:setPlayerSlot(player, itemData)
end

---@param playerEntity PlayerEntity
---@param itemName string
function InventoryService:addItem(playerEntity, itemName)
	playerEntity.inventory:addItem({
		name = itemName,
		data = {
			amount = 1,
		},
	})
end

return InventoryService
