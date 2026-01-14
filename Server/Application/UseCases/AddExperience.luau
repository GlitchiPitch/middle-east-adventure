---@class ServerAddExperience
---@field attributesRepository ServerAttributesRepository
---@field playerService ServerPlayerService
---@field constants Constants
local AddExperience = {}
AddExperience.__index = AddExperience

---@param attributesRepository ServerAttributesRepository
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerAddExperience
function AddExperience.new(attributesRepository, playerService, constants)
	local self = setmetatable({}, AddExperience)
	self.attributesRepository = attributesRepository
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
---@param expAmount number
function AddExperience:execute(player, expAmount)
	self.attributesRepository:addExp(player, expAmount)
	self.playerService:updatePlayerData(player)
end

return AddExperience