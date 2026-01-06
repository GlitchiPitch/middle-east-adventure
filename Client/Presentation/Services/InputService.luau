local UserInputService = game:GetService("UserInputService")
---@class InputService
---@field diContainer DIContainer
local InputService = {}
InputService.__index = InputService

---@param diContainer DIContainer
---@return InputService
function InputService.new(diContainer)
    local self = setmetatable({}, InputService)
    return self
end

function InputService:init()
    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    local config = shared.config

    local function onInputBegan(input, gameProccesed) 
        
    end
    local function onInputEnded(input, gameProccesed) 
        
    end

    self._inputBegan = UserInputService.InputBegan:Connect(onInputBegan)
    self._inputEnded = UserInputService.InputEnded:Connect(onInputEnded)
    -- config.Client.Control.Action
end

return InputService
