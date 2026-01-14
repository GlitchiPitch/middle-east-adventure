---@class ServerUpdateItemInInventory
---@field inventoryRepository ServerInventoryRepository
---@field playerService ServerPlayerService
---@field constants Constants
local UpdateItemInInventory = {}
UpdateItemInInventory.__index = UpdateItemInInventory

---@param inventoryRepository ServerInventoryRepository
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerUpdateItemInInventory
function UpdateItemInInventory.new(inventoryRepository, playerService, constants)
	local self = setmetatable({}, UpdateItemInInventory)
	self.inventoryRepository = inventoryRepository
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
---@param itemName string
---@param newData table
function UpdateItemInInventory:execute(player, itemName, newData)
	self.inventoryRepository:updateItem(player, itemName, newData)
	self.playerService:updatePlayerData(player)
end

return UpdateItemInInventory