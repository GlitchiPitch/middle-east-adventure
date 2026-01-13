local MorphGem = {}

---@param name string
---@return table
function MorphGem:getMorphGemData(name)
	return self[name]
end

function MorphGem:getAll()
	return self
end

return MorphGem
