---@class InventoryEntity
local Inventory = {}
Inventory.__index = Inventory

---@param data table<string, any>
---@return InventoryEntity
function Inventory.new(data)
    local self = setmetatable({}, Inventory)
    for i, v in data do
        self[i] = v
    end
    return self
end

--[[
    data has info about sword boosts (fire, poison)
    durability
]]

---@param item table
function Inventory:addItem(item)
    self[item.name] = item
end

---@param itemName string
function Inventory:getItem(itemName)
    return self[itemName]
end

function Inventory:toData()
    return {}
end

return Inventory
