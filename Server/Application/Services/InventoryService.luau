---@class ServerInventoryService
---@field diContainer DIContainer
---@field playerService ServerPlayerService
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
	self.playerService = application.services.playerService
end

---@param player Player
---@param itemData table
function InventoryService:clickItem(player, itemData)
	local playerEntity = self.playerService:getPlayerEntity(player)
	local item = playerEntity.inventory:getItem(itemData.name) -- entity
	if itemData.equipdable then
		playerEntity.equipment:equip(item)
	elseif itemData.usable then
		item:use()
	end
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
