local Services = require(script.Services)

---@class ClientApplication
---@field diContainer DIContainer
---@field services ClientApplicationServices
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ClientApplication
function Application.new(diContainer)
    local self = setmetatable({}, Application)
    self.diContainer = diContainer

    self.services = Services.new(diContainer)
    
    return self
end

function Application:init()
    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    local remoteEventService = shared.remoteEventService

    remoteEventService:connectToEvents({
        
        ---@param eventData eventData
        [shared.constants.REMOTE_EVENTS.UPDATE_PLAYER_DATA] = function(eventData)
            print(eventData)
            self.services.playerService:updatePlayerData(eventData.data)
        end
    })

    self.services.playerService:callUpdatePlayerData()
end

return Application
