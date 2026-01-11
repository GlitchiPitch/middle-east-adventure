local CombatUI = require(script.CombatUI)
local InventoryUI = require(script.InventoryUI)
local UIManager = require(script.UIManager)
local StatsUI = require(script.StatsUI)
local StartingScreen = require(script.StartingScreen)
local AlchemyUI = require(script.AlchemyUI)
local DialogUI = require(script.DialogUI)
local SmithUI = require(script.SmithUI)
local EquipmentUI = require(script.EquipmentUI)

---@class UI
---@field combatUI CombatUI
---@field inventoryUI InventoryUI
---@field uiManager UIManager
---@field statsUI StatsUI
---@field alchemyUI AlchemyUI
---@field dialogUI DialogUI
---@field startingScreen StartingScreen
---@field smithUI SmithUI
---@field equipmentUI EquipmentUI
local UI = {}
UI.__index = UI

---@param diContainer DIContainer
---@return UI
function UI.new(diContainer)
	local self = setmetatable({}, UI)

	self.uiManager = UIManager.new()
	self.startingScreen = StartingScreen.new(diContainer)
	self.statsUI = StatsUI.new(diContainer)
	self.alchemyUI = AlchemyUI.new(diContainer)
	self.dialogUI = DialogUI.new(diContainer)
	self.smithUI = SmithUI.new(diContainer)
	self.equipmentUI = EquipmentUI.new(diContainer)
	-- self.combatUI = CombatUI.new()
	self.inventoryUI = InventoryUI.new(diContainer)
	return self
end

function UI:init()
	self.uiManager:init()
	self.startingScreen:init()
	self.statsUI:init()
	self.dialogUI:init()
	self.smithUI:init()
	self.alchemyUI:init()
	self.inventoryUI:init()
	self.equipmentUI:init()
end

return UI
