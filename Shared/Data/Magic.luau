local Types = require(script.Parent.Parent.Types)

-- local PLAYER_ATTRIBUTES = Types.PLAYER_ATTRIBUTES
-- local DAMAGE_TYPE = Types.DAMAGE_TYPE
-- local SKILLS = Types.SKILLS
-- local BOOSTS = Types.BOOSTS
-- local DEFENCES = Types.DEFENCES

local HolyMagic = {

	Light = {
		Name = "Light",
		Action = "A sphere appears above the hero's head, illuminating the surrounding area.",
	},

	TreatmentOfWeakening = {
		Name = "Treatment of weakening",
		Action = "Heals the mage from debuffs.",
	},

	TreatmentOfPoisoning = {
		Name = "Treatment of poisoning",
		Action = "Cures the mage from poisoning.",
	},

	Healing = {
		Name = "Healing",
		Action = "Restores 100% of the Nameless One's Life Energy",
	},

	HealingAnother = {
		Name = "Healing another",
		Action = "Fully heals the target.",
	},

	FlamingSword = {
		Name = "Flaming Sword",
		Action = "Summons a Flaming Sword that will not disappear until sheathed.",
	},

	Fireball = {
		Name = "Fireball",
		Action = "Hurls a fireball at an enemy, dealing damage. When casting a charged spell, the sphere follows the enemy.",
	},
	WaveOfFlame = {
		Name = "Wave of Flame",
		Action = "Fire circles are emitted around the mage, dealing damage to enemies.",
	},
	BanishingEvil = {
		Name = "Banishing Evil",
		Action = "Deals heavy damage to undead and demons.",
	},

	FireRain = {
		Name = "Fire rain",
		Action = "Sends out a rain of fire that deals heavy damage to the surrounding area.",
	},
	BlessingOfWeapons = {
		Name = "Blessing of weapons",
		Action = "Transforms the selected weapon into a blessed version that deals 10 more damage.",
	},
	Meteor = {
		Name = "Meteor",
		Action = "A meteor that deals heavy area damage falls on the target.",
	},

	WordOfDominion = {
		Name = "Word of dominion",
		Action = "The spell's target is subordinate to the Nameless Hero.",
	},
}

local Wandlungsmagie = {
	SummoningAnimals = {
		Name = "Summoning animals",
		Action = "All animals in the area will attack the spell's target.",
	},
	Telekinesis = {
		Name = "Telekinesis",
		Action = "The target item flies towards the mage.",
	},
	Taming = {
		Name = "Taming",
		Action = "The said animal is under the control of the magician.",
	},
	SummonGoblin = {
		Name = "Summon Goblin",
		Action = "Summons a goblin that obeys the wizard.",
	},
	IceSpear = {
		Name = "Ice Spear",
		Action = "The mage fires an icy projectile from his hand, freezing it for a few seconds upon impact.",
	},
	AnimalAppearance = {
		Name = "Animal appearance",
		Action = "The hero transforms into the target animal.",
	},
	Dream = {
		Name = "Dream",
		Action = "Puts the target to sleep for a certain amount of time.",
	},
	ColdWave = {
		Name = "Cold wave",
		Action = "Waves of ice emanate from the wizard's body, damaging enemies around him.",
	},
	IceBlast = {
		Name = "Ice Blast",
		Action = "Ice spikes form around the mage, dealing damage to surrounding enemies in the area of effect.",
	},
	SummonGolem = {
		Name = "Summon Golem",
		Action = "Summons a Stone Golem that obeys the wizard.",
	},
	LockPicking = {
		Name = "Lock picking",
		Action = "Unlocks a locked lock.",
	},
	TimeBubble = {
		Name = "Time bubble",
		Action = "A round sphere forms around the magician, inside which time flows more slowly.",
	},
	Storm = {
		Name = "Storm",
		Action = "Lightning strikes around the mage, damaging everyone around him.",
	},
}

local DarkMagic = {
	Weakening = {
		Name = "Weakening",
		Action = "The target of the spell deals less damage and cannot completely block attacks.",
	},
	Poison = {
		Name = "Poison",
		Action = "Poisons the target of the spell.",
	},
	LightningDischarge = {
		Name = "Lightning discharge",
		Action = "The mage's hand releases a bolt of energy, dealing damage to the target.",
	},
	Fog = {
		Name = "Fog",
		Action = "A cloud of black fog appears around the mage, blocking the visibility of enemies.",
	},
	Horror = {
		Name = "Horror",
		Action = "The target of the spell runs away from the magician in panic.",
	},
	Bloodlust = {
		Name = "Bloodlust",
		Action = "A person affected by the spell attacks the nearest character.",
	},
	Oblivion = {
		Name = "Oblivion",
		Action = "The target of the spell forgets the crimes of the Nameless One.",
	},
	SummonSkeleton = {
		Name = "Summon Skeleton",
		Action = "Summons a skeleton that obeys the mage.",
	},
	FromNightToDay = {
		Name = "From night to day",
		Action = "Speeds up time to 8:00 AM the next day, restoring vitality, stamina, and mana. Only works at night.",
	},
	SummonDemon = {
		Name = "Summoning a Demon",
		Action = "Summons a demon that obeys the wizard.",
	},
	SummonLightning = {
		Name = "Summon Lightning",
		Action = "Lightning strikes the target, dealing heavy area damage.",
	},
	JourneyOfTheSoul = {
		Name = "Journey of the Soul",
		Action = "The magician turns into a spirit, invisible to others.",
	},
	ArmyOfDarkness = {
		Name = "Army of Darkness",
		Action = "Summons an army of 6 to 10 undead.",
	},
}

---@class Magic
local Magic = {
	HolyMagic = HolyMagic,
	Wandlungsmagie = Wandlungsmagie,
	DarkMagic = DarkMagic,
}

local _allMagic = {}

for _, v in Magic do
	for j, k in v do
		_allMagic[j] = k
	end
end

---@param magicName string
---@return table
function Magic:getMagicData(magicName)
	return _allMagic[magicName]
end

return Magic
