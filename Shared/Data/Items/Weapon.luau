local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Types = require(ReplicatedStorage.Shared.Types)

local PLAYER_ATTRIBUTES = Types.PLAYER_ATTRIBUTES
local DAMAGE_TYPE = Types.DAMAGE_TYPE
local SKILLS = Types.SKILLS
local BOOSTS = Types.BOOSTS
local DEFENCES = Types.DEFENCES

local OneHanded = {

	Club = {
		name = "Club",
		damage = 15,
		requirement = {
			[PLAYER_ATTRIBUTES.STRENGTH] = 10,
		},
		bonus = {},
		damageType = DAMAGE_TYPE.HIT,
		price = 10,
		image = "",
	},

	RustySword = {
		name = "Rusty Sword",
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
		image = "",
	},

	AssassinDagger = {
		name = "Assassin's dagger",
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
		image = "",
	},

	Sword = {
		name = "Sword",
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
		image = "",
	},

	OrcSlayer = {
		name = "Orc Slayer",
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
		image = "",
	},

	Rapier = {
		name = "Rapier",
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
		image = "",
	},

	AssassinSword = {
		name = "Assassin's Sword",
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
		image = "",
	},

	PaladinSword = {
		name = "Paladin's Sword",
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
		image = "",
	},

	BarbariansSword = {
		name = "Barbarians Sword",
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
		image = "",
	},

	MasterSword = {
		name = "Master's Sword",
		damage = 105,
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
		image = "",
	},
}

local TwoHanded = {
	BarbedClub = {
		name = "Barbed club",
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
