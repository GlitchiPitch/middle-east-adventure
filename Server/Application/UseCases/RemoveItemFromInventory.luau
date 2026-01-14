---@class ServerRemoveItemFromInventory
---@field inventoryRepository ServerInventoryRepository
---@field playerService ServerPlayerService
---@field constants Constants
local RemoveItemFromInventory = {}
RemoveItemFromInventory.__index = RemoveItemFromInventory

---@param inventoryRepository ServerInventoryRepository
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerRemoveItemFromInventory
function RemoveItemFromInventory.new(inventoryRepository, playerService, constants)
	local self = setmetatable({}, RemoveItemFromInventory)
	self.inventoryRepository = inventoryRepository
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
---@param itemName string
---@param amount number
function RemoveItemFromInventory:execute(player, itemName, amount)
	self.inventoryRepository:removeItem(player, itemName, amount)
	self.playerService:updatePlayerData(player)
end

return RemoveItemFromInventory