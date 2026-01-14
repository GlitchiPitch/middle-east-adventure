---@class ServerLootService
---@field diContainer DIContainer
---@field sharedData SharedData
---@field inventoryRepository ServerInventoryRepository
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
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.sharedData = shared.data
	self.inventoryRepository = infrastructure.inventoryRepository
end

---@param player Player
---@param command PickupLootCommand
function LootService:pickupLoot(player, command)
	local itemData = self.sharedData:getItemData(command.loot.Name)
	command.loot:Destroy()
	self.inventoryRepository:addItem(player, itemData.name, {amount = 1})
end

return LootService
