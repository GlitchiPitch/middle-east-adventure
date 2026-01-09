local Players = game:GetService("Players")
local CombatUI = require(script.CombatUI)
local InventoryUI = require(script.InventoryUI)
local UIManager = require(script.UIManager)

local StartingScreen = require(script.StartingScreen)

---@class UI
---@field combatUI CombatUI
---@field inventoryUI InventoryUI
---@field uiManager UIManager
---@field startingScreen StartingScreen
local UI = {}
UI.__index = UI

---@param diContainer DIContainer
---@return UI
function UI.new(diContainer)
	local self = setmetatable({}, UI)
	
	self.uiManager = UIManager.new()
	self.startingScreen = StartingScreen.new(diContainer)
	-- self.combatUI = CombatUI.new()
	-- self.inventoryUI = InventoryUI.new()
	return self
end

function UI:init() 
    self.uiManager:init()
    self.startingScreen:init()
end

return UI
