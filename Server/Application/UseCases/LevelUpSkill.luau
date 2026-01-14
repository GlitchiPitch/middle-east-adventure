---@class ServerLevelUpSkill
---@field skillsRepository ServerSkillsRepository
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local LevelUpSkill = {}
LevelUpSkill.__index = LevelUpSkill

---@param diContainer DIContainer
---@return ServerLevelUpSkill
function LevelUpSkill.new(diContainer)
	local self = setmetatable({}, LevelUpSkill)
	self.diContainer = diContainer
	return self
end

function LevelUpSkill:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")

	self.skillsRepository = infrastructure.skillsRepository
	self.playerService = application.services.playerService
	self.constants = shared.constants
end

---@param player Player
---@param skillType string
---@param skillName string
function LevelUpSkill:execute(player, skillType, skillName)
	local playerEntity = self.playerService:getPlayerEntity(player)
	self.skillsRepository:levelUpSkill(playerEntity, skillType, skillName)
	self.playerService:updatePlayerData(player)
end

return LevelUpSkill