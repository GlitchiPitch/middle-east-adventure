---@class Alchemy
local Alchemy = {
	BrewingHealingPotion = {
		name = "Brewing Healing Potion",
		requirement = {
			skill = "Start Skill - Brew Healing Potions",
		},
		price = 0,
		bonus = {},
	},
	BrewingManaPotions = {
		name = "Brewing Mana Potions",
		requirement = {
			alchemySkill = 20,
			exp = 5,
			previous = "Brewing Healing Potion",
		},
		price = 1000,
		bonus = {
			produce = "Brew Mana Potions",
		},
	},
	LongPotions = {
		name = "Long Potions",
		requirement = {
			alchemySkill = 60,
			exp = 8,
			previous = "Transmutation Potions",
		},
		price = 2500,
		bonus = {},
	},
	TransmutationPotions = {
		name = "Transmutation Potions",
		requirement = {
			alchemySkill = 60,
			exp = 5,
		},
		price = 5000,
		bonus = {},
	},
	MakingPoison = {
		name = "Making Poison",
		requirement = {
			alchemySkill = 20,
			exp = 5,
		},
		price = 1000,
		bonus = {},
	},
	ElementalBlades = {
		name = "Poisoned, Fire, Frost Blades",
		requirement = {
			alchemySkill = 60,
			exp = 25,
		},
		price = 2500,
		bonus = {
			types = {"Poisoned Blade", "Fire Blade", "Frost Blade"},
		},
	},
	ElementalArrows = {
		name = "Poisoned, Fire, Frost, Explosive Arrows",
		requirement = {
			alchemySkill = 60,
			exp = 25,
		},
		price = 2500,
		bonus = {
			types = {"Poisoned Arrow", "Fire Arrow", "Frost Arrow", "Explosive Arrow"},
		},
	},
}

return Alchemy