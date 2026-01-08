local UserInputService = game:GetService("UserInputService")
---@class InputService
---@field diContainer DIContainer
local InputService = {}
InputService.__index = InputService

---@param diContainer DIContainer
---@return InputService
function InputService.new(diContainer)
	local self = setmetatable({}, InputService)
	self.diContainer = diContainer
	return self
end

function InputService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	local config = shared.config

	local function onInputBegan(input, gameProccessed)
		if gameProccessed then
			return
		end

		local playerState = application.services.playerService:getPlayerState()
		if input.UserInputType == config.Client.Control.MainAction then
			if playerState == "Weapon" then
				application.services.toolService:activated()
			elseif playerState == "Loot" then
			elseif playerState == "NPC" then
			end
		elseif input.UserInputType == config.Client.Control.SecondAction then
			if playerState == "Weapon" then
				application.services.toolService:block(true)
			end
		elseif input.KeyCode == config.Client.Control.FreeMouse then
			application.services.cameraService:toggleFreeMouse()
		elseif input.KeyCode == config.Client.Control.TargetCamera then
			application.services.camerService:toggleTargetCamera()
		end
	end

	local function onInputEnded(input, gameProccessed)
		if gameProccessed then
			return
		end

		if input.UserInputType == config.Client.Control.SecondAction then
			-- animTracks.oneHandedBlock:Stop()
			local playerState = application.services.playerService:getPlayerState()
			if playerState == "Weapon" then
				application.services.toolService:block(false)
			end
		end
	end

    local function onInputChanged(input, gameProccessed)
        if gameProccessed then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement then
            application.services.camerService:mouseMovement(input)
        end
    end

	self._inputBegan = UserInputService.InputBegan:Connect(onInputBegan)
	self._inputEnded = UserInputService.InputEnded:Connect(onInputEnded)
    self._inputChanged = UserInputService.InputChanged:Connect(onInputChanged)
end

return InputService
