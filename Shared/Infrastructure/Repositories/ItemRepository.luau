local Interfaces = require(script.Parent.Interfaces)
local IRepository = Interfaces.IRepository

---@class ItemRepository : IRepository
---@field itemData SharedData
---@field itemCache table<string, table>
---@field typeCache table<string, table<string, table>>
local ItemRepository = setmetatable({}, { __index = IRepository })
ItemRepository.__index = ItemRepository

---@param diContainer DIContainer
---@return ItemRepository
function ItemRepository.new(diContainer)
	local self = setmetatable(IRepository.new(diContainer), ItemRepository)
	self.itemCache = {}
	self.typeCache = {}
	return self
end

function ItemRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.itemData = shared.data.Items
end

---@param itemName string
---@return table
function ItemRepository:getItemData(itemName)
	-- Check cache first
	if self.itemCache[itemName] ~= nil then
		return self.itemCache[itemName]
	end

	-- Load from source and cache
	local itemData = self.itemData:getItemData(itemName)
	self.itemCache[itemName] = itemData

	return itemData
end

---@return table<string, table>
function ItemRepository:getAllItems()
	return self.itemData:getAll()
end

---@param itemType string
---@return table<string, table>
function ItemRepository:getItemsByType(itemType)
	-- Check cache first
	if self.typeCache[itemType] then
		return self.typeCache[itemType]
	end

	-- Load from source and cache
	local allItems = self:getAllItems()
	local itemsOfType = {}

	for _, itemCategory in pairs(allItems) do
		if typeof(itemCategory) == "table" and itemCategory.getAll then
			for itemName, itemData in pairs(itemCategory:getAll()) do
				if itemData.type == itemType then
					itemsOfType[itemName] = itemData
				end
			end
		end
	end

	self.typeCache[itemType] = itemsOfType
	return itemsOfType
end

---@param itemName string
---@return string
function ItemRepository:getItemType(itemName)
	local itemData = self:getItemData(itemName)
	return itemData and itemData.type or ""
end

---@param itemName string
---@return boolean
function ItemRepository:itemExists(itemName)
	local itemData = self:getItemData(itemName)
	return itemData and true or false
end

---@param itemType string
---@return table
function ItemRepository:getItemsOfType(itemType)
	return self:getItemsByType(itemType)
end

--- Очистка кеша предметов
function ItemRepository:clearItemCache()
	self.itemCache = {}
	self.typeCache = {}
end

--- Очистка кеша для конкретного типа предметов
---@param itemType string
function ItemRepository:clearTypeCache(itemType)
	if itemType then
		self.typeCache[itemType] = nil
	else
		self.typeCache = {}
	end
end

return ItemRepository
