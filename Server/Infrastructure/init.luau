local PlayerRepository = require(script.PlayerRepository)

---@class ServerInfrastructure
---@field playerRepository PlayerRepository
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@param diContainer DIContainer
---@return ServerInfrastructure
function Infrastructure.new(diContainer)
    local self = setmetatable({}, Infrastructure)
    self.playerRepository = PlayerRepository.new(diContainer)
    return self
end

return Infrastructure
