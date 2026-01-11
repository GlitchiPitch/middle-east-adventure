local Mushrooms = {}
local Herbs = {}
local Misc = {}

local Resource = {
	Mushrooms = Mushrooms,
	Herbs = Herbs,
	Misc = Misc,
}

---@param resourceName string
function Resource:getResourceData(resourceName)
	return self.Mushrooms[resourceName] or self.Herbs[resourceName] or self.Misc[resourceName]
end

return Resource
