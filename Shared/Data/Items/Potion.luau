local Potion = {}

---@param potionName string
function Potion:getPotionData(potionName)
	return self[potionName]
end

return Potion
