local UserInputService = game:GetService("UserInputService")
---@class InputService
---@field diContainer DIContainer
---@field config Config
---@field eventBus EventBus
---@field playerService ClientApplicationPlayerService
---@field lootService ClientLootService
---@field dialogService DialogService
---@field alchemyService ClientAlchemyService
---@field toolService ClientToolService
---@field interactService ClientInteractService
---@field sprintService SprintService
---@field cameraService CameraService
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

	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	self.config = shared.config
	self.eventBus = shared.eventBus
	self.playerService = application.services.playerService
	self.lootService = application.services.lootService
	self.dialogService = application.services.dialogService
	self.interactService = application.services.interactService
	self.sprintService = application.services.sprintService
	self.cameraService = application.services.cameraService
	self.toolService = application.services.toolService
	self.alchemyService = application.services.alchemyService

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

	local playerState = self.playerService:getPlayerState()
	if input.UserInputType == self.config.Client.Control.MainAction then
		
		if self.alchemyService.isActive then
			return
		end

		if self.toolService.isEquipped then
			self.toolService:activated()
			return
		end

		if playerState == "Loot" then
			self.lootService:pickupLoot()
		elseif playerState == "NPC" then
			self.dialogService:activateDialog()
		elseif playerState == "Interact" then
			self.interactService:activate()
		end
	elseif input.UserInputType == self.config.Client.Control.SecondAction then
		if self.toolService.isEquipped then
			self.toolService:block(true)
		end
	elseif input.KeyCode == self.config.Client.Control.FreeMouse then
		self.cameraService:toggleFreeMouse()
	elseif input.KeyCode == self.config.Client.Control.TargetCamera then
		self.cameraService:toggleTargetCamera()
	end

	if input.KeyCode == self.config.Client.Control.RunKey then
		self.sprintService:run()
	end

	if table.find(self.config.Client.Control.EquippmentKeys, input.KeyCode) then
		self.eventBus:fire("pressEquipKey", input.KeyCode.Value)
	end
end

function InputService:_inputEnded(input, gameProccessed)
	if gameProccessed then
		return
	end

	if input.UserInputType == self.config.Client.Control.SecondAction then
		if self.toolService.isEquipped then
			self.toolService:block(false)
		end
	end

	if input.KeyCode == self.config.Client.Control.RunKey then
		self.sprintService:walk()
	end
end

function InputService:_inputChanged(input, gameProccessed)
	if gameProccessed then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseMovement then
		self.cameraService:mouseMovement(input)
	end
end

return InputService
