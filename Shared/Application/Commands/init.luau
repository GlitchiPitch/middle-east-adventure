---@class ClickInventoryItemCommand
local ClickInventoryItemCommand = {}

---@param itemName string
function ClickInventoryItemCommand.new(itemName)
	return {
		itemName = itemName,
	}
end

---@class SharedCommands
---@field ClickInventoryItemCommand ClickInventoryItemCommand
local Commands = {}
Commands.__index = Commands

function Commands.new()
	local self = setmetatable({}, Commands)
	self.ClickInventoryItemCommand = ClickInventoryItemCommand
	return self
end

return Commands
