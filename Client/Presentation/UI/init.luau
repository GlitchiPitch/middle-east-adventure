local Players = game:GetService("Players")
local CombatUI = require(script.CombatUI)
local InventoryUI = require(script.InventoryUI)
local UIManager = require(script.UIManager)
local StatsUI = require(script.StatsUI)
local StartingScreen = require(script.StartingScreen)
local AlchemyUI = require(script.AlchemyUI)
local DialogUI = require(script.DialogUI)
local SmithUI = require(script.SmithUI)

---@class UI
---@field combatUI CombatUI
---@field inventoryUI InventoryUI
---@field uiManager UIManager
---@field statsUI StatsUI
---@field alchemyUI AlchemyUI
---@field dialogUI DialogUI
---@field startingScreen StartingScreen
---@field smithUI SmithUI
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
	-- self.combatUI = CombatUI.new()
	-- self.inventoryUI = InventoryUI.new()
	return self
end

function UI:init()
	self.uiManager:init()
	self.startingScreen:init()
	self.statsUI:init()
	self.dialogUI:init()
	self.smithUI:init()
end

return UI
