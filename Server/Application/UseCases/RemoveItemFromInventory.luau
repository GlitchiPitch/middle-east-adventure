---@class ServerRemoveItemFromInventory
---@field inventoryRepository ServerInventoryRepository
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local RemoveItemFromInventory = {}
RemoveItemFromInventory.__index = RemoveItemFromInventory

---@param diContainer DIContainer
---@return ServerRemoveItemFromInventory
function RemoveItemFromInventory.new(diContainer)
	local self = setmetatable({}, RemoveItemFromInventory)
	self.diContainer = diContainer
	return self
end

function RemoveItemFromInventory:init()
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
---@param amount number
function RemoveItemFromInventory:execute(player, itemName, amount)
	local playerEntity = self.playerService:getPlayerEntity(player)
	self.inventoryRepository:removeItem(playerEntity, itemName, amount)
	self.playerService:updatePlayerData(player)
end

return RemoveItemFromInventory
