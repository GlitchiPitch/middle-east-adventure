-- Imports
local ClickInventoryItem = require(script.ClickInventoryItem)
local PickupLoot = require(script.PickupLoot)
local UseLectern = require(script.UseLectern)
local EquipItem = require(script.EquipItem)
local UnequipItem = require(script.UnequipItem)
local ToggleSprint = require(script.ToggleSprint)
local StartAlchemy = require(script.StartAlchemy)
local StartSmithing = require(script.StartSmithing)
local CraftItem = require(script.CraftItem)
local StartTrade = require(script.StartTrade)
local AcceptTrade = require(script.AcceptTrade)
local AddItemToTrade = require(script.AddItemToTrade)
local RemoveItemFromTrade = require(script.RemoveItemFromTrade)
local SelectDialogOption = require(script.SelectDialogOption)
local ContinueDialog = require(script.ContinueDialog)

---@class ClientUseCases
---@field diContainer DIContainer
---@field clickInventoryItem ClientClickInventoryItem
---@field pickupLoot ClientPickupLoot
---@field useLectern ClientUseLectern
---@field equipItem ClientEquipItem
---@field unequipItem ClientUnequipItem
---@field toggleSprint ClientToggleSprint
---@field startAlchemy ClientStartAlchemy
---@field startSmithing ClientStartSmithing
---@field craftItem ClientCraftItem
---@field startTrade ClientStartTrade
---@field acceptTrade ClientAcceptTrade
---@field addItemToTrade ClientAddItemToTrade
---@field removeItemFromTrade ClientRemoveItemFromTrade
---@field selectDialogOption ClientSelectDialogOption
---@field continueDialog ClientContinueDialog
local UseCases = {}
UseCases.__index = UseCases

---@param diContainer DIContainer
---@return ClientUseCases
function UseCases.new(diContainer)
	local self = setmetatable({}, UseCases)
	self.diContainer = diContainer
	return self
end

function UseCases:init()
	self.clickInventoryItem = ClickInventoryItem.new(self.diContainer)
	self.clickInventoryItem:init()

	self.pickupLoot = PickupLoot.new(self.diContainer)
	self.pickupLoot:init()

	self.useLectern = UseLectern.new(self.diContainer)
	self.useLectern:init()

	self.equipItem = EquipItem.new(self.diContainer)
	self.equipItem:init()

	self.unequipItem = UnequipItem.new(self.diContainer)
	self.unequipItem:init()

	self.toggleSprint = ToggleSprint.new(self.diContainer)
	self.toggleSprint:init()

	self.startAlchemy = StartAlchemy.new(self.diContainer)
	self.startAlchemy:init()

	self.startSmithing = StartSmithing.new(self.diContainer)
	self.startSmithing:init()

	self.craftItem = CraftItem.new(self.diContainer)
	self.craftItem:init()

	self.startTrade = StartTrade.new(self.diContainer)
	self.startTrade:init()

	self.acceptTrade = AcceptTrade.new(self.diContainer)
	self.acceptTrade:init()

	self.addItemToTrade = AddItemToTrade.new(self.diContainer)
	self.addItemToTrade:init()

	self.removeItemFromTrade = RemoveItemFromTrade.new(self.diContainer)
	self.removeItemFromTrade:init()

	self.selectDialogOption = SelectDialogOption.new(self.diContainer)
	self.selectDialogOption:init()

	self.continueDialog = ContinueDialog.new(self.diContainer)
	self.continueDialog:init()
end

return UseCases
