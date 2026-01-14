-- local DataStoreService = game:GetService("DataStoreService")

---@class ServerPlayerRepository
---@field diContainer DIContainer
---@field _players table<number, PlayerEntity>
---@field inventoryRepository ServerInventoryRepository
---@field equipmentRepository ServerEquipmentRepository
---@field skillsRepository ServerSkillsRepository
---@field statsRepository ServerStatsRepository
---@field attributesRepository ServerAttributesRepository
local PlayerRepository = {}
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return ServerPlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable({}, PlayerRepository)
	self.diContainer = diContainer
	self._players = {}
	return self
end

function PlayerRepository:init()
	-- Initialize repositories
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.inventoryRepository = infrastructure.inventoryRepository
	self.equipmentRepository = infrastructure.equipmentRepository
	self.skillsRepository = infrastructure.skillsRepository
	self.statsRepository = infrastructure.statsRepository
	self.attributesRepository = infrastructure.attributesRepository
end

---@param player Player
function PlayerRepository:onPlayerAdded(player)
	self:_createPlayerEntity(player)
end

---@param player Player
function PlayerRepository:onPlayerRemoving(player)
	if self._players[player.UserId] then
		-- ---@type Shared
		-- local shared = self.diContainer:resolve("Shared")
		-- -- local dataStore = DataStoreService:GetDataStore(shared.config.PlayerDataStoreKey)

		-- local playerData = self._players[player.UserId]:toData()
		local success, _ = pcall(function()
			return {} ---dataStore:SetAsync(player.UserId, playerData)
		end)

		if not success then
			warn("Data not saved")
		end

		self._players[player.UserId] = nil
	end
end

---@param player Player
function PlayerRepository:getPlayerEntity(player)
	if not self._players[player.UserId] then
		self:_createPlayerEntity(player)
	end

	return self._players[player.UserId]
end

---@param playerEntity PlayerEntity
---@return InventoryEntity
function PlayerRepository:getInventory(playerEntity)
	return playerEntity.inventory
end

---@param playerEntity PlayerEntity
---@return EquipmentEntity
function PlayerRepository:getEquipment(playerEntity)
	return playerEntity.equipment
end

---@param playerEntity PlayerEntity
---@return SkillsEntity
function PlayerRepository:getSkills(playerEntity)
	return playerEntity.skills
end

---@param playerEntity PlayerEntity
---@return StatsEntity
function PlayerRepository:getStats(playerEntity)
	return playerEntity.stats
end

---@param playerEntity PlayerEntity
---@return AttributesEntity
function PlayerRepository:getAttributes(playerEntity)
	return playerEntity.attributes
end

---@param playerEntity PlayerEntity
---@param newData table
function PlayerRepository:updatePlayerEntityByEntity(playerEntity, newData)
	playerEntity:fromData(newData)
end

---@param playerEntity PlayerEntity
---@return table
function PlayerRepository:toData(playerEntity)
	return playerEntity:toData()
end

function PlayerRepository:_createPlayerEntity(player)
	---@type SharedDomain
	local domain = self.diContainer:resolve("Domain")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	-- local dataStore = DataStoreService:GetDataStore(shared.config.PlayerDataStoreKey)

	local success, result = pcall(function()
		return {} --dataStore:GetAsync(player.UserId)
	end)

	local _playerData = success and result or {}

	local playerData = {
		inventory = domain.Inventory.new(shared.data),
		skills = domain.Skills.new(_playerData.skills or {}),
		stats = domain.Stats.new(_playerData.stats or {}),
		equipment = domain.Equipment.new(_playerData.equipment or {}),
		playerProgress = domain.PlayerProgress.new(_playerData.playerProgress or {}),
		attributes = domain.Attributes.new(_playerData.attributes or {}),
	}

	playerData.inventory:fromData(_playerData.inventory or {})

	self._players[player.UserId] = domain.Player.new(player)
	self._players[player.UserId]:fromData(playerData)
end

return PlayerRepository
