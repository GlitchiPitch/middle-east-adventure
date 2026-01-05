---@class PromptService
local PromptService = {}
PromptService.__index = PromptService

---@return PromptService
function PromptService.new()
    local self = setmetatable({}, PromptService)
    return self
end

return PromptService