local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Types = require(ReplicatedStorage.Shared.Types)

local Mushrooms = {
	ToadMush = {
		name = "Toad Mush",
		effect = "Restores 5% stamina",
		cost = 10,
	},

	HellMushroom = {
		name = "Hell Mushroom",
		cost = 20,
	},
	StrangeMushroom = {
		name = "Strange Mushroom",
		cost = 40,
	},

	MorningDew = {
		name = "Morning dew",
		effect = "Restores 5% mana",
		cost = 5,
	},
}

local Herbs = {
	BloodCane = {
		name = "Blood cane",
		effect = "Restores 5% stamina",
		cost = 10,
	},
	DragonRoot = {
		name = "Dragon root",
		effect = "Strength +1",
		cost = 400,
	},
	CastIronRoot = {
		name = "Cast iron root",
		effect = "Restores 25% stamina",
		cost = 10,
	},
	StoneNettle = {
		name = "Stone nettle",
		cost = 10,
	},
	FireNettle = {
		name = "Fire nettle",
		effect = "Restores 10% mana",
		cost = 20,
	},
	Flamenica = {
		name = "Flamenica",
		effect = "Max Mana +2",
		cost = 200,
	},
	GoblinBerry = {
		name = "Goblin Berry",
		effect = "Dexterity +1",
		cost = 400,
	},
	GuardGrass = {
		name = "Guard grass",
		effect = "Maximum Stamina +2",
		cost = 200,
	},
	MedicinalHerb = {
		name = "Medicinal herb",
		effect = "Restores 25% of vital energy",
		cost = 40,
	},
	MedicinalRoot = {
		name = "Medicinal root",
		effect = "restores 7% of vital energy",
		cost = 10,
	},
	Vlastotsvet = {
		name = "Vlastotsvet",
		effect = "Maximum health +2",
		cost = 200,
	},
	CactusFlower = {
		name = "Cactus flower",
		effect = "Restores 8 stamina",
		cost = 8,
	},
	RoyalBurdock = {
		name = "Royal burdock",
		cost = 20,
	},
	RoyalSorrel = {
		name = "Royal Sorrel",
		effect = "Restores 5 health",
		cost = 500,
	},
	ManaPlant = {
		name = "Mana plant",
		effect = "Restores 25% of mana",
		cost = 80,
	},
	Ogroleaf = {
		name = "Ogroleaf",
		effect = "restores 50% stamina",
		cost = 20,
	},
	DrunkenBerry = {
		name = "Drunken berry",
		cost = 15,
	},
	GlorchGrass = {
		name = "Glorch grass",
		cost = 4,
	},

	Sungazer = {
		name = "Sungazer",
		effect = "Restores 10% of vital energy",
		cost = 20,
	},
	BushLobelia = {
		name = "Bush lobelia",
		cost = 20,
	},
	PricklyRuddySheath = {
		name = "Prickly ruddy sheath",
		cost = 10,
	},
	MarshGrass = {
		name = "Marsh grass",
		cost = 10,
	},
	WildBerry = {
		name = "Wild berry",
		effect = "Restores 5% of vital energy",
		cost = 5,
	},
	Lupus = {
		name = "Lupus",
		cost = 12,
	},
	MagicRoot = {
		name = "Magic root",
		effect = "Regenerates 7% of mana",
		cost = 10,
	},
}

local Misc = {
	BisonFur = {
		name = "Bison Fur",
		cost = 45,
	},
	BisonHorn = {
		name = "Bison Horn",
		cost = 150,
	},
	HornetSting = {
		name = "Hornet sting",
		cost = 100,
	},
	Claws = {
		name = "Claws",
		cost = 100,
	},
	Mandibles = {
		name = "Mandibles",
		cost = 150,
	},
	PoisonBladder = {
		name = "Poison Bladder",
		cost = 200,
	},
	ScavengerEgg = {
		name = "Scavenger Egg",
		cost = 6,
		effect = "Restores 5% health",
	},
	ShadowbeastFur = {
		name = "Shadowbeast Fur",
		cost = 200,
	},
	Teeth = {
		name = "Teeth",
		cost = 100,
	},
	AntiqueBox = {
		name = "Antique box",
	},
	WarriorStatue = {
		name = "Warrior Statue",
	},
	Cup = {
		name = "Cup",
	},
	JewelryBox = {
		name = "Jewelry Box",
		cost = 250,
	},
	GoldenCup = {
		name = "Golden Cup",
	},
	Gold = {
		name = "Gold",
		cost = 1,
	},
	GoldNugget = {
		name = "Gold Nugget",
		cost = 200,
	},
	Ore = {
		name = "Ore",
		cost = 80,
	},
	HammerSmith = {
		name = "Hammer Smith",
		cost = 40,
	},
	IronOre = {
		name = "Iron ore",
		cost = 40,
	},
	IronOreNugget = {
		name = "Iron Ore Nugget",
		cost = 250,
	},
	Lute = {
		name = "Lute",
		cost = 30,
	},
	Pickaxe = {
		name = "Pickaxe",
		cost = 80,
		requirements = {
			[Types.PLAYER_ATTRIBUTES.STRENGTH] = 100,
		},
		damage = 50,
	},
	PureMagicOreBlank = {
		name = "Pure magic ore blank",
	},
	Steel = {
		name = "Steel",
		cost = 180,
	},
	MagicOreBlank = {
		name = "Magic Ore blank",
		cost = 1000,
	},
	Torch = {
		name = "Torch",
		cost = 40,
	},
}

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
