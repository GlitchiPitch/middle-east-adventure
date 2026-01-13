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

function Equipment:calculateBoosts() end

function Equipment:toData()
	return {
		cloth = self.cloth,
		rings = self.rings,
		amulet = self.amulet,
		slots = self.slots,
	}
end

return Equipment
