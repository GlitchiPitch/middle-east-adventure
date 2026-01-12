---@class rings
---@field left RingEntity
---@field right RingEntity

---@class EquipmentEntity
---@field cloth ClothEntity
---@field rings rings
---@field amulet AmuletEntity
---@field slots table<string, string>
---@field equippedWeapon string
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

	self.equippedWeapon = nil

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

---@param weaponName string
function Equipment:equipWeapon(weaponName)
	self.equippedWeapon = weaponName
end

---@param itemName string
function Equipment:setSlot(itemName)
	local keys = {
		Enum.KeyCode.One.Name,
		Enum.KeyCode.Two.Name,
		Enum.KeyCode.Three.Name,
		Enum.KeyCode.Four.Name,
	}

	local freeSlot

	for _, key in keys do
		if not self.slots[key] then
			freeSlot = key
			break
		end
	end

	freeSlot = freeSlot or Enum.KeyCode.One.Name
	self.slots[freeSlot] = itemName
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
