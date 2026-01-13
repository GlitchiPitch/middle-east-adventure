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

---@param defaultData SharedData
---@return InventoryEntity
function Inventory.new(defaultData)
	local self = setmetatable({}, Inventory)

	if defaultData then
		for _, v in defaultData.Items:getAll() do
			for j, _ in v:getAll() do
				self[j] = { amount = 0 }
			end
		end
	end

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

function Inventory:removeItem(item)
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

---@param data table<itemName, inventoryData>
function Inventory:fromData(data)
	for i, v in data do
		self[i] = v
	end
end

return Inventory
