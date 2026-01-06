local Players = game:GetService("Players")
---@class ClientPlayerRepository
---@field diContainer DIContainer
---@field player Player
---@field playerEntity PlayerEntity
local PlayerRepository = {}
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return ClientPlayerRepository
function PlayerRepository.new(diContainer)
    local self = setmetatable({}, PlayerRepository)
    self.diContainer = diContainer
    self.player = Players.LocalPlayer
    self.playerEntity = nil
    return self
end

function PlayerRepository:getPlayerEntity()
    if not self.playerEntity then
        ---@type SharedDomain
        local domain = self.diContainer:resolve("Domain")
        self.playerEntity = domain.Player.new(self.player)
    end

    return self.playerEntity
end

function PlayerRepository:updatePlayerEntity(newData)
    local playerEntity = self:getPlayerEntity()
    playerEntity:fromData(newData)
end

return PlayerRepository
