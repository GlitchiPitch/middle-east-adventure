local Robe = {}
local Accessory = {
	Ring = {},
	Amulet = {},
}

local Cloth = {
	Robe = Robe,
	Accessory = Accessory,
}

---@param clothName string
function Cloth:getClothData(clothName)
	return self[clothName]
end

return Cloth
