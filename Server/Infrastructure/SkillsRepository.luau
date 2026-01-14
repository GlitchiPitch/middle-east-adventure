---@class ServerSkillsRepository
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
local SkillsRepository = {}
SkillsRepository.__index = SkillsRepository

---@param diContainer DIContainer
---@return ServerSkillsRepository
function SkillsRepository.new(diContainer)
    local self = setmetatable({}, SkillsRepository)
    self.diContainer = diContainer
    return self
end

function SkillsRepository:init()
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.playerRepository
end

---@param player Player
---@return SkillsEntity
function SkillsRepository:getSkills(player)
    local playerEntity = self.playerRepository:getPlayerEntity(player)
    return playerEntity:getSkills()
end

---@param player Player
---@param skillType string
---@param skillName string
---@param value number
function SkillsRepository:updateSkill(player, skillType, skillName, value)
    local skills = self:getSkills(player)

    if skills[skillType] then
        skills[skillType][skillName] = value
    else
        skills[skillType] = {}
        skills[skillType][skillName] = value
    end
end

---@param player Player
---@param skillType string
---@param skillName string
function SkillsRepository:levelUpSkill(player, skillType, skillName)
    local skills = self:getSkills(player)

    if not skills[skillType] then
        skills[skillType] = {}
    end

    if not skills[skillType][skillName] then
        skills[skillType][skillName] = 0
    end

    skills[skillType][skillName] = skills[skillType][skillName] + 1
end

---@param player Player
---@param skillType string
---@param skillName string
---@return number
function SkillsRepository:getSkillLevel(player, skillType, skillName)
    local skills = self:getSkills(player)

    if skills[skillType] and skills[skillType][skillName] then
        return skills[skillType][skillName]
    end

    return 0
end

---@param player Player
---@param skillType string
---@return table
function SkillsRepository:getSkillsByType(player, skillType)
    local skills = self:getSkills(player)
    return skills[skillType] or {}
end

return SkillsRepository