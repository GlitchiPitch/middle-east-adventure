---@class ServerApplicationPlayerService
---@field diContainer DIContainer
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ServerApplicationPlayerService
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

---@param player Player
---@return table
function PlayerService:getPlayerData(player)
    ---@type ServerInfrastructure
    local infrastructure = self.diContainer:resolve("Infrastructure")
    local playerEntity = infrastructure.playerRepository:getPlayerEntity(player)
    return playerEntity:toData()
end

---@param player Player
---@return PlayerEntity
function PlayerService:getPlayerEntity(player)
    ---@type ServerInfrastructure
    local infrastructure = self.diContainer:resolve("Infrastructure")
    local playerEntity = infrastructure.playerRepository:getPlayerEntity(player)
    return playerEntity
end

return PlayerService
