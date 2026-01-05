local InventoryService = require(script.InventoryService)
local PlayerService = require(script.PlayerService)
local TradeService = require(script.TradeService)
local CraftService = require(script.CraftService)
local SmithService = require(script.SmithService)
local FishingService = require(script.FishingService)
local HuntingService = require(script.HuntingService)
local AlchemyService = require(script.AlchemyService)
local CombatService = require(script.CombatService)

---@class ServerApplicationServices
---@field inventoryService ServerApplicationInventoryService
---@field playerService ServerApplicationPlayerService
---@field tradeService ServerApplicationTradeService
---@field craftService ServerApplicationCraftService
---@field smithService ServerApplicationSmithService
---@field fishingService ServerApplicationFishingService
---@field huntingService ServerApplicationHuntingService
---@field alchemyService ServerApplicationAlchemyService
---@field combatService ServerApplicationCombatService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ServerApplicationServices
function Services.new(diContainer)
    local self = setmetatable({}, Services)
    self.inventoryService = InventoryService.new()
    self.playerService = PlayerService.new(diContainer)
    self.tradeService = TradeService.new()
    self.craftService = CraftService.new()
    self.smithService = SmithService.new()
    self.fishingService = FishingService.new()
    self.huntingService = HuntingService.new()
    self.alchemyService = AlchemyService.new()
    self.combatService = CombatService.new()
    return self
end

return Services
