local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Shared.Assets)

local Food = {
	Banana = {
		name = "Banana",
		effect = {
			action = "restore",
			stats = {
				mana = 0.01, -- %
			},
		},
		model = Assets.Food.Banana,
		image = "rbxassetid://12284549846",
	},
	Ham = {
		name = "Ham",
		effect = "Regenerates 15% health",
		model = Assets.Food.Ham,
	},
	Rice = {
		name = "Rice",
		effect = "Regenerates 3% health",
		model = Assets.Food.Rice,
	},
	Fish = {
		name = "Fish",
		effect = "Regenerates 5% health",
		model = Assets.Food.Fish,
	},
	Fleischwanzenragout = {
		name = "Fleischwanzenragout",
		effect = "Regenerates 20% health",
		model = Assets.Food.Fleischwanzenragout,
	},
	GebratenesFleisch = {
		name = "Gebratenes Fleisch",
		effect = "Regenerates 20% health",
		model = Assets.Food.GebratenesFleisch,
	},
	Meat = {
		name = "Meat",
		effect = {
			action = "restore",
			stats = {
				health = 0.03, -- %
			},
		},
		model = Assets.Food.Meat,
		image = "rbxassetid://102437076121625",
	},
	Apple = {
		name = "Apple",
		effect = "Regenerates 1% health",
		model = Assets.Food.Apple,
	},
	ScavengerEgg = {
		name = "Scavenger Egg",
		effect = "Regenerates 5% health",
		model = Assets.Food.ScavengerEgg,
	},
}

---@param foodName string
---@return table
function Food:getFoodData(foodName)
	return self[foodName]
end

function Food:getAll()
	local all = {}
	for i, v in self do
		if typeof(v) == "table" then
			all[i] = v
		end
	end
	return all
end

return Food
