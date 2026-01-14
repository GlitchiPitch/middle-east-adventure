---@class ServerLevelUpPlayer
---@field attributesRepository ServerAttributesRepository
---@field playerService ServerPlayerService
---@field constants Constants
local LevelUpPlayer = {}
LevelUpPlayer.__index = LevelUpPlayer

---@param attributesRepository ServerAttributesRepository
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerLevelUpPlayer
function LevelUpPlayer.new(attributesRepository, playerService, constants)
	local self = setmetatable({}, LevelUpPlayer)
	self.attributesRepository = attributesRepository
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
function LevelUpPlayer:execute(player)
	self.attributesRepository:levelUp(player)
	self.playerService:updatePlayerData(player)
end

return LevelUpPlayer