local InventoryService = require(script.InventoryService)
local PlayerService = require(script.PlayerService)
local TradeService = require(script.TradeService)
local CraftService = require(script.CraftService)
local SmithService = require(script.SmithService)
local FishingService = require(script.FishingService)
local HuntingService = require(script.HuntingService)
local AlchemyService = require(script.AlchemyService)
local CombatService = require(script.CombatService)
local ToolService = require(script.ToolService)
local LootService = require(script.LootService)
local LecternService = require(script.LecternService)
local EquipmentService = require(script.EquipmentService)

---@class ServerApplicationServices
---@field inventoryService ServerInventoryService
---@field playerService ServerPlayerService
---@field tradeService ServerApplicationTradeService
---@field craftService ServerApplicationCraftService
---@field smithService ServerApplicationSmithService
---@field fishingService ServerApplicationFishingService
---@field huntingService ServerApplicationHuntingService
---@field alchemyService ServerApplicationAlchemyService
---@field combatService ServerApplicationCombatService
---@field toolService ServerToolService
---@field lootService ServerLootService
---@field lecternService ServerLecternService
---@field equipmentService ServerEquipmentService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ServerApplicationServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.inventoryService = InventoryService.new(diContainer)
	self.playerService = PlayerService.new(diContainer)
	self.tradeService = TradeService.new()
	self.craftService = CraftService.new()
	self.smithService = SmithService.new()
	self.fishingService = FishingService.new()
	self.huntingService = HuntingService.new()
	self.alchemyService = AlchemyService.new()
	self.combatService = CombatService.new()
	self.toolService = ToolService.new(diContainer)
	self.lecternService = LecternService.new(diContainer)
	self.lootService = LootService.new(diContainer)
	self.equipmentService = EquipmentService.new(diContainer)
	return self
end

function Services:init()
	self.playerService:init()
	self.inventoryService:init()
	self.lootService:init()
	self.lecternService:init()
	self.equipmentService:init()
	self.toolService:init()
end

return Services
