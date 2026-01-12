---@class ServerToolService
---@field diContainer DIContainer
local ToolService = {}
ToolService.__index = ToolService

---@param diContainer DIContainer
---@return ServerToolService
function ToolService.new(diContainer)
    local self = setmetatable({}, ToolService)
    self.diContainer = diContainer
    return self
end

function ToolService:init()
    
end

---@param player Player
function ToolService:activate(player)
    print(player)
end

return ToolService