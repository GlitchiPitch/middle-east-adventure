---@class ClientLootService
local LootService = {}
LootService.__index = LootService

---@return ClientLootService
function LootService.new()
    local self = setmetatable({}, LootService)
    return self
end

function LootService:pickupLoot()
    
end

return LootService