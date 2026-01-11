---@class SmithUI
---@field diContainer DIContainer
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
	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")
	local smith = presentation.ui.uiManager.smith

end

return SmithUI
