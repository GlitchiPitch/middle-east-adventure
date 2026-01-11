local Food = {}

---@param foodName string
---@return table
function Food:getFoodData(foodName)
	return self[foodName]
end

return Food
