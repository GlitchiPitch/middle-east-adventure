---@class StatsEntity
local Stats = {}
Stats.__index = Stats

---@param data table
---@return StatsEntity
function Stats.new(data)
    local self = setmetatable({}, Stats)
    for i, v in data do
        self[i] = v
    end
    return self
end

function Stats:toData()
    return self
end

return Stats
