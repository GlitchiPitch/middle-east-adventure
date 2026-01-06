---@class SharedData
local Data = {
	Weapons = require(script.Weapons),
	Magic = require(script.Magic),
}

---@param itemName string
function Data:getItemData(itemName)
	local itemData = Data.Weapons:getWeaponData(itemName) or Data.Magic:getMagicData(itemName)
    return itemData
end

return Data
