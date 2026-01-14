---@class ServerUpdateSkill
---@field skillsRepository ServerSkillsRepository
---@field playerService ServerPlayerService
---@field constants Constants
local UpdateSkill = {}
UpdateSkill.__index = UpdateSkill

---@param skillsRepository ServerSkillsRepository
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerUpdateSkill
function UpdateSkill.new(skillsRepository, playerService, constants)
	local self = setmetatable({}, UpdateSkill)
	self.skillsRepository = skillsRepository
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
---@param skillType string
---@param skillName string
---@param value number
function UpdateSkill:execute(player, skillType, skillName, value)
	self.skillsRepository:updateSkill(player, skillType, skillName, value)
	self.playerService:updatePlayerData(player)
end

return UpdateSkill