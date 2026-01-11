---@class ClientLootService
---@field diContainer DIContainer
---@field animationService AnimationService
---@field playerService ClientPlayerService
---@field remoteEventService RemoteEventService
---@field constants Constants
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
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	self.animationService = application.services.animationService
	self.playerService = application.services.playerService
	
end

---@param loot Model
function LootService:pickupLoot(loot)
	self.animationService.animTracks.PickupLoot:Play()
	task.wait(self.animationService.animTracks.PickupLoot.Length)
	self.playerService:toggleRobloxControl(true)
	
end

return LootService
