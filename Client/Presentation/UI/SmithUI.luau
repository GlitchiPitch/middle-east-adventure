---@class SmithUI
---@field diContainer DIContainer
---@field inventoryFrame Frame
---@field recipesFrame Frame
---@field recipesContainer ScrollingFrame
---@field recipeTemplate Frame
---@field moldFrame Frame
---@field moldButtonTemplate TextButton
---@field closeButton TextButton
---@field smithService ClientSmithService
local SmithUI = {}
SmithUI.__index = SmithUI

---@param diContainer DIContainer
---@return SmithUI
function SmithUI.new(diContainer)
	local self = setmetatable({}, SmithUI)
	self.diContainer = diContainer
	return self
end

function SmithUI:init()
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	self.smithService = application.services.smithService

	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")
	local smith = presentation.ui.uiManager.smith
	self.inventoryFrame = smith.Inventory
	self.recipesFrame = smith.Recipes
	self.recipesContainer = self.recipesFrame.ScrollingFrame
	self.recipeTemplate = self.recipesContainer.Template
	self.moldFrame = smith.Mold
	self.moldButtonTemplate = self.moldFrame.Template

	self.closeButton = smith.Menu.Close

	self:_setup()
end

function SmithUI:_setup()
	local function onClick()
		self.smithService:finish()
	end
	self.closeButton.MouseButton1Click:Connect(onClick)
end

function SmithUI:start() end

function SmithUI:finish() end

return SmithUI
