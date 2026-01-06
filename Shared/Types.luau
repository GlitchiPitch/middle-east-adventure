---@class damageData
---@field isCrit boolean
---@field value number

---@class itemData
---@field name string
---@field data table

---@class eventData
---@field eventName string
---@field data table

local DAMAGE_TYPE = {
	HIT = "Hit",
	BLADE = "Blade",
}

local PLAYER_ATTRIBUTES = {
	STRENGTH = "Strength",
	DEXTERITY = "Dexterity",
	ANCHIENT_KNOWLADGE = "AncientKnowladge",
	BLACKSMITH = "Blacksmith",
	THIEF = "Thief",
	ALCHEMY = "Alchemy",
	HEALTH = "Health",
	STAMINA = "Stamina",
	MANA = "Mana",
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
}

local DEFENCES = {
	BLADE = "Blade Defense",
	STRIKE = "Strike Defense",
	ARROW = "Arrow Defense",
}

local BOOSTS = {
	ORC_SLAYER = "Orc Slayer",
}

return {
	DAMAGE_TYPE = DAMAGE_TYPE,
	PLAYER_ATTRIBUTES = PLAYER_ATTRIBUTES,
	SKILLS = SKILLS,
	DEFENCES = DEFENCES,
	BOOSTS = BOOSTS,
}
