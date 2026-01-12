---@class ClientEquipmentService
---@field diContainer DIContainer
---@field eventBus EventBus
---@field useCases ClientUseCases
---@field commands SharedCommands
local EquipmentService = {}
EquipmentService.__index = EquipmentService

---@param diContainer DIContainer
---@return ClientEquipmentService
function EquipmentService.new(diContainer)
	local self = setmetatable({}, EquipmentService)
	self.diContainer = diContainer
	return self
end

function EquipmentService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
    ---@type ClientApplication
    local application = self.diContainer:resolve("Application")

    self.useCases = application.useCases
    self.commands = shared.application.commands
	self.eventBus = shared.eventBus
end

---@param keyCodeName string
function EquipmentService:pressEquipKey(keyCodeName)
	self.eventBus:fire("pressEquipKey", keyCodeName)
    self.useCases.equipItem:execute(self.commands.EquipItemCommand.new(keyCodeName))
end

return EquipmentService
