local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Attributes = require(ReplicatedStorage.Shared.Domain.Attributes)
local Equipment = require(ReplicatedStorage.Shared.Domain.Equipment)
local PlayerProgress = require(ReplicatedStorage.Shared.Domain.PlayerProgress)
-- local DataStoreService = game:GetService("DataStoreService")
---@class PlayerRepository
---@field diContainer DIContainer
---@field _players table<number, PlayerEntity>
local PlayerRepository = {}
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return PlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable({}, PlayerRepository)
	self.diContainer = diContainer
	self._players = {}
	return self
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

function PlayerRepository:_createPlayerEntity(player)
	---@type SharedDomain
	local domain = self.diContainer:resolve("Domain")
	-- ---@type Shared
	-- local shared = self.diContainer:resolve("Shared")
	-- local dataStore = DataStoreService:GetDataStore(shared.config.PlayerDataStoreKey)

	local success, result = pcall(function()
		return {} --dataStore:GetAsync(player.UserId)
	end)

	local _playerData = success and result or {}

	local playerData = {
		inventory = domain.Inventory.new(_playerData.inventory or {}),
		skills = domain.Skills.new(_playerData.skills or {}),
		stats = domain.Stats.new(_playerData.stats or {}),
		equipment = domain.Equipment.new(_playerData.equipment or {}),
		playerProgress = domain.PlayerProgress.new(_playerData.playerProgress or {}),
		attributes = domain.Attributes.new(_playerData.attributes or {}),
	}

	self._players[player.UserId] = domain.Player.new(player)
	self._players[player.UserId]:fromData(playerData)
end

return PlayerRepository
