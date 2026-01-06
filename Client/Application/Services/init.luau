local PlayerService = require(script.PlayerService)
local InventoryService = require(script.InventoryService)

---@class ClientApplicationServices
---@field playerService ClientApplicationPlayerService
---@field inventoryService ClientApplicationInventoryService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ClientApplicationServices
function Services.new(diContainer)
    local self = setmetatable({}, Services)
    self.playerService = PlayerService.new(diContainer)
    self.inventoryService = InventoryService.new(diContainer)
    return self
end

return Services