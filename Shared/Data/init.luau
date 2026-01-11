---@class SharedData
local Data = {
	Magic = require(script.Magic),
	SKills = require(script.Skills),
	Items = require(script.Items),
	Dialogs = require(script.Dialogs),
}

---@param itemName string
---@return table
function Data:getItemData(itemName)
	local itemData = self.Items:getItemData(itemName)
	return itemData
end

function Data:getMagicData()
	
end

---@param npcName string
function Data:getDialogData(npcName)
	
end

---@param skillName string
function Data:getSkillData(skillName)
	
end

return Data
