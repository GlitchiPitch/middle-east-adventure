---@class ServerAddItemToInventory
---@field inventoryRepository ServerInventoryRepository
---@field playerService ServerPlayerService
---@field constants Constants
local AddItemToInventory = {}
AddItemToInventory.__index = AddItemToInventory

---@param inventoryRepository ServerInventoryRepository
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerAddItemToInventory
function AddItemToInventory.new(inventoryRepository, playerService, constants)
	local self = setmetatable({}, AddItemToInventory)
	self.inventoryRepository = inventoryRepository
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
---@param itemName string
---@param itemData table
function AddItemToInventory:execute(player, itemName, itemData)
	self.inventoryRepository:addItem(player, itemName, itemData)
	self.playerService:updatePlayerData(player)
end

return AddItemToInventory