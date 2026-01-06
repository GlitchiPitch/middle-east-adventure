---@class InventoryEntity
local Inventory = {}
Inventory.__index = Inventory

---@param data table
---@return InventoryEntity
function Inventory.new(data)
    local self = setmetatable({}, Inventory)

    self.all = data.all
    self.equipped = data.equipped

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

function Inventory:toData()
    return {}
end

return Inventory
