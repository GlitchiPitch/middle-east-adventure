local Services = require(script.Services)

---@class ServerApplication
---@field services ServerApplicationServices
local Application = {}
Application.__index = Application

---@return ServerApplication
function Application.new()
    local self = setmetatable({}, Application)
    self.services = Services.new()
    return self
end

function Application:init()
    
end

return Application
