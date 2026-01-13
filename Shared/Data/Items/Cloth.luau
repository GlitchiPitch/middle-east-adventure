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
	return self.Accessory[clothName] or self.Robe[clothName]
end

function Cloth:getAll()
	local all = {}
	for _, v in { self.Accessory, self.Robe } do
		for j, k in v do
			all[j] = k
		end
	end

	return all
end

return Cloth
