---@class InventoryUI
---@field _instance Frame
---@field diContainer DIContainer
---@field goldValue Frame
---@field statsContainer ScrollingFrame
---@field expFrame Frame
---@field attributesFrame Frame
---@field defenseFrame Frame
---@field itemsMenuButton TextButton
---@field magicMenuButton TextButton
---@field smithRecipesMenuButton TextButton
---@field potionRecipesMenuButton TextButton
---@field skillsMenuButton TextButton
---@field closeButton TextButton
---@field menuDataFrame Frame
---@field itemsContainer ScrollingFrame
---@field smithRecipesContainer ScrollingFrame
---@field potionRecipesContaniner ScrollingFrame
---@field skillsContainer ScrollingFrame
---@field magicContainer ScrollingFrame
---@field menuFrame Frame
---@field dataFrame Frame
---@field statsFrame Frame
---@field playerService ClientPlayerService
---@field inventoryService ClientInventoryService
---@field sharedData SharedData
local InventoryUI = {}
InventoryUI.__index = InventoryUI

---@param diContainer DIContainer
---@param inventoryUI Frame
---@return InventoryUI
function InventoryUI.new(diContainer, inventoryUI)
	local self = setmetatable({}, InventoryUI)
	self.diContainer = diContainer
	self._instance = inventoryUI
	return self
end

function InventoryUI:init()
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")
	local inventory = presentation.ui.uiManager.inventory

	self.sharedData = shared.data
	self.itemSlotTemplate = presentation.ui.components.ItemSlotTemplate

	self.playerService = application.services.playerService
	self.inventoryService = application.services.inventoryService

	self.menuFrame = inventory.Menu
	self.dataFrame = inventory.Data
	self.statsFrame = inventory.Stats

	self.closeButton = self.menuFrame.Close
	self.menuDataFrame = self.dataFrame.Menu
	self.itemsContainer = self.dataFrame.Items
	self.smithRecipesContainer = self.dataFrame.SmithRecipes
	self.potionRecipesContaniner = self.dataFrame.PotionRecipes
	self.skillsContainer = self.dataFrame.Skills
	self.magicContainer = self.dataFrame.Magic

	self.itemsMenuButton = self.menuDataFrame.Items
	self.magicMenuButton = self.menuDataFrame.Magic
	self.smithRecipesMenuButton = self.menuDataFrame.SmithRecipes
	self.potionRecipesMenuButton = self.menuDataFrame.PotionRecipes
	self.skillsMenuButton = self.menuDataFrame.Skills

	self.goldValue = self.statsFrame.GoldValue
	self.statsContainer = self.statsFrame.ScrollingFrame
	self.expFrame = self.statsContainer.Exp
	self.attributesFrame = self.statsContainer.Attributes
	self.defenseFrame = self.statsContainer.Defense

	self:_setup()
end

function InventoryUI:updateInventory()
	local playerEntity = self.playerService:getPlayerEntity()
	local inventoryData = playerEntity.inventory:toData()
	warn("inventoryData", inventoryData)
	for i, v in inventoryData do
		local itemSlot = self.itemsContainer:FindFirstChild(i)
		if not itemSlot then
			self:_createSlot(i, v)
		else
			self:_updateSlot(itemSlot, v)
		end
	end
end

function InventoryUI:_setup()
	local function onClick()
		self.inventoryService:toggleInventoryView()
	end

	local buttonMapping = {
		[self.itemsMenuButton] = self.itemsContainer,
		[self.magicMenuButton] = self.magicContainer,
		[self.smithRecipesMenuButton] = self.smithRecipesContainer,
		[self.potionRecipesMenuButton] = self.potionRecipesContaniner,
		[self.skillsMenuButton] = self.skillsContainer,
	}

	local currentFrame = self.itemsContainer
	currentFrame.Visible = true

	for i: TextButton, v: Frame in buttonMapping do
		if v ~= currentFrame then
			v.Visible = false
		end

		local function _onClick()
			if currentFrame then
				if currentFrame ~= v then
					currentFrame.Visible = false
					currentFrame = v
				end
			else
				currentFrame = v
			end

			currentFrame.Visible = true
		end
		i.MouseButton1Click:Connect(_onClick)
	end

	self.closeButton.MouseButton1Click:Connect(onClick)
end

function InventoryUI:_createSlot(itemName, itemData)
	local itemSlot = self.itemSlotTemplate:Clone()
	local _itemData = self.sharedData:getItemData(itemName)

	local function onClick()
		self.inventoryService:clickItem(itemData)
	end

	itemSlot.Parent = self.itemsContainer
	itemSlot.Visible = true
	itemSlot.Name = itemName
	itemSlot.Body.ItemImage.Image = _itemData.image

	if itemData.amount then
		itemSlot.Body.DataLabel.Text = itemData.amount
	else
		itemSlot.Body.DataLabel.Visible = false
	end

	itemSlot.MouseButton1Click:Connect(onClick)
end

function InventoryUI:_updateSlot(itemSlot, itemData)
	if itemData.amount then
		itemSlot.Body.DataLabel.Text = itemData.amount
	end
end

return InventoryUI
