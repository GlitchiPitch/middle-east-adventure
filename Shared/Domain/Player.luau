---@class PlayerEntity
---@field inventory InventoryEntity
---@field equipment EquipmentEntity
---@field skills SkillsEntity
---@field stats StatsEntity
local Player = {}
Player.__index = Player

---@param player Player
---@return PlayerEntity
function Player.new(player)
    local self = setmetatable({}, Player)
    self._instance = player

    self.attributes = nil
    self.inventory = nil
    self.equipment = nil
    self.skills = nil
    self.stats = nil
    return self
end

---@class playerData
---@field inventory InventoryEntity
---@field equipment EquipmentEntity
---@field skills SkillsEntity
---@field stats StatsEntity
---@field attributes AttributesEntity

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
        equipment = self.equipment:toData(),
    }
end


function Player:getData()
    return {
        inventory = self.inventory,
        equipment = self.equipment,
        skills = self.skills,
        stats = self.stats,
    }
end

return Player
