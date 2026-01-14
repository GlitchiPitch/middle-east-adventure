local BasePresenter = require(script.Parent.BasePresenter)

---@class AttributesPresenter : BasePresenter
---@field attributesUI AttributesUI
local AttributesPresenter = setmetatable({}, { __index = BasePresenter })
AttributesPresenter.__index = AttributesPresenter

---@param applicationFacade IApplicationFacade
---@param attributesUI AttributesUI
---@return AttributesPresenter
function AttributesPresenter.new(applicationFacade, attributesUI)
	local self = setmetatable(BasePresenter.new(applicationFacade), AttributesPresenter)
	self.attributesUI = attributesUI
	return self
end

function AttributesPresenter:init()
	BasePresenter.init(self)

	-- Подписываемся на изменения данных атрибутов
	self:subscribeToPlayerData("Attributes", function(data)
		self:updateAttributesDisplay()
	end)

	-- Подписываемся на изменения навыков
	self:subscribeToPlayerData("Skills", function(data)
		self:updateAttributesDisplay()
	end)
end

--- Обновление отображения атрибутов
function AttributesPresenter:updateAttributesDisplay()
	if self.isDestroyed then
		return
	end

	self.attributesUI:update()
end

return AttributesPresenter
