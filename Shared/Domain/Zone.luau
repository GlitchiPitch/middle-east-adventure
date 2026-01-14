---@alias _zoneType '"Mob"' | '"Plant"' | '"Mine"'

---@class ZoneEntity
---@field type _zoneType
---@field _instance Part
local Zone = {}
Zone.__index = Zone

---@class zoneData
---@field type _zoneType
---@field _instance Part

---@param data zoneData
---@return ZoneEntity
function Zone.new(data)
	local self = setmetatable({}, Zone)
	self.type = data.type
	self._instance = data._instance
	return self
end

---@return table
function Zone:spawn()
	local spawnedEntities = {}

	if self.type == "Mob" then
		-- Spawn mobs in the zone
		-- This would typically involve creating mob entities and placing them in the zone
		spawnedEntities = self:spawnMobs()
	elseif self.type == "Plant" then
		-- Spawn plants/resources in the zone
		spawnedEntities = self:spawnPlants()
	elseif self.type == "Mine" then
		-- Spawn mining nodes in the zone
		spawnedEntities = self:spawnMiningNodes()
	end

	return spawnedEntities
end

---@return table
function Zone:spawnMobs()
	-- Logic to spawn mobs based on zone configuration
	-- This would typically involve:
	-- 1. Getting mob types available for this zone
	-- 2. Determining spawn count based on zone size/difficulty
	-- 3. Creating mob entities at random positions within the zone
	local mobs = {}
	-- Implementation would depend on specific game requirements
	return mobs
end

---@return table
function Zone:spawnPlants()
	-- Logic to spawn plants/resources
	-- Similar to mob spawning but for gatherable resources
	local plants = {}
	-- Implementation would depend on zone configuration
	return plants
end

---@return table
function Zone:spawnMiningNodes()
	-- Logic to spawn mining nodes
	-- Create ore veins, mineral deposits, etc.
	local nodes = {}
	-- Implementation would depend on zone configuration
	return nodes
end

return Zone
