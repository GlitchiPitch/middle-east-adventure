---@class ServerAddItemToInventory
---@field inventoryRepository ServerInventoryRepository
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local AddItemToInventory = {}
AddItemToInventory.__index = AddItemToInventory

---@param diContainer DIContainer
---@return ServerAddItemToInventory
function AddItemToInventory.new(diContainer)
	local self = setmetatable({}, AddItemToInventory)
	self.diContainer = diContainer

	return self
end

function AddItemToInventory:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")

	self.inventoryRepository = infrastructure.inventoryRepository
	self.remoteEventService = shared.remoteEventService
	self.playerService = application.services.playerService
	self.constants = shared.constants
end

---@param player Player
---@param itemName string
---@param itemData table
function AddItemToInventory:execute(player, itemName, itemData)
	local playerEntity = self.playerService:getPlayerEntity(player)
	self.inventoryRepository:addItem(playerEntity, itemName, itemData)
	self.playerService:updatePlayerData(player)
end

return AddItemToInventory
