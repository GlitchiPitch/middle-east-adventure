local Interfaces = require(script.Parent.Interfaces)
local IRepository = Interfaces.IRepository

---@class SkillsRepository : IRepository
---@field playerRepository IPlayerRepository
local SkillsRepository = setmetatable({}, { __index = IRepository })
SkillsRepository.__index = SkillsRepository

---@param diContainer DIContainer
---@return SkillsRepository
function SkillsRepository.new(diContainer)
	local self = setmetatable(IRepository.new(diContainer), SkillsRepository)
	return self
end

function SkillsRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.playerRepository = shared.infrastructure.repositories.playerRepository
end

---@param playerEntity PlayerEntity
---@return SkillsEntity
function SkillsRepository:getSkills(playerEntity)
	return playerEntity.skills
end

---@param playerEntity PlayerEntity
---@param skillType string
---@param skillName string
---@param value number
function SkillsRepository:updateSkill(playerEntity, skillType, skillName, value)
	local skills = self:getSkills(playerEntity)

	if skills[skillType] then
		skills[skillType][skillName] = value
	else
		skills[skillType] = {}
		skills[skillType][skillName] = value
	end
end

---@param playerEntity PlayerEntity
---@param skillType string
---@param skillName string
function SkillsRepository:levelUpSkill(playerEntity, skillType, skillName)
	local skills = self:getSkills(playerEntity)

	if not skills[skillType] then
		skills[skillType] = {}
	end

	if not skills[skillType][skillName] then
		skills[skillType][skillName] = 0
	end

	skills[skillType][skillName] = skills[skillType][skillName] + 1
end

---@param playerEntity PlayerEntity
---@param skillType string
---@param skillName string
---@return number
function SkillsRepository:getSkillLevel(playerEntity, skillType, skillName)
	local skills = self:getSkills(playerEntity)

	if skills[skillType] and skills[skillType][skillName] then
		return skills[skillType][skillName]
	end

	return 0
end

---@param playerEntity PlayerEntity
---@param skillType string
---@return table
function SkillsRepository:getSkillsByType(playerEntity, skillType)
	local skills = self:getSkills(playerEntity)
	return skills[skillType] or {}
end

return SkillsRepository
