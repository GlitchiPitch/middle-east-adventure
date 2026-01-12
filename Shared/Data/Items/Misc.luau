local Mold = {}

local Misc = {
    Mold = Mold,
    
	Pickaxe = {
		image = "rbxassetid://127839083000298",
	},
	BlacksmithHammer = {},
}

---@param miscName string
function Misc:getMiscData(miscName)
	return self[miscName]
end

return Misc
