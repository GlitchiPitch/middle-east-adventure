---@class rings
---@field left RingEntity
---@field right RingEntity

---@class EquipmentEntity
---@field cloth ClothEntity
---@field rings rings
---@field amulet AmuletEntity
---@field slots table<Enum.KeyCode, ItemEntity>
local Equipment = {}
Equipment.__index = Equipment

function Equipment.new()
	local self = setmetatable({}, Equipment)
	self.cloth = nil
	self.rings = {
		left = nil,
		right = nil,
	}
	self.amulet = nil
	self.slots = {
		[Enum.KeyCode.One] = nil,
		[Enum.KeyCode.Two] = nil,
		[Enum.KeyCode.Three] = nil,
		[Enum.KeyCode.Four] = nil,
	}
	return self
end

---@param ring RingEntity
function Equipment:equipRing(ring)
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
function Equipment:equipAmulet(amulet)
	self.amulet = amulet
end

---@param item ItemEntity
function Equipment:equipSlot(item)
	local keys = {
		Enum.KeyCode.One,
		Enum.KeyCode.Two,
		Enum.KeyCode.Three,
		Enum.KeyCode.Four,
	}

	local freeSlot

	for _, key in keys do
		if not self.slots[key] then
			freeSlot = key
			break
		end
	end

	freeSlot = freeSlot or Enum.KeyCode.One
	self.slots[freeSlot] = item
end

---@param cloth ClothEntity
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
