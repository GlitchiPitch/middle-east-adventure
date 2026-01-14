local AddItemToInventory = require(script.AddItemToInventory)
local RemoveItemFromInventory = require(script.RemoveItemFromInventory)
local UpdateItemInInventory = require(script.UpdateItemInInventory)
local ClickInventoryItem = require(script.ClickInventoryItem)
local EquipItem = require(script.EquipItem)
local SetEquipmentSlot = require(script.SetEquipmentSlot)
local UnequipItem = require(script.UnequipItem)
local UpdateSkill = require(script.UpdateSkill)
local LevelUpSkill = require(script.LevelUpSkill)
local UpdateStat = require(script.UpdateStat)
local HealPlayer = require(script.HealPlayer)
local UpdateAttribute = require(script.UpdateAttribute)
local AddExperience = require(script.AddExperience)
local LevelUpPlayer = require(script.LevelUpPlayer)
local UpdatePlayerProgress = require(script.UpdatePlayerProgress)

---@class ServerUpdatePlayerData
---@field remoteEventService RemoteEventService
---@field playerService ServerPlayerService
---@field constants Constants
local UpdatePlayerData = {}
UpdatePlayerData.__index = UpdatePlayerData

---@param remoteEventService RemoteEventService
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerUpdatePlayerData
function UpdatePlayerData.new(remoteEventService, playerService, constants)
	local self = setmetatable({}, UpdatePlayerData)
	self.remoteEventService = remoteEventService
	self.playerService = playerService
	self.constants = constants
	return self
end

---@param player Player
function UpdatePlayerData:execute(player)
	local playerData = self.playerService:getPlayerData(player)
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.UPDATE_PLAYER_DATA,
		data = playerData,
	})
end

---@class ServerUseCases
---@field diContainer DIContainer
---@field updatePlayerData ServerUpdatePlayerData
---@field addItemToInventory ServerAddItemToInventory
---@field removeItemFromInventory ServerRemoveItemFromInventory
---@field updateItemInInventory ServerUpdateItemInInventory
---@field clickInventoryItem ServerClickInventoryItem
---@field equipItem ServerEquipItem
---@field setEquipmentSlot ServerSetEquipmentSlot
---@field unequipItem ServerUnequipItem
---@field updateSkill ServerUpdateSkill
---@field levelUpSkill ServerLevelUpSkill
---@field updateStat ServerUpdateStat
---@field healPlayer ServerHealPlayer
---@field updateAttribute ServerUpdateAttribute
---@field addExperience ServerAddExperience
---@field levelUpPlayer ServerLevelUpPlayer
---@field updatePlayerProgress ServerUpdatePlayerProgress
local UseCases = {}
UseCases.__index = UseCases

---@param diContainer DIContainer
---@return ServerUseCases
function UseCases.new(diContainer)
	local self = setmetatable({}, UseCases)
	self.diContainer = diContainer
	return self
end

function UseCases:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")

	self.updatePlayerData =
		UpdatePlayerData.new(shared.remoteEventService, application.services.playerService, shared.constants)

	self.addItemToInventory = AddItemToInventory.new(
		infrastructure.inventoryRepository,
		application.services.playerService,
		shared.constants
	)

	self.removeItemFromInventory = RemoveItemFromInventory.new(
		infrastructure.inventoryRepository,
		application.services.playerService,
		shared.constants
	)

	self.updateItemInInventory = UpdateItemInInventory.new(
		infrastructure.inventoryRepository,
		application.services.playerService,
		shared.constants
	)

	self.clickInventoryItem = ClickInventoryItem.new(
		infrastructure.equipmentRepository,
		shared.constants
	)

	self.equipItem = EquipItem.new(
		infrastructure.equipmentRepository,
		application.services.toolService,
		application.services.playerService,
		shared.constants
	)

	self.setEquipmentSlot = SetEquipmentSlot.new(
		infrastructure.equipmentRepository,
		application.services.playerService,
		shared.constants
	)

	self.unequipItem = UnequipItem.new(
		infrastructure.equipmentRepository,
		application.services.playerService,
		shared.constants
	)

	self.updateSkill = UpdateSkill.new(
		infrastructure.skillsRepository,
		application.services.playerService,
		shared.constants
	)

	self.levelUpSkill = LevelUpSkill.new(
		infrastructure.skillsRepository,
		application.services.playerService,
		shared.constants
	)

	self.updateStat = UpdateStat.new(
		infrastructure.statsRepository,
		application.services.playerService,
		shared.constants
	)

	self.healPlayer = HealPlayer.new(
		infrastructure.statsRepository,
		application.services.playerService,
		shared.constants
	)

	self.updateAttribute = UpdateAttribute.new(
		infrastructure.attributesRepository,
		application.services.playerService,
		shared.constants
	)

	self.addExperience = AddExperience.new(
		infrastructure.attributesRepository,
		application.services.playerService,
		shared.constants
	)

	self.levelUpPlayer = LevelUpPlayer.new(
		infrastructure.attributesRepository,
		application.services.playerService,
		shared.constants
	)

	self.updatePlayerProgress = UpdatePlayerProgress.new(
		infrastructure.playerRepository,
		application.services.playerService,
		shared.constants
	)
end

return UseCases
