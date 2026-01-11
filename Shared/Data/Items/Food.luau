local Food = {
	Banana = {
		name = "Banana",
		effect = "Regenerates 1% mana",
	},
	Ham = {
		name = "Ham",
		effect = "Regenerates 15% health",
	},
	Rice = {
		name = "Rice",
		effect = "Regenerates 3% health",
	},
	Fish = {
		name = "Fish",
		effect = "Regenerates 5% health",
	},
	Fleischwanzenragout = {
		name = "Fleischwanzenragout",
		effect = "Regenerates 20% health",
	},
	GebratenesFleisch = {
		name = "Gebratenes Fleisch",
		effect = "Regenerates 20% health",
	},
	Meat = {
		name = "Meat",
		effect = "Regenerates 3% health",
	},
	Apple = {
		name = "Apple",
		effect = "Regenerates 1% health",
	},
	ScavengerEgg = {
		name = "Scavenger Egg",
		effect = "Regenerates 5% health",
	},
}

---@param foodName string
---@return table
function Food:getFoodData(foodName)
	return self[foodName]
end

return Food
