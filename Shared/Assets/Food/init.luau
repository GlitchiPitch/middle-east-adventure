local Food = {
	Meat = script:FindFirstChild("Meat"),
	Banana = script:FindFirstChild("Banana"),
	Ham = script:FindFirstChild("Ham"),
	Rice = script:FindFirstChild("Rice"),
	Fish = script:FindFirstChild("Fish"),
	Fleischwanzenragout = script:FindFirstChild("Fleischwanzenragout"),
	GebratenesFleisch = script:FindFirstChild("GebratenesFleisch"),
	Apple = script:FindFirstChild("Apple"),
	ScavengerEgg = script:FindFirstChild("ScavengerEgg"),
}

---@param name string
---@return Tool?
function Food:getFoodTool(name)
	if self[name] then
		return self[name]:Clone()
	end
	return
end

return Food
