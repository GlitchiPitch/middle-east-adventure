local UI = require(script.UI)
local Services = require(script.Services)

---@class Presentation
---@field ui UI
---@field services PresentationServices
---@field diContainer DIContainer
local Presentation = {}
Presentation.__index = Presentation

---@param diContainer DIContainer
---@return Presentation
function Presentation.new(diContainer)
	local self = setmetatable({}, Presentation)
	self.diContainer = diContainer
	self.ui = UI.new(diContainer)
	self.services = Services.new(diContainer)
	return self
end

function Presentation:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	shared.eventBus:connect("updatePlayerData", function()
		self.ui.statsUI:updateUI()
		self.ui.alchemyUI:updatePlayerRecipes()
		self.ui.inventoryUI:updateInventory()
	end)

	shared.eventBus:connect("setAlchemyMode", function(data)
		if data.isActive then
			self.ui.uiManager:setCurrentScreen("alchemy")
		else
			self.ui.uiManager:setCurrentScreen("primary")
		end
	end)

	shared.eventBus:connect("setSmithMode", function(data)
		if data.isActive then
			self.ui.uiManager:setCurrentScreen("smith")
		else
			self.ui.uiManager:setCurrentScreen("primary")
		end
	end)

	shared.eventBus:connect("showDialog", function(data)
		self.ui.dialogUI:showDialog(data)
		self.ui.uiManager:setCurrentScreen("dialog")
	end)

	shared.eventBus:connect("finishDialog", function(_)
		self.ui.dialogUI:hideDialog()
		self.ui.uiManager:setCurrentScreen("primary")
	end)

	shared.eventBus:connect("toggleActionButton", function(data)
		self.ui.equipmentUI:toggleActionButton(data.state)
	end)

	shared.eventBus:connect("toggleInventoryView", function(data)
		if data.isActive then
			self.ui.uiManager:setCurrentScreen("inventory")
		else
			self.ui.uiManager:setCurrentScreen("primary")
		end
	end)

	self.ui:init()
end

return Presentation
