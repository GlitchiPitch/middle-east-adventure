---@class AttributesUI
---@field attributesContainer ScrollingFrame
---@field attributes Frame
---@field expFrame Frame
---@field defenseFrame Frame
---@field attributesFrame Frame
---@field diContainer DIContainer
---@field playerService ClientPlayerService
local AttributesUI = {}
AttributesUI.__index = AttributesUI

---@param diContainer DIContainer
---@return AttributesUI
function AttributesUI.new(diContainer)
	local self = setmetatable({}, AttributesUI)
	self.diContainer = diContainer
	return self
end

function AttributesUI:init()
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")
	local inventory = presentation.ui.uiManager.inventory

	self.playerService = application.services.playerService

	self.mainFrame = inventory.Attributes
	self.attributesContainer = self.mainFrame.ScrollingFrame

	-- frames
	self.attributesFrame = self.attributesContainer.Attributes
	self.defenseFrame = self.attributesContainer.Defense
	self.expFrame = self.attributesContainer.Exp

	self.arrows = self.defenseFrame.Arrows
	self.blade = self.defenseFrame.Blade
	self.fire = self.defenseFrame.Fire
	self.cold = self.defenseFrame.Cold
	self.hit = self.defenseFrame.Hit

	self.exp = self.expFrame.Exp
	self.expPoints = self.expFrame.ExpPoints
	self.level = self.expFrame.Level
	self.nextLevel = self.expFrame.NextLevel

	self.alchemy = self.attributesFrame.Alchemy
	self.ancientKnowledge = self.attributesFrame.AncientKnowledge
	self.blacksmith = self.attributesFrame.Blacksmith
	self.dexterity = self.attributesFrame.Dexterity
	self.health = self.attributesFrame.Health
	self.mana = self.attributesFrame.Mana
	self.stamina = self.attributesFrame.Stamina
	self.strength = self.attributesFrame.Strength
	self.thief = self.attributesFrame.Thief

	self.sharedData = shared.data

	self:_setup()
end

function AttributesUI:update()
	local playerEntity = self.playerService:getPlayerEntity()
	local attributesData = playerEntity.attributes:toData()

	self.nextLevel.Value.Text = "not implement"

	for i, v in attributesData do
		if typeof(v) == "table" then
			for j, k in v do
				local attLabel = self[j]
				attLabel.Value.Text = k
			end
		else
			local attLabel = self[i]
			attLabel.Value.Text = v
		end
	end
end

function AttributesUI:_setup() end

return AttributesUI
