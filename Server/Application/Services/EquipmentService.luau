---@class ServerEquipmentService
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
---@field toolService ServerToolService
---@field useCases ServerUseCases
local EquipmentService = {}
EquipmentService.__index = EquipmentService

---@param diContainer DIContainer
---@return ServerEquipmentService
function EquipmentService.new(diContainer)
	local self = setmetatable({}, EquipmentService)
	self.diContainer = diContainer
	return self
end

function EquipmentService:init()
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.sharedData = shared.data
	self.playerRepository = infrastructure.playerRepository
	self.toolService = application.services.toolService
	self.useCases = application.useCases
end

---@param player Player
---@param command EquipItemCommand
function EquipmentService:equipItem(player, command)
	self.useCases.equipItem:execute(player, command)
end

---@param player Player
---@param itemData table
function EquipmentService:setPlayerSlot(player, itemData)
	self.useCases.setEquipmentSlot:execute(player, itemData.name, itemData.slot or "One")
end


function EquipmentService:useFood()
	
end

return EquipmentService
