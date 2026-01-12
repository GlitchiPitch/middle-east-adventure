---@class ServerLootService
---@field diContainer DIContainer
---@field sharedData SharedData
---@field inventoryService ServerInventoryService
local LootService = {}
LootService.__index = LootService

---@param diContainer DIContainer
---@return ServerLootService
function LootService.new(diContainer)
	local self = setmetatable({}, LootService)
	self.diContainer = diContainer
	return self
end

function LootService:init()
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.sharedData = shared.data
	self.playerService = application.services.playerService
	self.inventoryService = application.services.inventoryService
end

---@param player Player
---@param command PickupLootCommand
function LootService:pickupLoot(player, command)
	local playerEntity = self.playerService:getPlayerEntity(player)
	local itemData = self.sharedData:getItemData(command.loot.Name)
	command.loot:Destroy()
	self.inventoryService:addItem(playerEntity, itemData.name)
end

return LootService
