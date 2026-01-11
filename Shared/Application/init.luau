local Commands = require(script.Commands)

---@class SharedApplication
---@field commands SharedCommands
local Application = {}
Application.__index = Application

---@return SharedApplication
function Application.new()
    local self = setmetatable({}, Application)
    self.commands = Commands.new()
    return self
end

return Application
