---@class ServerLevelUpSkill
---@field skillsRepository ServerSkillsRepository
---@field playerService ServerPlayerService
---@field constants Constants
local LevelUpSkill = {}
LevelUpSkill.__index = LevelUpSkill

---@param skillsRepository ServerSkillsRepository
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerLevelUpSkill
function LevelUpSkill.new(skillsRepository, playerService, constants)
	local self = setmetatable({}, LevelUpSkill)
	self.skillsRepository = skillsRepository
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
---@param skillType string
---@param skillName string
function LevelUpSkill:execute(player, skillType, skillName)
	self.skillsRepository:levelUpSkill(player, skillType, skillName)
	self.playerService:updatePlayerData(player)
end

return LevelUpSkill