local StarterGui = game:GetService("StarterGui")
---@class ClientApplicationInventoryService
---@field diContainer DIContainer
local InventoryService = {}
InventoryService.__index = InventoryService

---@param diContainer DIContainer
---@return ClientApplicationInventoryService
function InventoryService.new(diContainer)
    local self = setmetatable({}, InventoryService)
    self.diContainer = diContainer
    return self
end

function InventoryService:init()
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
end

function InventoryService:clickItem(itemData)
    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    local command = shared.application.commands.ClickItemCommand.new(itemData.name)
    shared.application.useCases.clickItemUseCase:execute(command)
end

function InventoryService:getInventory()
    ---@type ClientApplication
    local application = self.diContainer:resolve("Application")
    local playerEntity = application.services.playerService:getPlayerEntity()
    return playerEntity.inventory
end

return InventoryService