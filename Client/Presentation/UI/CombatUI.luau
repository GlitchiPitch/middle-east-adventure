---@class CombatUI
---@field diContainer DIContainer
local CombatUI = {}
CombatUI.__index = CombatUI

---@param diContainer DIContainer
---@return CombatUI
function CombatUI.new(diContainer)
    local self = setmetatable({}, CombatUI)
    self.diContainer = diContainer
    return self
end

---@param damageData damageData
function CombatUI:showDamagePopup(damageData)
    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    local popup = Instance.new("BillboardGui")

    task.delay(shared.config.Client.PopupLifeTime, function()
        popup:Destroy()
    end)
end

return CombatUI
