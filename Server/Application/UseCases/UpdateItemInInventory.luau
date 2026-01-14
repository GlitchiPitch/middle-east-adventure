---@class ServerUpdateItemInInventory
---@field inventoryRepository ServerInventoryRepository
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local UpdateItemInInventory = {}
UpdateItemInInventory.__index = UpdateItemInInventory

---@param diContainer DIContainer
---@return ServerUpdateItemInInventory
function UpdateItemInInventory.new(diContainer)
	local self = setmetatable({}, UpdateItemInInventory)
	self.diContainer = diContainer
	return self
end

function UpdateItemInInventory:init()
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
---@param newData table
function UpdateItemInInventory:execute(player, itemName, newData)
	local playerEntity = self.playerService:getPlayerEntity(player)
	self.inventoryRepository:updateItem(playerEntity, itemName, newData)
	self.playerService:updatePlayerData(player)
end

return UpdateItemInInventory
