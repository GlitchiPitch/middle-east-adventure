local Items = {
	-- Ленивая загрузка модулей
	_weaponModule = nil,
	_foodModule = nil,
	_scrollModule = nil,
	_clothModule = nil,
	_resourceModule = nil,
	_potionModule = nil,
	_miscModule = nil,
	_morphGemModule = nil,
}

-- Ленивая загрузка модулей
local function getWeaponModule()
	if not Items._weaponModule then
		Items._weaponModule = require(script.Weapon)
	end
	return Items._weaponModule
end

local function getFoodModule()
	if not Items._foodModule then
		Items._foodModule = require(script.Food)
	end
	return Items._foodModule
end

local function getScrollModule()
	if not Items._scrollModule then
		Items._scrollModule = require(script.Scroll)
	end
	return Items._scrollModule
end

local function getClothModule()
	if not Items._clothModule then
		Items._clothModule = require(script.Cloth)
	end
	return Items._clothModule
end

local function getResourceModule()
	if not Items._resourceModule then
		Items._resourceModule = require(script.Resource)
	end
	return Items._resourceModule
end

local function getPotionModule()
	if not Items._potionModule then
		Items._potionModule = require(script.Potion)
	end
	return Items._potionModule
end

local function getMiscModule()
	if not Items._miscModule then
		Items._miscModule = require(script.Misc)
	end
	return Items._miscModule
end

local function getMorphGemModule()
	if not Items._morphGemModule then
		Items._morphGemModule = require(script.MorphGem)
	end
	return Items._morphGemModule
end

---@param itemName string
---@return table
function Items:getItemData(itemName)
	-- Ленивая загрузка и проверка оружия
	local weaponModule = getWeaponModule()
	local weaponData, weaponType = weaponModule:getWeaponData(itemName)
	if weaponData then
		weaponData.weaponType = weaponType
		weaponData.type = "Weapon"
		return weaponData
	end

	-- Ленивая загрузка и проверка еды
	local foodModule = getFoodModule()
	local foodData = foodModule:getFoodData(itemName)
	if foodData then
		foodData.type = "Food"
		return foodData
	end

	-- Ленивая загрузка и проверка свитков
	local scrollModule = getScrollModule()
	local scrollData = scrollModule:getScrollData(itemName)
	if scrollData then
		scrollData.type = "Scroll"
		return scrollData
	end

	-- Ленивая загрузка и проверка одежды
	local clothModule = getClothModule()
	local clothData = clothModule:getClothData(itemName)
	if clothData then
		clothData.type = "Cloth"
		return clothData
	end

	-- Ленивая загрузка и проверка ресурсов
	local resourceModule = getResourceModule()
	local resourceData = resourceModule:getResourceData(itemName)
	if resourceData then
		resourceData.type = "Resource"
		return resourceData
	end

	-- Ленивая загрузка и проверка зелий
	local potionModule = getPotionModule()
	local potionData = potionModule:getPotionData(itemName)
	if potionData then
		potionData.type = "Potion"
		return potionData
	end

	-- Ленивая загрузка и проверка морф-гемов
	local morphGemModule = getMorphGemModule()
	local morphGem = morphGemModule:getMorphGemData(itemName)
	if morphGem then
		morphGem.type = "MorphGem"
		return morphGem
	end

	return {}
end

function Items:getAll()
	local all = {}

	-- Ленивая загрузка всех модулей только при первом вызове getAll()
	local weaponModule = getWeaponModule()
	local foodModule = getFoodModule()
	local scrollModule = getScrollModule()
	local clothModule = getClothModule()
	local resourceModule = getResourceModule()
	local potionModule = getPotionModule()
	local miscModule = getMiscModule()
	local morphGemModule = getMorphGemModule()

	all.Weapon = weaponModule
	all.Food = foodModule
	all.Scroll = scrollModule
	all.Cloth = clothModule
	all.Resource = resourceModule
	all.Potion = potionModule
	all.Misc = miscModule
	all.MorphGem = morphGemModule

	return all
end

return Items
