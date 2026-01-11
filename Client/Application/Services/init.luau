local PlayerService = require(script.PlayerService)
local InventoryService = require(script.InventoryService)
local ToolService = require(script.ToolService)
local AnimationService = require(script.AnimationService)
local InputService = require(script.InputService)
local LootService = require(script.LootService)
local DialogService = require(script.DialogService)
local InteractService = require(script.InteractService)
local AlchemyService = require(script.AlchemyService)
local SmithService = require(script.SmithService)

---@class ClientApplicationServices
---@field playerService ClientApplicationPlayerService
---@field inventoryService ClientApplicationInventoryService
---@field toolService ClientToolService
---@field animationService AnimationService
---@field inputService InputService
---@field lootService ClientLootService
---@field dialogService DialogService
---@field interactService ClientInteractService
---@field alchemyService ClientAlchemyService
---@field smithService ClientSmithService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ClientApplicationServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.playerService = PlayerService.new(diContainer)
	self.inventoryService = InventoryService.new(diContainer)
	self.toolService = ToolService.new(diContainer)
	self.animationService = AnimationService.new(diContainer)
	self.inputService = InputService.new(diContainer)
	self.lootService = LootService.new()
	self.dialogService = DialogService.new(diContainer)
	self.interactService = InteractService.new(diContainer)
	self.alchemyService = AlchemyService.new(diContainer)
	self.smithService = SmithService.new(diContainer)
	return self
end

function Services:init()
	self.animationService:init()
	self.inputService:init()
	self.toolService:init()
	self.interactService:init()
	self.alchemyService:init()
	self.dialogService:init()
	self.smithService:init()
end

return Services
