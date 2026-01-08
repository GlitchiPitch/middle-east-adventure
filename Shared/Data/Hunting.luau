---@class Hunting
local Hunting = {
	GameHunter = {
		name = "Game hunter",
		requirement = {
			dexterity = 125,
			exp = 5,
		},
		price = 1500,
		bonus = {
			effect = "double damage to small animals",
		},
	},
	GameHunter2 = {
		name = "Game hunter 2",
		requirement = {
			dexterity = 175,
			exp = 15,
			previous = "Game hunter",
		},
		price = 2500,
		bonus = {
			effect = "double damage to all animals",
		},
	},
	SilentHunter = {
		name = "Silent hunter",
		requirement = {
			dexterity = 115,
			exp = 5,
		},
		price = 1000,
		bonus = {
			effect = "animals don't run away from hero",
		},
	},
	Extraction = {
		name = "Extraction of teeth, claws and horns",
		requirement = {
			dexterity = 110,
			exp = 10,
		},
		price = 500,
		bonus = {
			effect = "can get drop",
		},
	},
	AnimalSkinning = {
		name = "Animal skinning",
		requirement = {
			agility = 125,
			exp = 5,
		},
		price = 500,
		bonus = {},
	},
}

return Hunting