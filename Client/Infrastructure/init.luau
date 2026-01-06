local PlayerRepository = require(script.PlayerRepository)

---@class ClientInfrastructure
---@field playerRepository ClientPlayerRepository
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@return ClientInfrastructure
function Infrastructure.new()
    local self = setmetatable({}, Infrastructure)
    self.playerRepository = PlayerRepository.new()
    return self
end

return Infrastructure