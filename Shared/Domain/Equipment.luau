---@class rings
---@field left RingEntity
---@field right RingEntity

---@class EquipmentEntity
---@field cloth ClothEntity
---@field rings rings
---@field amulet AmuletEntity
---@field slots table<string, string>
---@field equippedItem string
local Equipment = {}
Equipment.__index = Equipment

function Equipment.new(data)
	local self = setmetatable({}, Equipment)
	self.cloth = data.cloth
	self.rings = data.rings or {
		left = nil,
		right = nil,
	}
	self.amulet = data.amulet

	self.equippedItem = nil

	self.slots = data.slots
		or {
			[Enum.KeyCode.One.Name] = nil,
			[Enum.KeyCode.Two.Name] = nil,
			[Enum.KeyCode.Three.Name] = nil,
			[Enum.KeyCode.Four.Name] = nil,
		}

	return self
end

---@param ring RingEntity
function Equipment:setRing(ring)
	local sides = {
		"left",
		"right",
	}

	local freeSide
	for _, side in sides do
		if not self.rings[side] then
			freeSide = side
			break
		end
	end

	freeSide = freeSide or "left"
	self.rings[freeSide] = ring
end

---@param amulet AmuletEntity
function Equipment:setAmulet(amulet)
	self.amulet = amulet
end

---@param itemName string
function Equipment:equipItem(itemName)
	self.equippedItem = itemName
end

---@param itemData table
function Equipment:setSlot(itemData)
	local keys = {
		Enum.KeyCode.One.Name,
		Enum.KeyCode.Two.Name,
		Enum.KeyCode.Three.Name,
		Enum.KeyCode.Four.Name,
	}

	for _, key in keys do
		if itemData.state == "set" then
			if not self.slots[key] then
				self.slots[key] = itemData.itemName
				return
			end
		elseif itemData.state == "remove" then
			if self.slots[key] and self.slots[key] == itemData.itemName then
				self.slots[key] = nil
				break
			end
		end
	end
end

---@param cloth string
function Equipment:equipCloth(cloth)
	self.cloth = cloth
end

---@return table<string, number>
function Equipment:calculateBoosts()
	local boosts = {
		-- Defense boosts
		bladeDefense = 0,
		strikeDefense = 0,
		arrowDefense = 0,
		fireDefense = 0,
		coldDefense = 0,

		-- Stat boosts
		strength = 0,
		dexterity = 0,
		health = 0,
		stamina = 0,
		mana = 0,

		-- Damage boosts
		damage = 0,
	}

	-- Calculate boosts from cloth armor
	if self.cloth then
		-- Cloth provides defense bonuses
		-- This would need to be expanded based on cloth data
		boosts.bladeDefense = boosts.bladeDefense + 5 -- basic armor
		boosts.strikeDefense = boosts.strikeDefense + 3
	end

	-- Calculate boosts from rings
	for _, ring in pairs(self.rings) do
		if ring then
			-- Rings provide various bonuses (strength, dexterity, etc.)
			-- This would be based on ring data
			boosts.strength = boosts.strength + 2 -- example ring bonus
		end
	end

	-- Calculate boosts from amulet
	if self.amulet then
		-- Amulets provide various bonuses
		-- This would be based on amulet data
		boosts.mana = boosts.mana + 10 -- example amulet bonus
	end

	-- Calculate boosts from equipped weapons/tools in slots
	for _, itemName in pairs(self.slots) do
		if itemName then
			-- Weapons provide damage bonuses
			-- This would need item data lookup
			boosts.damage = boosts.damage + 5 -- example weapon bonus
		end
	end

	return boosts
end

function Equipment:toData()
	return {
		cloth = self.cloth,
		rings = self.rings,
		amulet = self.amulet,
		slots = self.slots,
	}
end

return Equipment
