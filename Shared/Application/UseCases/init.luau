---@class ClickItemUseCase
---@field diContainer DIContainer
local ClickItemUseCase = {}
ClickItemUseCase.__index = ClickItemUseCase

---@param diContainer DIContainer
---@return ClickItemUseCase
function ClickItemUseCase.new(diContainer)
    local self = setmetatable({}, ClickItemUseCase)
    self.diContainer = diContainer
    return self
end

function ClickItemUseCase:execute(command)
    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    shared.remoteEventService:fireServer({
        eventName = shared.constants.REMOTE_EVENTS.CLICK_INVENTORY_ITEM,
        data = command,
    })
end

---@class SharedUseCases
---@field clickItemUseCase ClickItemUseCase
local UseCases = {}
UseCases.__index = UseCases

---@param diContainer DIContainer
---@return SharedUseCases
function UseCases.new(diContainer)
    local self = setmetatable({}, UseCases)
    self.ClickItemUseCase = ClickItemUseCase.new(diContainer)
    return self
end

return UseCases
