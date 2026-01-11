---@class Misc
local Misc = {
    Acrobatics = {
        Name = "Acrobatics",
        Requirements = {
            Exp = 10,
        },
        Price = 1000,
        Bonus = "Can give when jump from a specific cliff",
    },
    WolfEndurance = {
        Name = "Wolf endurance",
        Requirements = {
            Exp = 18,
        },
        Price = 1500,
        Bonus = "Double stamina",
    },
    FireResistance = {
        Name = "Fire resistance",
        Requirements = {
            Exp = 15,
        },
        Price = 3000,
    },
    WeaknessResistance = {
        Name = "Weakness resistance",
        Requirements = {
            Exp = 20,
            AS = 35,
        },
        Price = 2000,
    },
    PosionResistance = {
        Name = "Posion resistance",
        Requirements = {
            AS = 35,
            Exp = 20,
        },
        Price = 2000,
    },
}

return Misc