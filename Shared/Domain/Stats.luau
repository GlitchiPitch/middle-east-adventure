---@class StatsEntity
local Stats = {}
Stats.__index = Stats

---@param data table
---@return StatsEntity
function Stats.new(data)
    local self = setmetatable({}, Stats)
    self.health = data.health or 100
    self.stamina = data.stamina or 100
    self.mana = data.mana or 100
    
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
