---@class ClientEquipItem
---@field remoteEventService RemoteEventService
---@field constants Constants
---@field playerService ClientPlayerService
---@field diContainer DIContainer
---@field cache Cache
local EquipItem = {}
EquipItem.__index = EquipItem

---@param diContainer DIContainer
---@return ClientEquipItem
function EquipItem.new(diContainer)
	local self = setmetatable({}, EquipItem)
	self.diContainer = diContainer
	return self
end

function EquipItem:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")

	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
	self.playerService = application.services.playerService
	self.cache = shared.infrastructure.cache
end

---@param command EquipItemCommand
function EquipItem:execute(command)
	-- Try to get equipment data from cache first
	local player = game.Players.LocalPlayer
	local cacheKey = "Equipment:" .. player.UserId
	local cachedEquipment = self.cache:get(cacheKey)

	local equipmentSlots
	if cachedEquipment then
		equipmentSlots = cachedEquipment.slots
		print("Using cached equipment data for slot validation")
	else
		-- Fallback to direct access if not cached
		---@type ClientInfrastructure
		local infrastructure = self.diContainer:resolve("Infrastructure")
		local playerEntity = infrastructure.playerRepository:getPlayerEntity()
		equipmentSlots = playerEntity.equipment.slots
		print("Using direct equipment data for slot validation")
	end

	if equipmentSlots[command.slotIndex] then
		self.remoteEventService:fireServer({
			eventName = self.constants.REMOTE_EVENTS.EQUIP_ITEM,
			data = command,
		})
	end
end

return EquipItem