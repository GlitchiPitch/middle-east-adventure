local CombatUI = require(script.CombatUI)
local InventoryUI = require(script.InventoryUI)
local UIManager = require(script.UIManager)

---@class UI
---@field combatUI CombatUI
---@field inventoryUI InventoryUI
---@field uiManager UIManager
local UI = {}
UI.__index = UI

---@return UI
function UI.new()
    local self = setmetatable({}, UI)
    self.combatUI = CombatUI.new()
    self.inventoryUI = InventoryUI.new()
    self.uiManager = UIManager.new()
    return self
end

function UI:init()
    
end

return UI
