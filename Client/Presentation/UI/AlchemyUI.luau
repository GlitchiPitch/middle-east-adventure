---@class ingredientData
---@field waterColor Color3
---@field name string
---@field image string

---@class RecipeEntity
---@field isOpened boolean
---@field ingredients ingredientData[]
local Recipe = {}
Recipe.__index = Recipe

function Recipe.new(data)
	local self = setmetatable({}, Recipe)
	self.isOpened = false
	self.ingredients = data.ingredients
	self.frame = nil

	self:_setup()
	return self
end

function Recipe:getData() end

function Recipe:toogleView()
	self.isOpened = not self.isOpened
	if self.isOpened then
		self:_hide()
	else
		self:_open()
	end
end

function Recipe:_setup()
	self.body = self.frame.Body
	self.ingredientsFrame = self.body.Ingredients
	self.titleButton = self.frame.TitleButton

	for _, slot in self.ingredientsFrame:GetChildren() do
		if slot:IsA("TextButton") then
			local ingredientData = self.ingredients[tonumber(slot.Name)]
			if ingredientData then
				slot.IngredientImage.Image = ingredientData.image
				slot.WaterImage.ImageColor3 = ingredientData.waterColor

				slot.WaterImage.Visible = true
				slot.IngredientImage.Visible = true
			else
				slot.IngredientImage.Visible = false
				slot.WaterImage.Visible = false
			end
		end
	end
end

function Recipe:_open()
	self.frame.Size = UDim2.fromScale(1, 1)
	self.titleButton.Size = UDim2.fromScale(1, 0.1)
	self.titleButton.ClickImage.Visible = false
	self.body.Visible = true
end

function Recipe:_hide()
	self.frame.Size = UDim2.fromScale(1, 0.1)
	self.titleButton.Size = UDim2.fromScale(1, 1)
	self.titleButton.ClickImage.Visible = true
	self.body.Visible = false
end

---@class AlchemyUI
---@field diContainer DIContainer
---@field recipesFrame Frame
---@field inventoryFrame Frame
---@field recipesContainer ScrollingFrame
---@field recipeTemplate Frame
---@field closeButton TextButton
---@field alchemyService ClientAlchemyService
local AlchemyUI = {}
AlchemyUI.__index = AlchemyUI

---@param diContainer DIContainer
---@return AlchemyUI
function AlchemyUI.new(diContainer)
	local self = setmetatable({}, AlchemyUI)
	self.diContainer = diContainer
	return self
end

function AlchemyUI:init()
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	self.alchemyService = application.services.alchemyService

	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")
	local alchemy = presentation.ui.uiManager.alchemy
	self.inventoryFrame = alchemy.Inventory
	self.inventoryContainer = self.inventoryFrame.ScrollingFrame
	self.inventorySlotTemplate = self.inventoryContainer.Template

	self.recipesFrame = alchemy.Recipes
	self.recipesContainer = self.recipesFrame.ScrollingFrame
	self.recipeTemplate = self.recipesContainer.Template

	self.closeButton = alchemy.Menu.Close

	self:_setup()
end

function AlchemyUI:updatePlayerRecipes()
	
end

function AlchemyUI:_setup()
	local function onClick()
		self.alchemyService:finish()
	end
	self.closeButton.MouseButton1Click:Connect(onClick)
end

---@param recipe RecipeEntity
function AlchemyUI:_toggleRecipeView(recipe)
	recipe:toogleView()
end

return AlchemyUI
