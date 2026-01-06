---@class ClientApplicationPlayerService
---@field diContainer DIContainer
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ClientApplicationPlayerService
function PlayerService.new(diContainer)
    local self = setmetatable({}, PlayerService)
    self.diContainer = diContainer
    return self
end

function PlayerService:callUpdatePlayerData()
    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    local remoteEventService = shared.remoteEventService

    remoteEventService:fireServer({
        eventName = shared.constants.REMOTE_EVENTS.UPDATE_PLAYER_DATA,
        data = {},
    })
end

---@param newData table
function PlayerService:updatePlayerData(newData)
    ---@type ClientInfrastructure
    local infrastructure = self.diContainer:resolve("Infrastructure")
    ---@type SharedDomain
    local domain = self.diContainer:resolve("Domain")

    newData.inventory = domain.Inventory.new(newData.inventory)
    newData.skills = domain.Skills.new(newData.skills)
    newData.stats = domain.Stats.new(newData.stats)

    infrastructure.playerRepository:updatePlayerEntity(newData)
end

---@return PlayerEntity
function PlayerService:getPlayerEntity()
    ---@type ClientInfrastructure
    local infrastructure = self.diContainer:resolve("Infrastructure")
    local playerEntity = infrastructure.playerRepository:getPlayerEntity()
    return playerEntity
end

return PlayerService
