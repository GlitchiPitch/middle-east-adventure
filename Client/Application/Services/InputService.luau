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
	local function onInputBegan(input, gameProccessed)
		self:_inputBegan(input, gameProccessed)
	end

	local function onInputEnded(input, gameProccessed)
		self:_inputEnded(input, gameProccessed)
	end

	local function onInputChanged(input, gameProccessed)
		self:_inputChanged(input, gameProccessed)
	end

	self._inputBeganConn = UserInputService.InputBegan:Connect(onInputBegan)
	self._inputEndedConn = UserInputService.InputEnded:Connect(onInputEnded)
	self._inputChangedConn = UserInputService.InputChanged:Connect(onInputChanged)
end

---@param input InputObject
---@param gameProccessed any
function InputService:_inputBegan(input, gameProccessed)
	if gameProccessed then
		return
	end

	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	local config = shared.config
	local eventBus = shared.eventBus

	local playerState = application.services.playerService:getPlayerState()
	if input.UserInputType == config.Client.Control.MainAction then
		if playerState == "Weapon" then
			application.services.toolService:activated()
		elseif playerState == "Loot" then
			application.services.lootService:pickupLoot()
		elseif playerState == "NPC" then
			application.services.dialogService:activateDialog()
		elseif playerState == "Interact" then
			application.services.interactService:activate()
		end
	elseif input.UserInputType == config.Client.Control.SecondAction then
		if playerState == "Weapon" then
			application.services.toolService:block(true)
		end
	elseif input.KeyCode == config.Client.Control.FreeMouse then
		application.services.cameraService:toggleFreeMouse()
	elseif input.KeyCode == config.Client.Control.TargetCamera then
		application.services.cameraService:toggleTargetCamera()
	end

	if input.KeyCode == config.Client.Control.RunKey then
		application.services.sprintService:run()
	end

	if table.find(config.Client.Control.EquippmentKeys, input.KeyCode) then
		eventBus:fire("pressEquipKey", input.KeyCode.Value)
	end
end

function InputService:_inputEnded(input, gameProccessed)
	if gameProccessed then
		return
	end

	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	local config = shared.config

	if input.UserInputType == config.Client.Control.SecondAction then
		-- animTracks.oneHandedBlock:Stop()
		local playerState = application.services.playerService:getPlayerState()
		if playerState == "Weapon" then
			application.services.toolService:block(false)
		end
	end

	if input.KeyCode == config.Client.Control.RunKey then
		application.services.sprintService:walk()
	end
end

function InputService:_inputChanged(input, gameProccessed)
	if gameProccessed then
		return
	end

	---@type ClientApplication
	local application = self.diContainer:resolve("Application")

	if input.UserInputType == Enum.UserInputType.MouseMovement then
		application.services.cameraService:mouseMovement(input)
	end
end

return InputService
