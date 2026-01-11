local Mold = {}

local Misc = {
    Mold = Mold,
    
	Pickaxe = {},
	BlacksmithHammer = {},
}

---@param miscName string
function Misc:getMiscData(miscName)
	return self[miscName]
end

return Misc
