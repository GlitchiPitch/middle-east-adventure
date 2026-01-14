---@class ClientAttributesRepository
---@field diContainer DIContainer
---@field playerRepository ClientPlayerRepository
local AttributesRepository = {}
AttributesRepository.__index = AttributesRepository

---@param diContainer DIContainer
---@return ClientAttributesRepository
function AttributesRepository.new(diContainer)
	local self = setmetatable({}, AttributesRepository)
	self.diContainer = diContainer
	return self
end

function AttributesRepository:init()
	---@type ClientInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.playerRepository
end

---@return AttributesEntity
function AttributesRepository:getAttributes()
	local playerEntity = self.playerRepository:getPlayerEntity()
	return playerEntity:getAttributes()
end

---@param attributeName string
---@param value number
function AttributesRepository:updateAttribute(attributeName, value)
	-- Client-side implementation - would typically use RemoteEvent
	local attributes = self:getAttributes()
	attributes[attributeName] = value
end

---@param expAmount number
function AttributesRepository:addExp(expAmount)
	local attributes = self:getAttributes()
	attributes.exp.exp = attributes.exp.exp + expAmount
	attributes.exp.expPoints = attributes.exp.expPoints + expAmount

	-- Check for level up (simplified logic)
	local expNeeded = attributes.exp.level * 100 -- Example formula
	if attributes.exp.expPoints >= expNeeded then
		self:levelUp()
	end
end

function AttributesRepository:levelUp()
	local attributes = self:getAttributes()
	attributes.exp.level = attributes.exp.level + 1
	attributes.exp.expPoints = attributes.exp.expPoints - (attributes.exp.level * 100)
end

---@param attributeName string
---@return number
function AttributesRepository:getAttribute(attributeName)
	local attributes = self:getAttributes()
	return attributes[attributeName]
end

---@return number
function AttributesRepository:getLevel()
	local attributes = self:getAttributes()
	return attributes.exp.level
end

---@return number
function AttributesRepository:getExp()
	local attributes = self:getAttributes()
	return attributes.exp.exp
end

---@param defenseType string
---@param value number
function AttributesRepository:updateDefense(defenseType, value)
	local attributes = self:getAttributes()
	if attributes.defense then
		attributes.defense[defenseType] = value
	end
end

return AttributesRepository
