---@class Smith
local Smith = {
    Blacksmith = {
        Name = "Blacksmith",
        Requirements = {
            -- start skill, no requirements
        },
        Price = 0,
        Bonus = "start skill",
    },
    ForgingOreWeapons = {
        Name = "Forging ore weapons",
        Requirements = {
            BlacksmithSkill = 30,
            Exp = 5,
        },
        Price = 2500,
        Bonus = "can make ore weapons",
    },
    ForgingFromPureOre = {
        Name = "Forging from pure ore",
        Requirements = {
            BlacksmithSkill = 80,
            Exp = 10,
        },
        Price = 5000,
        Bonus = "can make better weapons",
    },
    OreMining = {
        Name = "Ore mining",
        Requirements = {
            Exp = 5,
        },
        Price = 1000,
        Bonus = "can mine ores",
    },
    BladeSharpening = {
        Name = "Blade sharpening",
        Requirements = {
            Exp = 10,
        },
        Price = 1500,
        Bonus = "can sharp weapons",
    },
    ArmorEnchancement = {
        Name = "Armor enchancement",
        Requirements = {
            BlacksmithSkill = 60,
            Exp = 15,
        },
        Price = 2500,
        Bonus = "double armor strength",
    },
}

return Smith