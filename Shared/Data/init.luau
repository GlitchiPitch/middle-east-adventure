---@class SharedData
local Data = {
	Weapons = require(script.Weapons),
	Magic = require(script.Magic),
	Hunting = require(script.Hunting),
	Alchemy = require(script.Alchemy),
	Misc = require(script.Misc),
	Smith = require(script.Smith),
	Thief = require(script.Thief),
}

---@param itemName string
function Data:getItemData(itemName)
	local itemData = Data.Weapons:getWeaponData(itemName) or Data.Magic:getMagicData(itemName)
    return itemData
end

return Data
