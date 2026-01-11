---@class ClientChestService
local ChestService = {}
ChestService.__index = ChestService

---@param diContainer DIContainer
---@return ClientChestService
function ChestService.new(diContainer)
    local self = setmetatable({}, ChestService)
    self.diContainer = diContainer
    return self
end

function ChestService:init()
    
end

---@param chest Model
function ChestService:openChest(chest)
    
end

return ChestService