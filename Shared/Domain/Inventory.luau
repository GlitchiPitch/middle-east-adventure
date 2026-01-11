---@class InventoryEntity
local Inventory = {}
Inventory.__index = Inventory

---@class inventoryData
---@field amount number
---@field data table<string, any>

---@alias itemName string

---@class addInventoryData
---@field name itemName
---@field data inventoryData

---@param data table<itemName, inventoryData>
---@return InventoryEntity
function Inventory.new(data)
	local self = setmetatable({}, Inventory)
	for i, v in data do
		self[i] = v
	end

	self.Banana = { amount = 10 }
	self.PotionOfStamina = { amount = 15 }

	return self
end

--[[
    data has info about sword boosts (fire, poison)
    durability
]]

---@param item addInventoryData
function Inventory:addItem(item)
	self[item.name] = item.data
end

---@param itemName itemName
---@return inventoryData
function Inventory:getItem(itemName)
	return self[itemName]
end

function Inventory:toData()
	return self
end

return Inventory
