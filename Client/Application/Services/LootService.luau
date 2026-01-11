---@class ClientLootService
---@field diContainer DIContainer
local LootService = {}
LootService.__index = LootService

---@param diContainer DIContainer
---@return ClientLootService
function LootService.new(diContainer)
	local self = setmetatable({}, LootService)
	self.diContainer = diContainer
	return self
end

---@param loot Model
function LootService:pickupLoot(loot) end

return LootService
