local UserInputService = game:GetService("UserInputService")
---@class InputService
---@field diContainer DIContainer
---@field config Config
---@field eventBus EventBus
---@field playerService ClientPlayerService
---@field dialogService DialogService
---@field alchemyService ClientAlchemyService
---@field toolService ClientToolService
---@field interactService ClientInteractService
---@field sprintController SprintController
---@field cameraController CameraController
---@field inventoryService ClientInventoryService
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

	self.dialogService = application.services.dialogService
	self.interactService = application.services.interactService
	self.sprintController = application.controllers.sprintController
	self.cameraController = application.controllers.cameraController
	self.toolService = application.services.toolService
	self.inventoryService = application.services.inventoryService

	--@TODO: current block input method is not correct need refactor
	self.alchemyService = application.services.alchemyService
	self.smithService = application.services.smithService

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
		if self.alchemyService.isActive or self.smithService.isActive then
			return
		end

		if self.toolService.isEquipped then
			self.toolService:activated()
			return
		end

		if playerState == "NPC" then
			self.dialogService:activateDialog()
		elseif playerState == "Interact" then
			self.interactService:activate()
		end
	elseif input.UserInputType == self.config.Client.Control.SecondAction then
		if self.toolService.isEquipped then
			self.toolService:block(true)
		end
	elseif input.KeyCode == self.config.Client.Control.FreeMouse then
		self.cameraController:toggleFreeMouse()
	elseif input.KeyCode == self.config.Client.Control.TargetCamera then
		self.cameraController:toggleTargetCamera()
	elseif input.KeyCode == self.config.Client.Control.InventoryKey then
		self.inventoryService:toggleInventoryView()
	end

	if input.KeyCode == self.config.Client.Control.RunKey then
		self.sprintController:run()
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
		self.sprintController:walk()
	end
end

function InputService:_inputChanged(input, gameProccessed)
	if gameProccessed then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseMovement then
		self.cameraController:mouseMovement(input)
	end
end

return InputService
