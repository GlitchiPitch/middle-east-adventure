local Services = require(script.Services)

---@class ClientApplication
---@field services ClientApplicationServices
local Application = {}
Application.__index = Application

---@return ClientApplication
function Application.new()
    local self = setmetatable({}, Application)
    self.services = Services.new()
    return self
end

function Application:init()
    
end

return Application
