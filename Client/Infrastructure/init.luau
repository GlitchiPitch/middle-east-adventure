local PlayerRepository = require(script.PlayerRepository)

---@class ClientInfrastructure
---@field playerRepository ClientPlayerRepository
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@param diContainer DIContainer
---@return ClientInfrastructure
function Infrastructure.new(diContainer)
	local self = setmetatable({}, Infrastructure)
	self.playerRepository = PlayerRepository.new(diContainer)
	return self
end

return Infrastructure
