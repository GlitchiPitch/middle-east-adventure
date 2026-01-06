local PlayerService = require(script.PlayerService)

---@class ClientApplicationServices
---@field playerService ClientApplicationPlayerService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ClientApplicationServices
function Services.new(diContainer)
    local self = setmetatable({}, Services)
    self.playerService = PlayerService.new(diContainer)
    return self
end

return Services