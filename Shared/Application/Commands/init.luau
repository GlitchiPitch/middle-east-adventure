---@class SharedClickItemCommand
local ClickItemCommand = {}
ClickItemCommand.__index = ClickItemCommand

---@param itemName string
---@return SharedClickItemCommand
function ClickItemCommand.new(itemName)
    local self = setmetatable({}, ClickItemCommand)
    self.itemName = itemName
    return self
end

---@class SharedCommands
---@field ClickItemCommand SharedClickItemCommand
local Commands = {}
Commands.__index = Commands

function Commands.new()
    local self = setmetatable({}, Commands)
    self.ClickItemCommand = ClickItemCommand
    return self
end

return Commands
