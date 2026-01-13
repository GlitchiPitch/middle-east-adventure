---@class InventoryUI
---@field _instance Frame
---@field diContainer DIContainer
---@field goldValue Frame
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
---@return InventoryUI
function InventoryUI.new(diContainer)
	local self = setmetatable({}, InventoryUI)
	self.diContainer = diContainer
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

	self.closeButton = self.menuFrame.Close
	self.menuDataFrame = self.dataFrame.Menu
	self.itemsContainer = self.dataFrame.Items
	self.smithRecipesContainer = self.dataFrame.SmithRecipes
	self.potionRecipesContaniner = self.dataFrame.PotionRecipes
	self.skillsContainer = self.dataFrame.Skills
	self.magicContainer = self.dataFrame.Magic

	self.statsFrame = inventory.Attributes
	self.goldValue = self.statsFrame.GoldValue

	self.itemsMenuButton = self.menuDataFrame.Items
	self.magicMenuButton = self.menuDataFrame.Magic
	self.smithRecipesMenuButton = self.menuDataFrame.SmithRecipes
	self.potionRecipesMenuButton = self.menuDataFrame.PotionRecipes
	self.skillsMenuButton = self.menuDataFrame.Skills

	self:_setup()
end

function InventoryUI:updateInventory()
	local playerEntity = self.playerService:getPlayerEntity()
	local inventoryData = playerEntity.inventory:toData()

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
	if itemData.amount == 0 then
		return
	end

	warn(itemName, itemData)

	local itemSlot = self.itemSlotTemplate:Clone()
	local _itemData = self.sharedData:getItemData(itemName)

	local function onClick()
		self.inventoryService:clickItem(itemName)
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
	--@TODO: amount field have all items i think need delete the condition
	--@TODO: all items wil be in inventory if items is not just amount 0
	if itemData.amount then
		if itemData.amount > 0 then
			itemSlot.Body.DataLabel.Text = itemData.amount
		else
			itemSlot:Destroy()
		end
	end
end

return InventoryUI
