local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Types = require(ReplicatedStorage.Shared.Types)
local Weapons = require(ReplicatedStorage.Shared.Assets).Weapons

local PLAYER_ATTRIBUTES = Types.PLAYER_ATTRIBUTES
local DAMAGE_TYPE = Types.DAMAGE_TYPE
local SKILLS = Types.SKILLS
local BOOSTS = Types.BOOSTS
local DEFENCES = Types.DEFENCES

local OneHanded = {

	Club = {
		name = "Club",
		image = "rbxassetid://108752402225500",
		model = Weapons.OneHanded.Club,
		damage = 15,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 10,
		},
		bonus = {},
		damageType = DAMAGE_TYPE.HIT,
		price = 10,
	},

	RustySword = {
		name = "Rusty Sword",
		image = "rbxassetid://107028418502150",
		model = Weapons.OneHanded.RustySword,
		damage = 30,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 60,
			skills = {
				SKILLS.COMBAT.SWORD_FIGHTER,
			},
		},
		bonus = {},
		damageType = DAMAGE_TYPE.BLADE,
		price = 30,
	},

	AssassinDagger = {
		name = "Assassin's dagger",
		image = "rbxassetid://78093264551473",
		model = Weapons.OneHanded.AssassinDagger,
		damage = 45,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 90,
			skills = {
				SKILLS.COMBAT.SWORD_FIGHTER,
			},
		},
		bonus = {},
		damageType = DAMAGE_TYPE.BLADE,
		price = 350,
	},

	Sword = {
		name = "Sword",
		image = "rbxassetid://76626568418896",
		model = Weapons.OneHanded.Sword,
		damage = 50,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 100,
			skills = {
				SKILLS.COMBAT.SWORD_FIGHTER,
			},
		},
		bonus = {},
		damageType = DAMAGE_TYPE.BLADE,
		price = 50,
	},

	OrcSlayer = {
		name = "Orc Slayer",
		image = "rbxassetid://127955169217687",
		model = Weapons.OneHanded.OrcSlayer,
		damage = 50,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 100,
			skills = {
				SKILLS.COMBAT.SWORD_FIGHTER,
			},
		},
		bonus = {
			BOOSTS.ORC_SLAYER,
		},
		damageType = DAMAGE_TYPE.BLADE,
		price = 600,
	},

	Rapier = {
		name = "Rapier",
		image = "rbxassetid://87477214213303",
		model = Weapons.OneHanded.Rapier,
		damage = 60,
		requirement = {
			[PLAYER_ATTRIBUTES.DEXTERITY] = 120,
			skills = {
				SKILLS.COMBAT.SWORD_FIGHTER,
			},
		},
		bonus = {},
		damageType = DAMAGE_TYPE.BLADE,
		price = 800,
	},

	AssassinSword = {
		name = "Assassin's Sword",
		image = "rbxassetid://72367834015165",
		model = Weapons.OneHanded.AssassinSword,
		damage = 70,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 140,
			skills = {
				SKILLS.COMBAT.SWORD_FIGHTER,
			},
		},
		bonus = {},
		damageType = DAMAGE_TYPE.BLADE,
		price = 1250,
	},

	PaladinSword = {
		name = "Paladin's Sword",
		image = "rbxassetid://100950798211589",
		model = Weapons.OneHanded.PaladinSword,
		damage = 80,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 160,
			skills = {
				SKILLS.COMBAT.SWORD_FIGHTER,
			},
		},
		bonus = {},
		damageType = DAMAGE_TYPE.BLADE,
		price = 8000,
	},

	BarbariansSword = {
		name = "Barbarians Sword",
		image = "rbxassetid://96117934197882",
		model = Weapons.OneHanded.BarbariansSword,
		damage = 85,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 170,
			skills = {
				SKILLS.COMBAT.SWORD_FIGHTER,
			},
		},
		bonus = {},
		damageType = DAMAGE_TYPE.BLADE,
		price = 12000,
	},

	MasterSword = {
		name = "Master's Sword",
		damage = 105,
		model = Weapons.OneHanded.MasterSword,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 210,
			skills = {
				SKILLS.COMBAT.SWORD_FIGHTER_2,
			},
		},
		bonus = {},
		damageType = DAMAGE_TYPE.BLADE,
		price = 30000,
		image = "",
	},

	GreatSword = {
		name = "Great Sword",
		image = "rbxassetid://123341776606746",
		model = Weapons.OneHanded.GreatSword,
		damage = 110,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 220,
			skills = {
				SKILLS.COMBAT.SWORD_FIGHTER_2,
			},
		},
		bonus = {},
		damageType = DAMAGE_TYPE.BLADE,
		price = 30000,
	},
}

local TwoHanded = {
	BarbedClub = {
		name = "Barbed club",
		image = "rbxassetid://76964882407852",
		model = Weapons.TwoHanded.BarbedClub,
		damage = 65,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 130,
			skills = {
				SKILLS.COMBAT.HEAVY_WEAPON,
			},
		},
		damageType = DAMAGE_TYPE.HIT,
		price = 100,
	},

	Halberd = {
		name = "Halberd",
		image = "rbxassetid://133879961363701",
		model = Weapons.TwoHanded.Halberd,
		damage = 70,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 140,
			skills = {
				SKILLS.COMBAT.HEAVY_WEAPON,
			},
		},
		damageType = DAMAGE_TYPE.BLADE,
		price = 700,
	},

	JaggedAxe = {
		name = "Jagged Axe",
		image = "rbxassetid://116080448306548",
		model = Weapons.TwoHanded.JaggedAxe,
		damage = 80,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 160,
			skills = {
				SKILLS.COMBAT.HEAVY_WEAPON,
			},
		},
		damageType = DAMAGE_TYPE.BLADE,
		price = 7000,
	},

	Cleaver = {
		name = "Cleaver",
		image = "rbxassetid://83981418299449",
		model = Weapons.TwoHanded.Cleaver,
		damage = 85,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 170,
			skills = {
				SKILLS.COMBAT.HEAVY_WEAPON_2,
			},
		},
		damageType = DAMAGE_TYPE.BLADE,
		price = 10000,
	},

	ExecutionersSword = {
		name = "Executioner's Sword",
		image = "rbxassetid://131212985092577",
		model = Weapons.TwoHanded.ExecutionersSword,
		damage = 110,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 220,
			skills = {
				SKILLS.COMBAT.HEAVY_WEAPON_2,
			},
		},
		damageType = DAMAGE_TYPE.BLADE,
		price = 30000,
	},

	WarHammer = {
		name = "War Hammer",
		image = "rbxassetid://131910227086206",
		model = Weapons.TwoHanded.WarHammer,
		damage = 120,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 240,
			skills = {
				SKILLS.COMBAT.HEAVY_WEAPON_2,
			},
		},
		damageType = DAMAGE_TYPE.HIT,
		price = 15000,
	},

	DemonSword = {
		name = "Demon Sword",
		damage = 135,
		model = Weapons.TwoHanded.DemonSword,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 666,
			skills = {
				SKILLS.COMBAT.HEAVY_WEAPON_3,
			},
		},
		bonus = {
			Mana = 25,
			[DEFENCES.BLADE] = 8,
			[DEFENCES.STRIKE] = 8,
			[DEFENCES.ARROW] = 8,
		},
		damageType = DAMAGE_TYPE.BLADE,
		price = 1,
	},

	JudgesStaff = {
		name = "Judge's Staff",
		damage = 80,
		model = Weapons.TwoHanded.JudgesStaff,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 160,
			skills = {
				SKILLS.MAGIC.STAFF_FIGHT,
			},
		},
		damageType = DAMAGE_TYPE.BLADE,
		price = 2000,
	},

	StaffOfWitchcraft = {
		name = "Witchcraft Staff",
		damage = 20,
		model = Weapons.TwoHanded.StaffOfWitchcraft,
		requirement = {
			[PLAYER_ATTRIBUTES.ANCHIENT_KNOWLADGE] = 50,
			skills = {
				SKILLS.MAGIC.STAFF_FIGHT,
			},
		},
		bonus = {
			Mana = 25,
		},
		damageType = DAMAGE_TYPE.HIT,
		price = 4000,
	},

	WaterStaff = {
		name = "Water Staff",
		damage = 25,
		model = Weapons.TwoHanded.WaterStaff,
		requirement = {
			[PLAYER_ATTRIBUTES.ANCHIENT_KNOWLADGE] = 80,
			skills = {
				SKILLS.MAGIC.STAFF_FIGHT,
			},
		},
		bonus = {
			SKILLS.MAGIC.FIRE_MAGICIAN,
		},
		damageType = DAMAGE_TYPE.HIT,
		price = 15000,
	},

	StaffOfFire = {
		name = "Staff of Fire",
		image = "rbxassetid://83736608003641",
		model = Weapons.TwoHanded.StaffOfFire,
		damage = 25,
		requirement = {
			[PLAYER_ATTRIBUTES.ANCHIENT_KNOWLADGE] = 50,
			skills = {
				SKILLS.MAGIC.STAFF_FIGHT,
			},
		},
		bonus = {
			SKILLS.MAGIC.FIRE_MAGICIAN,
		},
		damageType = DAMAGE_TYPE.HIT,
		price = 15000,
	},

	StaffOfDarkness = {
		name = "Staff of Darkness",

		model = Weapons.TwoHanded.StaffOfDarkness,
		damage = 25,
		requirement = {
			[PLAYER_ATTRIBUTES.ANCHIENT_KNOWLADGE] = 80,
			skills = {
				SKILLS.MAGIC.STAFF_FIGHT,
			},
		},
		bonus = {
			SKILLS.MAGIC.BLACK_MAGICIAN,
		},
		damageType = DAMAGE_TYPE.HIT,
		price = 15000,
	},

	Mace = {
		name = "Mace",
		image = "rbxassetid://127068311362312",
		model = Weapons.TwoHanded.Mace,
		damage = 259,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 250,
			skills = {
				SKILLS.COMBAT.HEAVY_WEAPON_3,
			},
		},
		bonus = {},
		damageType = DAMAGE_TYPE.HIT,
		price = 15000,
	},
}

local Bows = {}
local Crossbows = {}

---@class Weapon
local Weapon = {
	OneHanded = OneHanded,
	TwoHanded = TwoHanded,
	Bows = Bows,
	Crossbows = Crossbows,
}

---@param weaponName string
---@return table
function Weapon:getWeaponData(weaponName)
	local oneHanded = self.OneHanded[weaponName]
	if oneHanded then
		return oneHanded, "OneHanded"
	end
	local twoHanded = self.TwoHanded[weaponName]
	if twoHanded then
		return twoHanded, "TwoHanded"
	end
	local bow = self.Bows[weaponName]
	if bow then
		return bow, "Bow"
	end

	local crossbow = self.Crossbows[weaponName]
	if crossbow then
		return crossbow, "Crossbow"
	end

	return
end

return Weapon
