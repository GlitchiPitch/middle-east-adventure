---@class PlayerEntity
---@field inventory InventoryEntity
---@field equipment EquipmentEntity
---@field attributes AttributesEntity
---@field playerProgress PlayerProgressEntity
---@field skills SkillsEntity
---@field stats StatsEntity
---@field _instance Player
---@field state playerStateEnum
local Player = {}
Player.__index = Player

---@param player Player
---@return PlayerEntity
function Player.new(player)
	local self = setmetatable({}, Player)
	self._instance = player
	self.state = "Idle"
	return self
end

---@class playerData
---@field inventory InventoryEntity
---@field equipment EquipmentEntity
---@field skills SkillsEntity
---@field stats StatsEntity
---@field attributes AttributesEntity
---@field playerProgress PlayerProgressEntity

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
		attributes = self.attributes:toData(),
		playerProgress = self.playerProgress:toData(),
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

---@param state boolean
function Player:toggleRobloxControl(state)
	if not self.controlModule then
		local PlayerModule = require(self._instance.PlayerScripts:WaitForChild("PlayerModule"))
		self.controlModule = PlayerModule:GetControls()
	end

	if state then
		self.controlModule:Enable()
	else
		self.controlModule:Disable()
	end
end

return Player
