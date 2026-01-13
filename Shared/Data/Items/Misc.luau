local Mold = {}
local Other = {
	Pickaxe = {
		image = "rbxassetid://127839083000298",
	},
	BlacksmithHammer = {},
}
local Misc = {
    Mold = Mold,
    Other = Other,
}

---@param miscName string
function Misc:getMiscData(miscName)
	return self.Mold[miscName] or self.Other[miscName]
end


function Misc:getAll()
	local all = {}
	for _, v in { self.Mold, self.Other } do
		for j, k in v do
			all[j] = k
		end
	end

	return all
end


return Misc
