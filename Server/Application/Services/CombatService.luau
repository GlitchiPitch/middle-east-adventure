---@class ServerApplicationCombatService
local CombatService = {}
CombatService.__index = CombatService

---@return ServerApplicationCombatService
function CombatService.new()
    local self = setmetatable({}, CombatService)
    return self
end

return CombatService
