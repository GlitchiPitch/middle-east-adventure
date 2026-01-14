---@class ServerClickInventoryItem
---@field equipmentRepository ServerEquipmentRepository
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local ClickInventoryItem = {}
ClickInventoryItem.__index = ClickInventoryItem

---@param diContainer DIContainer
---@return ServerClickInventoryItem
function ClickInventoryItem.new(diContainer)
	local self = setmetatable({}, ClickInventoryItem)
	self.diContainer = diContainer
	return self
end

function ClickInventoryItem:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")

	self.equipmentRepository = infrastructure.equipmentRepository
	self.playerService = application.services.playerService
	self.constants = shared.constants
end

---@param player Player
---@param itemData table
function ClickInventoryItem:execute(player, itemData)
	local playerEntity = self.playerService:getPlayerEntity(player)
	local equipment = self.equipmentRepository:getEquipment(playerEntity)
	local keys = {
		Enum.KeyCode.One.Name,
		Enum.KeyCode.Two.Name,
		Enum.KeyCode.Three.Name,
		Enum.KeyCode.Four.Name,
	}

	for _, key in keys do
		if not equipment.slots[key] then
			self.equipmentRepository:setSlot(playerEntity, itemData.name, key)
			self.playerService:updatePlayerData(player)
			return
		end
	end
end

return ClickInventoryItem