---@class ClientSkillsRepository
---@field diContainer DIContainer
---@field playerRepository ClientPlayerRepository
local SkillsRepository = {}
SkillsRepository.__index = SkillsRepository

---@param diContainer DIContainer
---@return ClientSkillsRepository
function SkillsRepository.new(diContainer)
    local self = setmetatable({}, SkillsRepository)
    self.diContainer = diContainer
    return self
end

function SkillsRepository:init()
	---@type ClientInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.playerRepository
end

---@return SkillsEntity
function SkillsRepository:getSkills()
    local playerEntity = self.playerRepository:getPlayerEntity()
    return playerEntity:getSkills()
end

---@param skillType string
---@param skillName string
---@param value number
function SkillsRepository:updateSkill(skillType, skillName, value)
    -- Client-side implementation - would typically use RemoteEvent
    local skills = self:getSkills()

    if skills[skillType] then
        skills[skillType][skillName] = value
    else
        skills[skillType] = {}
        skills[skillType][skillName] = value
    end
end

---@param skillType string
---@param skillName string
function SkillsRepository:levelUpSkill(skillType, skillName)
    local skills = self:getSkills()

    if not skills[skillType] then
        skills[skillType] = {}
    end

    if not skills[skillType][skillName] then
        skills[skillType][skillName] = 0
    end

    skills[skillType][skillName] = skills[skillType][skillName] + 1
end

---@param skillType string
---@param skillName string
---@return number
function SkillsRepository:getSkillLevel(skillType, skillName)
    local skills = self:getSkills()

    if skills[skillType] and skills[skillType][skillName] then
        return skills[skillType][skillName]
    end

    return 0
end

---@param skillType string
---@return table
function SkillsRepository:getSkillsByType(skillType)
    local skills = self:getSkills()
    return skills[skillType] or {}
end

return SkillsRepository