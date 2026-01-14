---@class ServerUpdateAttribute
---@field attributesRepository ServerAttributesRepository
---@field playerService ServerPlayerService
---@field constants Constants
local UpdateAttribute = {}
UpdateAttribute.__index = UpdateAttribute

---@param attributesRepository ServerAttributesRepository
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerUpdateAttribute
function UpdateAttribute.new(attributesRepository, playerService, constants)
	local self = setmetatable({}, UpdateAttribute)
	self.attributesRepository = attributesRepository
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
---@param attributeName string
---@param value number
function UpdateAttribute:execute(player, attributeName, value)
	self.attributesRepository:updateAttribute(player, attributeName, value)
	self.playerService:updatePlayerData(player)
end

return UpdateAttribute