---@class InventoryEntity
local Inventory = {}
Inventory.__index = Inventory

---@param data table
---@return InventoryEntity
function Inventory.new(data)
    local self = setmetatable({}, Inventory)
    
    for i, v in data do
        self[i] = v
    end

    return self
end

function Inventory:toData()
    return {}
end

return Inventory