---@class exp
---@field exp number
---@field expPoints number
---@field level number

---@class defense
---@field arrows number
---@field blade number
---@field cold number
---@field fire number
---@field hit number

---@class AttributesEntity
---@field strength number
---@field dexterity number
---@field ancientKnowledge number
---@field blacksmith number
---@field thief number
---@field alchemy number
---@field health number
---@field stamina number
---@field mana number
---@field exp exp
---@field defense defense
local Attributes = {}
Attributes.__index = Attributes

---@param data table
---@return AttributesEntity
function Attributes.new(data)
	local self = setmetatable({}, Attributes)

	self.dexterity = data.dexterity or 100
	self.strength = data.strength or 100
	self.ancientKnowledge = data.ancientKnowledge or 0
	self.blacksmith = data.blacksmith or 0
	self.thief = data.thief or 0
	self.alchemy = data.alchemy or 0
	self.health = data.health or 100
	self.stamina = data.stamina or 100
	self.mana = data.mana or 100

	self.exp = {
		exp = 0, --data.exp or
		expPoints = data.expPoints or 0,
		level = data.level or 1,
	}

	self.defense = {
		arrows = data.arrows or 0,
		blade = data.blade or 0,
		cold = data.cold or 0,
		fire = data.fire or 0,
		hit = data.hit or 0,
	}

	return self
end

function Attributes:toData()
	return self
end

return Attributes
