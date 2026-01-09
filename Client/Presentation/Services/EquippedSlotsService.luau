---@class EquippedSlotsService
---@field diContainer DIContainer
local EquippedSlotsService = {}
EquippedSlotsService.__index = EquippedSlotsService

---@param diContainer DIContainer
---@return EquippedSlotsService
function EquippedSlotsService.new(diContainer)
    local self = setmetatable({}, EquippedSlotsService)
    self.diContainer = diContainer
    return self
end

function EquippedSlotsService:init()
    ---@type ClientApplication
    local application = self.diContainer:resolve("Application")
    local equipment = application.services.playerService:getPlayerEquipment()
    
	---@type Shared
	
end

function EquippedSlotsService:updateSlots()
	---@type ClientApplication
local application = self.diContainer:resolve("Application")
local equipment = application.services.playerService:getPlayerEquipment()

-- equipment
end

return EquippedSlotsService