---@class ClientLootService
---@field diContainer DIContainer
---@field animationService AnimationService
---@field playerService ClientPlayerService
---@field useCases ClientUseCases
local LootService = {}
LootService.__index = LootService

---@param diContainer DIContainer
---@return ClientLootService
function LootService.new(diContainer)
	local self = setmetatable({}, LootService)
	self.diContainer = diContainer
	return self
end

function LootService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.commands = shared.application.commands
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	self.animationService = application.services.animationService
	self.playerService = application.services.playerService
	self.useCases = application.useCases
end

---@param loot Model
function LootService:pickupLoot(loot)
	self.animationService.animTracks.PickupLoot:Play()
	task.wait(self.animationService.animTracks.PickupLoot.Length)
	self.playerService:toggleRobloxControl(true)
	self.useCases.pickupLoot:execute(self.commands.PickupLootCommand.new(loot))
end

return LootService
