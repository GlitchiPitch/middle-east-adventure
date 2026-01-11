local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Skills = require(ReplicatedStorage.Shared.Data.Skills)
local Types = require(ReplicatedStorage.Shared.Types)
local Resource = require(script.Parent.Resource)

local Potion = {
	PotionOfStamina = {
		name = "Potion of Stamina",
		image = "rbxassetid://72397722291409",
		requirements = {
			Skills.Alchemy.BrewingHealingPotion.name,
		},
		effects = {
			stats = {
				[Types.STATS.STAMINA] = 100, -- restore
			},
		},
		cost = 100,
		recipes = {
			{ Schnapps = 1, [Resource.Herbs.Ogroleaf.name] = 1, Vessel = 1 },
			{ Schnapps = 1, CastIronRoot = 3, Vessel = 1 },
		},
	},

	Antidote = {
		name = "Antidote",
		requirements = {
			"Brewing healing potions",
		},
		effects = {
			stats = {
				[Types.STATS.POSIONED] = false, -- cure
				[Types.STATS.MANA] = -50,
			},
		},
		cost = 200,
		recipes = {
			{ HealingPotion = 1, Poison = 1, [Resource.Mushrooms.ToadMush.name] = 1, Vessel = 1 },
		},
	},

	Poison = {
		name = "Poison",
		requirements = {
			"Making poison",
		},
		effects = {},
		cost = 400,
		recipes = {
			{ PoisonBubble = 1, Vessel = 1 },
			{ MonitorTongue = 5, Vessel = 1 },
			{ HornetSting = 10, Vessel = 1 },
		},
	},

	HealingPotion = {
		name = "Healing Potion",
		requirements = {
			"Brewing healing potions",
		},
		effects = {
			stats = {
				[Types.STATS.HEALTH] = 50, -- percentage restore
			},
		},
		cost = 250,
		recipes = {
			{ Water = 1, HealingHerb = 1, Vessel = 1 },
			{ Water = 1, Sungazer = 3, Vessel = 1 },
			{ Water = 1, MedicinalRoot = 5, Vessel = 1 },
			{ Water = 1, WildBerry = 8, Vessel = 1 },
		},
	},

	ManaPotion = {
		name = "Mana Potion",
		requirements = {
			"Brewing Mana Potions",
		},
		effects = {
			stats = {
				[Types.STATS.MANA] = 50, -- percentage restore
			},
		},
		cost = 250,
		recipes = {
			{ Wine = 1, ManaPlant = 1, Vessel = 1 },
			{ Wine = 1, FireNettle = 3, Vessel = 1 },
			{ Wine = 1, MagicRoot = 5, Vessel = 1 },
			{ Wine = 1, MorningDew = 8, Vessel = 1 },
		},
	},

	StrengtheningPotion = {
		name = "Strengthening Potion",
		requirements = {
			"Brewing healing potions",
		},
		effects = {
			stats = {
				[Types.STATS.WEAK] = false, -- cure weakness
				[Types.STATS.MANA] = -20,
			},
		},
		cost = 200,
		recipes = {
			{ HealingPotion = 1, [Resource.Mushrooms.HellMushroom.name] = 2, Vessel = 1 },
		},
	},

	LongStaminaPotion = {
		name = "Potion of Stamina (Long-lasting)",
		requirements = {
			"Long-lasting potion",
		},
		effects = {
			stats = {
				[Types.STATS.STAMINA] = 4, -- permanent boost
			},
		},
		cost = 500,
		recipes = {
			{ [Resource.Herbs.GuardGrass.name] = 1, RoyalSorrel = 1, Vessel = 1 },
		},
	},

	PotionOfAgility = {
		name = "Potion of Agility",
		requirements = {
			"Long-lasting potion",
		},
		effects = {
			stats = {
				[Types.STATS.HEALTH] = 2, -- dexterity +2, using health as placeholder
			},
		},
		cost = 800,
		recipes = {
			{ GoblinBerry = 1, RoyalSorrel = 1, Vessel = 1 },
		},
	},

	PotionOfConcentration = {
		name = "Potion of Concentration",
		requirements = {
			"Long-lasting potion",
		},
		effects = {
			stats = {
				[Types.STATS.MANA] = 4, -- permanent boost
			},
		},
		cost = 600,
		recipes = {
			{ Flamenica = 1, RoyalSorrel = 1, Vessel = 1 },
		},
	},

	PotionOfVitality = {
		name = "Potion of Vitality",
		requirements = {
			"Long-lasting potion",
		},
		effects = {
			stats = {
				[Types.STATS.HEALTH] = 4, -- permanent boost
			},
		},
		cost = 600,
		recipes = {
			{ Vlastotsvet = 1, RoyalSorrel = 1, Vessel = 1 },
		},
	},

	PotionOfStrength = {
		name = "Potion of Strength",
		requirements = {
			"Long-lasting potion",
		},
		effects = {
			stats = {
				[Types.STATS.STAMINA] = 2, -- strength +2, using stamina as placeholder
			},
		},
		cost = 800,
		recipes = {
			-- Recipe not given in instructions, fill when known
		},
	},

	BisonTransformationPotion = {
		name = "Bison Transformation Potion",
		requirements = {
			"Brewing Transmutation Potions",
		},
		effects = {
			"Transform into a Bison",
			"-30 Mana",
		},
		cost = 450,
		recipes = {
			{ BisonHorn = 1, [Resource.Mushrooms.StrangeMushroom.name] = 1, Vessel = 1 },
		},
	},

	HornetTransformationPotion = {
		name = "Hornet Transformation Potion",
		requirements = {
			"Brewing Transmutation Potions",
		},
		effects = {
			"Hornet Transformation",
			"-30 Mana",
		},
		cost = 450,
		recipes = {
			{ HornetSting = 1, [Resource.Mushrooms.StrangeMushroom.name] = 1, Vessel = 1 },
		},
	},

	MeatbugTransformationPotion = {
		name = "Meatbug Transformation Potion",
		requirements = {
			"Brewing Transmutation Potions",
		},
		effects = {
			"Transforms into a meat bug",
			"-30 mana",
		},
		cost = 450,
		recipes = {
			{ RawMeatBeetle = 1, [Resource.Mushrooms.StrangeMushroom.name] = 1, Vessel = 1 },
		},
	},

	CreeperTransformationPotion = {
		name = "Potion of Transformation into a Creeper",
		requirements = {
			"Brewing Transmutation Potions",
		},
		effects = {
			"Transforms into a half-zun",
			"-30 mana",
		},
		cost = 450,
		recipes = {
			{ OrePiece = 1, CreeperMandible = 1, [Resource.Mushrooms.StrangeMushroom.name] = 1, Vessel = 1 },
		},
	},

	ScavengerTransformationPotion = {
		name = "Scavenger Transformation Potion",
		requirements = {
			"Brewing Transmutation Potions",
		},
		effects = {
			"Transforms into a scavenger",
			"-30 mana",
		},
		cost = 450,
		recipes = {
			{ ScavengerEgg = 1, [Resource.Mushrooms.StrangeMushroom.name] = 1, Vessel = 1 },
		},
	},

	DarklingTransformationPotion = {
		name = "Darkling Transformation Potion",
		requirements = {
			"Brewing Transmutation Potions",
		},
		effects = {
			"Transforms into a Darkling",
			"-30 mana",
		},
		cost = 450,
		recipes = {
			{ ManaPotion = 1, DarklingHorn = 1, [Resource.Mushrooms.StrangeMushroom.name] = 1, Vessel = 1 },
		},
	},

	GlorchTransformationPotion = {
		name = "Glorch Transformation Potion",
		requirements = {
			"Brewing Transmutation Potions",
		},
		effects = {
			"Transforms into a Glorkh",
			"-30 mana",
		},
		cost = 450,
		recipes = {
			{ StaminaPotion = 1, GlorchGrass = 1, [Resource.Mushrooms.StrangeMushroom.name] = 1, Vessel = 1 },
		},
	},
}

---@param potionName string
function Potion:getPotionData(potionName)
	return self[potionName]
end

return Potion
