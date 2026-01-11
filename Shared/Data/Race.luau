local Race = {
	Human = {
		name = "Human",
		rarity = "Common",
		dropChance = 25,
		traits = {
			"Blessed: +3% Luck and +3% Experience",
		},
		description = "Balanced start",
	},

	Elf = {
		name = "Elf",
		rarity = "Uncommon",
		dropChance = 14,
		traits = {
			"Glorious: +7% Luck",
			"Superior Genes: +15% Stamina and +5% Height",
		},
		description = "Agile and mobility-focused",
	},

	Zombie = {
		name = "Zombie",
		rarity = "Uncommon",
		dropChance = 13.75,
		traits = {
			"Mutated Genes: +2% Health Regeneration every 5 seconds",
			"Rotten: -25% Max Health",
			"Absorb: 15% chance to convert incoming damage to health",
		},
		description = "Sustain-focused race",
	},

	Goblin = {
		name = "Goblin",
		rarity = "Rare",
		dropChance = 10.4,
		traits = {
			"Sneaky: +15% Movement Speed and +10% Dagger Attack Speed",
			"Tiny: -15% Health and -15% Size",
			"Bargain: +12% Discount when shopping",
		},
		description = "Fast, stealthy, good for daggers",
	},

	Undead = {
		name = "Undead",
		rarity = "Rare",
		dropChance = 9,
		traits = {
			"Second Chance: Refills 50% HP when dropping below 10% HP (5 min cooldown)",
			"Fragile Bones: -12% Health",
			"Sharp Surface: Reflects 10% incoming damage",
		},
		description = "High sustain with drawbacks",
	},

	Orc = {
		name = "Orc",
		rarity = "Rare",
		dropChance = 8,
		traits = {
			"Muscular: +10% Physical Damage, +15% Health, +10% Size",
			"Heavy: -10% Stamina and -10% Movement Speed",
		},
		description = "Ideal for melee builds",
	},

	Dwarf = {
		name = "Dwarf",
		rarity = "Epic",
		dropChance = 5,
		traits = {
			"Gifted Miner: +15% Mining and +5% Forging",
			"Critical Mining: +20% chance to deal +50% extra damage to rocks",
			"Heavy Short: -20% Height and -5% Movement Speed",
		},
		description = "Best for gathering/crafting, can also help squishing into small spaces",
	},

	Shadow = {
		name = "Shadow",
		rarity = "Epic",
		dropChance = 5,
		traits = {
			"Phantom Step: 15% chance to transform into a shadow and dodge an attack",
			"Shadow Pact: +10% Attack Speed, +15% Movement Speed, +5% Physical Damage, +10% Stamina, -10% Health",
		},
		description = "High agility and evasion",
	},

	Vampire = {
		name = "Vampire",
		rarity = "Epic",
		dropChance = 4,
		traits = {
			"Bloodthirst: +15% Life Steal",
			"Blade Adept: +10% Damage Boost with Straight Swords",
		},
		description = "Ideal for straight swords and increased survivability",
	},

	Minotaur = {
		name = "Minotaur",
		rarity = "Legendary",
		dropChance = 1.75,
		traits = {
			"Bull's Fury: Going below 50% HP triggers Rage Mode (+30% Speed & +30% Physical Damage)",
			"Beast: +10% Height, +20% Health, -10% Stamina, -10% Movement Speed, +20% Width & Depth",
		},
		description = "Tanky melee powerhouse",
	},

	Dragonborn = {
		name = "Dragonborn",
		rarity = "Legendary",
		dropChance = 1.25,
		traits = {
			"Sharp Fangs: +12% Physical Damage",
			"Dragon's Breath: 40% chance to burn enemies for 30% weapon damage/second for 3 seconds",
			"Durable Scales: +20% Max Health and +10% Height",
		},
		description = "Strong all-around attacker",
	},

	Golem = {
		name = "Golem",
		rarity = "Legendary",
		dropChance = 1.25,
		traits = {
			"Heavy Hitter: +15% Attack Speed for heavy weapons",
			"Tank: +30% Health & Size, -10% Movement Speed",
			"Stone Heart: 50% chance to reduce incoming damage by 25%",
		},
		description = "Extremely tanky",
	},

	Felynx = {
		name = "Felynx",
		rarity = "Legendary",
		dropChance = 1.25,
		traits = {
			"Lightfooted: +25% Stamina Boost, +20% Movement Speed, -20% Dash Cooldown, +20% Dash Distance",
			"Cat Reflexes: 20% chance to parry the next attack",
			"Clawed Grip: +20% Attack Speed/Damage with Gauntlets",
		},
		description = "Agile and reflexive fighter",
	},

	Angel = {
		name = "Angel",
		rarity = "Mythical",
		dropChance = 0.5,
		traits = {
			"Holy Hand: Below 20% HP, gain infinite Stamina",
			"Wings: +50% Dash Distance, +15% iFrames, +20% Speed, +25% Jump Boost, +20% Stamina, -20% Dash Cooldown",
			"Smite: 50% chance to deal 30% Physical Damage on-hit",
			"Mighty Clover: +30% Luck",
		},
		description = "High mobility & utility",
	},

	Demon = {
		name = "Demon",
		rarity = "Mythical",
		dropChance = 0.5,
		traits = {
			"Devil Finger: Dashing teleports you & has 20% chance to create Hellfire Circle dealing 45% weapon damage/second for 3 sec",
			"Demonic Powers: +20% Speed, +20% Attack Speed, +20% Fire Damage, +30% Height, +10% Width/Depth, +20% Physical Damage",
			"Cursed Aura: Deals 10% weapon damage/second during combat",
			"Backfire: 25% chance to burn enemies when hit",
		},
		description = "High damage and AoE pressure",
	},
}

return Race
