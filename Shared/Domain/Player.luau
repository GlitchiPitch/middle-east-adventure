---@class PlayerEntity
---@field inventory InventoryEntity
---@field skills SkillsEntity
---@field stats StatsEntity
local Player = {}
Player.__index = Player

---@param player Player
---@return PlayerEntity
function Player.new(player)
    local self = setmetatable({}, Player)
    self._instance = player

    self.inventory = nil
    self.skills = nil
    self.stats = nil
    return self
end

---@class playerData
---@field inventory InventoryEntity
---@field skills SkillsEntity
---@field stats StatsEntity

---@param playerData playerData
function Player:fromData(playerData)
    for i, v in playerData do
        self[i] = v
    end
end

function Player:toData()
    return {
        inventory = self.inventory:toData(),
        skills = self.skills:toData(),
        stats = self.stats:toData(),
    }
end


function Player:getData()
    return {
        inventory = self.inventory,
        skills = self.skills,
        stats = self.stats,
    }
end

return Player
