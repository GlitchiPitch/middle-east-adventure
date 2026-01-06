local Types = require(script.Parent.Parent.Types)

local PLAYER_ATTRIBUTES = Types.PLAYER_ATTRIBUTES
local DAMAGE_TYPE = Types.DAMAGE_TYPE
local SKILLS = Types.SKILLS
local BOOSTS = Types.BOOSTS
local DEFENCES = Types.DEFENCES


---@class Magic
local Magic = {}

local _allMagic = {}

for _, v in Magic do
	for j, k in v do
		_allMagic[j] = k
	end
end

---@param magicName string
---@return table
function Magic:getMagicData(magicName)
	return _allMagic[magicName]
end


return Magic