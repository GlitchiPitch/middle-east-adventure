---@class ClientApplicationServices
local Services = {}
Services.__index = Services

---@return ClientApplicationServices
function Services.new()
    local self = setmetatable({}, Services)
    return self
end

return Services