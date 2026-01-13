local Items = {
	Weapon = require(script.Weapon),
	Food = require(script.Food),
	Scroll = require(script.Scroll),
	Cloth = require(script.Cloth),
	Resource = require(script.Resource),
	Potion = require(script.Potion),
	Misc = require(script.Misc),
	MorphGem = require(script.MorphGem),
}

---@param itemName string
---@return table
function Items:getItemData(itemName)
	local weaponData, weaponType = self.Weapon:getWeaponData(itemName)
	if weaponData then
		weaponData.type = weaponType
		return weaponData
	end

	local foodData = self.Food:getFoodData(itemName)
	if foodData then
		foodData.type = "Food"
		return foodData
	end

	local scrollData = self.Scroll:getScrollData(itemName)
	if scrollData then
		scrollData.type = "Scroll"
		return scrollData
	end

	local clothData = self.Cloth:getClothData(itemName)
	if clothData then
		clothData.type = "Cloth"
		return clothData
	end

	local resourceData = self.Resource:getResourceData(itemName)
	if resourceData then
		resourceData.type = "Resource"
		return resourceData
	end

	local potionData = self.Potion:getPotionData(itemName)
	if potionData then
		potionData.type = "Potion"
		return potionData
	end

	local morphGem = self.MorphGem:getMorphGemData(itemName)
	if morphGem then
		morphGem.type = "MorphGem"
		return morphGem
	end

	return {}
end

function Items:getAll()
	local all = {}
	for i, v in self do
		if typeof(v) == "table" then
			all[i] = v
		end
	end
	return {self.Food} ---all
end

return Items
