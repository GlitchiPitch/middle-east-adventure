---@class ServerItemRepository
---@field diContainer DIContainer
---@field itemData SharedData
local ItemRepository = {}
ItemRepository.__index = ItemRepository

---@param diContainer DIContainer
---@return ServerItemRepository
function ItemRepository.new(diContainer)
	local self = setmetatable({}, ItemRepository)
	self.diContainer = diContainer

	return self
end

function ItemRepository:init()
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.playerRepository
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.itemData = shared.data.Items
end

---@param itemName string
---@return table
function ItemRepository:getItemData(itemName)
	return self.itemData:getItemData(itemName)
end

---@return table<string, table>
function ItemRepository:getAllItems()
	return self.itemData:getAll()
end

---@param itemType string
---@return table<string, table>
function ItemRepository:getItemsByType(itemType)
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

return ItemRepository
