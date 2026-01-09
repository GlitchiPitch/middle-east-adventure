---@class stat
---@field max number
---@field current number

---@class StatsEntity
---@field health stat
---@field stamina stat
---@field mana stat
---@field weak boolean
---@field posioned boolean
---@field frosted boolean
---@field fired boolean
local Stats = {}
Stats.__index = Stats

---@param data table
---@return StatsEntity
function Stats.new(data)
    local self = setmetatable({}, Stats)
    self.health = data.health or {
        max = 100,
        current = 50,
    }
    self.stamina = data.stamina or {
        max = 100,
        current = 30,
    }
    self.mana = data.mana or {
        max = 100,
        current = 70,
    }
    
    self.weak = false
    self.posioned = false
    self.frosted = false
    self.fired = false

    return self
end

function Stats:toData()
    return {}
end

return Stats
