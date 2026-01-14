---@class ServerAttributesRepository
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
local AttributesRepository = {}
AttributesRepository.__index = AttributesRepository

---@param diContainer DIContainer
---@return ServerAttributesRepository
function AttributesRepository.new(diContainer)
    local self = setmetatable({}, AttributesRepository)
    self.diContainer = diContainer
    
    return self
end

function AttributesRepository:init()
    ---@type ServerInfrastructure
    local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.playerRepository
end

---@param player Player
---@return AttributesEntity
function AttributesRepository:getAttributes(player)
    local playerEntity = self.playerRepository:getPlayerEntity(player)
    return playerEntity:getAttributes()
end

---@param player Player
---@param attributeName string
---@param value number
function AttributesRepository:updateAttribute(player, attributeName, value)
    local attributes = self:getAttributes(player)
    attributes[attributeName] = value
end

---@param player Player
---@param expAmount number
function AttributesRepository:addExp(player, expAmount)
    local attributes = self:getAttributes(player)
    attributes.exp.exp = attributes.exp.exp + expAmount
    attributes.exp.expPoints = attributes.exp.expPoints + expAmount

    -- Check for level up (simplified logic)
    local expNeeded = attributes.exp.level * 100 -- Example formula
    if attributes.exp.expPoints >= expNeeded then
        self:levelUp(player)
    end
end

---@param player Player
function AttributesRepository:levelUp(player)
    local attributes = self:getAttributes(player)
    attributes.exp.level = attributes.exp.level + 1
    attributes.exp.expPoints = attributes.exp.expPoints - (attributes.exp.level * 100)
end

---@param player Player
---@param attributeName string
---@return number
function AttributesRepository:getAttribute(player, attributeName)
    local attributes = self:getAttributes(player)
    return attributes[attributeName]
end

---@param player Player
---@return number
function AttributesRepository:getLevel(player)
    local attributes = self:getAttributes(player)
    return attributes.exp.level
end

---@param player Player
---@return number
function AttributesRepository:getExp(player)
    local attributes = self:getAttributes(player)
    return attributes.exp.exp
end

---@param player Player
---@param defenseType string
---@param value number
function AttributesRepository:updateDefense(player, defenseType, value)
    local attributes = self:getAttributes(player)
    if attributes.defense then
        attributes.defense[defenseType] = value
    end
end

return AttributesRepository