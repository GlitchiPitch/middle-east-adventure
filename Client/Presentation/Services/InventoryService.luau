---@class ClientPresentationInventoryService
local InventoryService = {}
InventoryService.__index = InventoryService

function InventoryService.new()
    local self = setmetatable({}, InventoryService)
    return self
end

function InventoryService:equip(equipData)
    
end

return InventoryService