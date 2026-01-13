local Scroll = {}

---@param scrollName string
function Scroll:getScrollData(scrollName)
    return self[scrollName]
end


function Scroll:getAll()
	local all = {}
	for i, v in self do
		if typeof(v) == "table" then
			all[i] = v
		end
	end
	return all
end


return Scroll