local Aggressive = {
    MinecrawlerKrieger = {
        LifePoints = 1000,
        Exp = 300,
        Protection = 100,
        Drops = {
            {Item = "Crawling Mandibles", Amount = 2}
        }
    },

    Blutfliege = {
        LifePoints = 500,
        Exp = 50,
        Protection = 100,
        Drops = {
            {Item = "Hornet Sting", Amount = 1}
        }
    },

    Scavenger = {
        LifePoints = 400,
        Exp = 50,
        Protection = 100,
        Drops = {
            {Item = "Raw Meat", Amount = 1},
            {Item = "Scavenger Egg", AmountRange = {0,1}}
        }
    },

    Glorch = {
        -- No data provided
    },

    Schattenlaeufer = {
        LifePoints = 1000,
        Exp = 300,
        Drops = {
            {Item = "Darkbeast Skin", Amount = 1},
            {Item = "Darkbeast Horn", Amount = 1}
        }
    },
}

---@class Animals
local Animals = {}

return Animals