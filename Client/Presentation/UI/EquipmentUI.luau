---@class EquipmentUI
---@field diContainer DIContainer
---@field equipmentFrame Frame
---@field actionFrame Frame
---@field button1 TextButton
---@field button2 TextButton
---@field button3 TextButton
---@field button4 TextButton
---@field inventoryButton TextButton
local EquipmentUI = {}
EquipmentUI.__index = EquipmentUI

---@param diContainer DIContainer
---@return EquipmentUI
function EquipmentUI.new(diContainer)
	local self = setmetatable({}, EquipmentUI)
	self.diContainer = diContainer
	return self
end

function EquipmentUI:init()
	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")
	local primary = presentation.ui.uiManager.primary

	self.equipmentFrame = primary.Equipment
	self.actionFrame = self.equipmentFrame.Action
	self.button1 = self.equipmentFrame["1"]
	self.button2 = self.equipmentFrame["2"]
	self.button3 = self.equipmentFrame["3"]
	self.button4 = self.equipmentFrame["4"]
	self.inventoryButton = self.equipmentFrame.Inventory
end

---@param state boolean
function EquipmentUI:toggleActionButton(state)
    self.actionFrame.Visible = state
end

return EquipmentUI
