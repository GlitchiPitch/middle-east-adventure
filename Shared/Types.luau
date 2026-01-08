---@class damageData
---@field isCrit boolean
---@field value number

---@class itemData
---@field name string
---@field data table

---@class statsData
---@field health number
---@field mana number
---@field stamina number

---@class eventData
---@field eventName string
---@field data table

---@alias playerStateEnum '"Loot"' | '"Weapon"' | '"NPC"'

local DAMAGE_TYPE = {
	HIT = "Hit",
	BLADE = "Blade",
}

-- permament values (max hp eg.)
local PLAYER_ATTRIBUTES = {
	STRENGTH = "strength",
	DEXTERITY = "dexterity",
	ANCHIENT_KNOWLADGE = "ancientKnowladge",
	BLACKSMITH = "blacksmith",
	THIEF = "thief",
	ALCHEMY = "alchemy",
	HEALTH = "health",
	STAMINA = "stamina",
	MANA = "mana",
}

-- temp stats of player
local STATS = {
	WEAK = "weak",
	POSIONED = "posioned",
	FROSTED = "frosted",
	FIRED = "fired",
	HEALTH = "health",
	STAMINA = "stamina",
	MANA = "mana",
}

local SKILLS = {
	COMBAT = {
		SWORD_FIGHTER = "Sword Fighter",
		SWORD_FIGHTER_2 = "Sword Fighter 2",
		SWORD_FIGHTER_3 = "Sword Fighter 3",
		HEAVY_WEAPON = "Heavy Weapon",
		HEAVY_WEAPON_2 = "Heavy Weapon 2",
		HEAVY_WEAPON_3 = "Heavy Weapon 3",
		BOWMAN = "Bowman",
		BOWMAN_2 = "Bowman 2",
		BOWMAN_3 = "Bowman 3",
		RECOVERY = "Recovery",
	},
	MAGIC = {
		BLACK_MAGICIAN = "Black magician",
		STAFF_FIGHT = "Staff Fight",
		FIRE_MAGICIAN = "Fire magician",
	},
	HUNTING = {
		GAME_HUNTER = "GameHunter",
		GAME_HUNTER2 = "GameHunter2",
		SILENT_HUNTER = "SilentHunter",
		EXTRACTION = "Extraction",
		ANIMAL_SKINNING = "AnimalSkinning",
	},
	THIEF = {
		Breaking_Simple_Lock = "BreakingSimpleLock",
		Breaking_Complex_Lock = "BreakingComplexLock",
		Breaking_Impossible_Lock = "BreakingImpossibleLock",
	},
	ALCHEMY = {
		BREWING_HEALING_POTION = "BrewingHealingPotion",
		BREWING_MANA_POTION = "BrewingManaPotions",
		LONG_POTION = "LongPotions",
		TRANSMUTATION_POTION = "TransmutationPotions",
		MAKING_POISON = "MakingPoison",
		ELEMENTAL_BLADES = "ElementalBlades",
		ELEMENTAL_ARROWS = "ElementalArrows",
	},
	MISC = {
		ACROBATICS = "Acrobatics",
		WOLF_ENDURANCE = "WolfEndurance",
		FIRE_RESISTANCE = "FireResistance",
		WEAKNESS_RESISTANCE = "WeaknessResistance",
		POSION_RESISTANCE = "PosionResistance",
	},
	SMITH = {
		BLACKSMITH = "Blacksmith",
		FORGING_ORE_WEAPONS = "ForgingOreWeapons",
		FORGING_FROM_PURE_ORE = "ForgingFromPureOre",
		ORE_MINING = "OreMining",
		BLADE_SHARPENING = "BladeSharpening",
		ARMOR_ENCHANCEMENT = "ArmorEnchancement",
	}
}

local DEFENCES = {
	BLADE = "Blade Defense",
	STRIKE = "Strike Defense",
	ARROW = "Arrow Defense",
}

local BOOSTS = {
	ORC_SLAYER = "Orc Slayer",
}

local ITEMS = {
	
}

return {
	DAMAGE_TYPE = DAMAGE_TYPE,
	PLAYER_ATTRIBUTES = PLAYER_ATTRIBUTES,
	SKILLS = SKILLS,
	DEFENCES = DEFENCES,
	BOOSTS = BOOSTS,
	STATS = STATS,
	ITEMS = ITEMS,
}
