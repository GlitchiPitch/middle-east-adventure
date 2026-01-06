local Players = game:GetService("Players")
local Services = require(script.Services)

---@class ServerApplication
---@field diContainer DIContainer
---@field services ServerApplicationServices
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ServerApplication
function Application.new(diContainer)
    local self = setmetatable({}, Application)
    self.diContainer = diContainer
    self.services = Services.new(diContainer)
    return self
end

function Application:init()
    ---@param player Player
    local function onPlayerAdded(player)
        self.services.playerService:onPlayerAdded(player)
    end

    ---@param player Player
    local function onPlayerRemoving(player)
        self.services.playerService:onPlayerRemoving(player)
    end

    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    local remoteEventService = shared.remoteEventService

    remoteEventService:connectToEvents({
        ---@param player Player
        ---@param _ eventData
        [shared.constants.REMOTE_EVENTS.UPDATE_PLAYER_DATA] = function(player, _)
            local playerData = self.services.playerService:getPlayerData(player)
            remoteEventService:fireClient(player, {
                eventName = shared.constants.REMOTE_EVENTS.UPDATE_PLAYER_DATA,
                data = playerData,
            })
        end,
        
        ---@param player Player
        ---@param eventData eventData
        [shared.constants.REMOTE_EVENTS.CLICK_INVENTORY_ITEM] = function(player, eventData)
            self.services.inventoryService:clickItem(player, eventData.data)
        end
    })

    Players.PlayerRemoving:Connect(onPlayerRemoving)
    Players.PlayerAdded:Connect(onPlayerAdded)
end

return Application
