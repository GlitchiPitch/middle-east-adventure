---@class Thief
local Thief = {
    BreakingSimpleLock = {
        Name = "Breaking simple lock",
        Requirements = {
            -- start skill, no requirements
        },
        Price = 0,
        Bonus = "unlock simple locks",
    },
    BreakingComplexLock = {
        Name = "Breaking complex lock",
        Requirements = {
            thiefSkill = 30,
            Exp = 6,
        },
        Price = 2500,
        Bonus = "unlock complex locks",
    },
    BreakingImpossibleLock = {
        Name = "Breaking impossible lock",
        Requirements = {
            thiefSkill = 60,
            Exp = 8,
        },
        Price = 5000,
        Bonus = "unlock impossible locks",
    },
}

return Thief