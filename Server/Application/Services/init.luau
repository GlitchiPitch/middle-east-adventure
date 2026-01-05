---@class ServerApplicationServices
local Services = {}
Services.__index = Services

---@return ServerApplicationServices
function Services.new()
    local self = setmetatable({}, Services)
    return self
end

return Services