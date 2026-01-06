local UseCases = require(script.UseCases)
local Commands = require(script.Commands)

---@class SharedApplication
---@field commands SharedCommands
---@field useCases SharedUseCases
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return SharedApplication
function Application.new(diContainer)
    local self = setmetatable({}, Application)
    self.commands = Commands.new()
    self.useCases = UseCases.new(diContainer)
    return self
end

return Application
