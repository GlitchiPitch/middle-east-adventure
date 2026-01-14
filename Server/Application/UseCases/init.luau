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
local UpdatePlayerData = require(script.UpdatePlayerData)
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
	self.updatePlayerData = UpdatePlayerData.new(self.diContainer)
	self.updatePlayerData:init()

	self.addItemToInventory = AddItemToInventory.new(self.diContainer)
	self.addItemToInventory:init()

	self.removeItemFromInventory = RemoveItemFromInventory.new(self.diContainer)
	self.removeItemFromInventory:init()

	self.updateItemInInventory = UpdateItemInInventory.new(self.diContainer)
	self.updateItemInInventory:init()

	self.clickInventoryItem = ClickInventoryItem.new(self.diContainer)
	self.clickInventoryItem:init()

	self.equipItem = EquipItem.new(self.diContainer)
	self.equipItem:init()

	self.setEquipmentSlot = SetEquipmentSlot.new(self.diContainer)
	self.setEquipmentSlot:init()

	self.unequipItem = UnequipItem.new(self.diContainer)
	self.unequipItem:init()

	self.updateSkill = UpdateSkill.new(self.diContainer)
	self.updateSkill:init()

	self.levelUpSkill = LevelUpSkill.new(self.diContainer)
	self.levelUpSkill:init()

	self.updateStat = UpdateStat.new(self.diContainer)
	self.updateStat:init()

	self.healPlayer = HealPlayer.new(self.diContainer)
	self.healPlayer:init()

	self.updateAttribute = UpdateAttribute.new(self.diContainer)
	self.updateAttribute:init()

	self.addExperience = AddExperience.new(self.diContainer)
	self.addExperience:init()

	self.levelUpPlayer = LevelUpPlayer.new(self.diContainer)
	self.levelUpPlayer:init()

	self.updatePlayerProgress = UpdatePlayerProgress.new(self.diContainer)
	self.updatePlayerProgress:init()
end

return UseCases
