---@class EquipmentUI
---@field diContainer DIContainer
---@field playerService ClientPlayerService
---@field equipmentFrame Frame
---@field actionFrame Frame
---@field button1 TextButton
---@field button2 TextButton
---@field button3 TextButton
---@field button4 TextButton
---@field inventoryButton TextButton
---@field sharedData SharedData
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
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")
	local primary = presentation.ui.uiManager.primary

	self.playerService = application.services.playerService
	self.sharedData = shared.data

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

function EquipmentUI:update()
	local playerEntity = self.playerService:getPlayerEntity()
	local equipmentData = playerEntity.equipment:toData()
	warn(equipmentData)
	local keys = {
		[Enum.KeyCode.One.Name] = self.button1,
		[Enum.KeyCode.Two.Name] = self.button2,
		[Enum.KeyCode.Three.Name] = self.button3,
		[Enum.KeyCode.Four.Name] = self.button4,
	}

	for i, v in keys do
		self:_setButton(v, equipmentData.slots[i])
	end
end

function EquipmentUI:_setButton(slotButton, itemName)
	local itemData = self.sharedData:getItemData(itemName)
	slotButton.ItemImage.Image = itemData and itemData.image or ""
end

return EquipmentUI
