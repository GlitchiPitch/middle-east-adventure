---@class ServerPlayerService
---@field diContainer DIContainer
local PlayerService = {}
PlayerService.__index = PlayerService


---@param diContainer DIContainer
---@return ServerPlayerService
function PlayerService.new(diContainer)
    local self = setmetatable({}, PlayerService)
    self.diContainer = diContainer
    return self
end

---@param player Player
function PlayerService:onPlayerAdded(player)
    ---@type ServerInfrastructure
    local infrastructure = self.diContainer:resolve("Infrastructure")
    local playerRepository = infrastructure.playerRepository
    playerRepository:onPlayerAdded(player)
end

---@param player Player
function PlayerService:onPlayerRemoving(player)
    ---@type ServerInfrastructure
local infrastructure = self.diContainer:resolve("Infrastructure")
local playerRepository = infrastructure.playerRepository
playerRepository:onPlayerRemoving(player)
end

return PlayerService