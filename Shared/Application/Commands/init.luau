---@class ClickInventoryItemCommand
---@field itemName string
local ClickInventoryItemCommand = {}

---@param itemName string
function ClickInventoryItemCommand.new(itemName)
	return {
		itemName = itemName,
	}
end

---@class PickupLootCommand
---@field loot Model
local PickupLootCommand = {}

---@param itemModel Model
function PickupLootCommand.new(itemModel)
	return {
		loot = itemModel,
	}
end

---@class UseLecternCommand
---@field lectern Model
local UseLecternCommand = {}

---@param lectern Model
function UseLecternCommand.new(lectern)
	return {
		lectern = lectern,
	}
end

---@class SharedCommands
---@field ClickInventoryItemCommand ClickInventoryItemCommand
---@field PickupLootCommand PickupLootCommand
---@field UseLecternCommand UseLecternCommand
local Commands = {}
Commands.__index = Commands

function Commands.new()
	local self = setmetatable({}, Commands)
	self.ClickInventoryItemCommand = ClickInventoryItemCommand
	self.PickupLootCommand = PickupLootCommand
	self.UseLecternCommand = UseLecternCommand
	return self
end

return Commands
