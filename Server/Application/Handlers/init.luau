local Ragdoll = require(script.Ragdoll)

---@class ServerApplicationHandlers
---@field ragdoll RagdollHandler
local Handlers = {}
Handlers.__index = Handlers

---@return ServerApplicationHandlers
function Handlers.new()
    local self = setmetatable({}, Handlers)
    self.ragdoll = Ragdoll.new()
    return self
end

return Handlers