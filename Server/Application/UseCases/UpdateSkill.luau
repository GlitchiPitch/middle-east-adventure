---@class ServerUpdateSkill
---@field skillsRepository ServerSkillsRepository
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local UpdateSkill = {}
UpdateSkill.__index = UpdateSkill

---@param diContainer DIContainer
---@return ServerUpdateSkill
function UpdateSkill.new(diContainer)
	local self = setmetatable({}, UpdateSkill)
	self.diContainer = diContainer
	return self
end

function UpdateSkill:init()
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
---@param value number
function UpdateSkill:execute(player, skillType, skillName, value)
	local playerEntity = self.playerService:getPlayerEntity(player)
	self.skillsRepository:updateSkill(playerEntity, skillType, skillName, value)
	self.playerService:updatePlayerData(player)
end

return UpdateSkill