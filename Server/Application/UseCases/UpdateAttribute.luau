---@class ServerUpdateAttribute
---@field attributesRepository ServerAttributesRepository
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local UpdateAttribute = {}
UpdateAttribute.__index = UpdateAttribute

---@param diContainer DIContainer
---@return ServerUpdateAttribute
function UpdateAttribute.new(diContainer)
	local self = setmetatable({}, UpdateAttribute)
	self.diContainer = diContainer
	return self
end

function UpdateAttribute:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")

	self.attributesRepository = infrastructure.attributesRepository
	self.playerService = application.services.playerService
	self.constants = shared.constants
end

---@param player Player
---@param attributeName string
---@param value number
function UpdateAttribute:execute(player, attributeName, value)
	local playerEntity = self.playerService:getPlayerEntity(player)
	self.attributesRepository:updateAttribute(playerEntity, attributeName, value)
	self.playerService:updatePlayerData(player)
end

return UpdateAttribute