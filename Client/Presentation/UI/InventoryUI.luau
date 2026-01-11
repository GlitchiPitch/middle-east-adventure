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
	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")
	local inventory = presentation.ui.uiManager.inventory

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
    
end

function InventoryUI:_setup()
	local function onClick()
		self.inventoryService:toggleInventoryView()
	end

	self.closeButton.MouseButton1Click:Connect(onClick)
end

function InventoryUI:_createSlot(i, itemData)

	local itemSlot = self._slotTemplate:Clone()
	local function onClick()
		-- application.services.inventoryService:clickItem(itemData)
	end

	itemSlot.Parent = self._instance
	itemSlot.Visible = true
	itemSlot.LayoutOrder = i
	itemSlot.MouseButton1Click:Connect(onClick)
end

return InventoryUI
