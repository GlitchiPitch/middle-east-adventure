local Players = game:GetService("Players")
---@class ClientToolService
---@field _currentTool Tool
---@field diContainer DIContainer
---@field debounce boolean
---@field attackIndex number
---@field lastTime number
---@field playerService ClientPlayerService
---@field animationService AnimationService
---@field constants Constants
---@field remoteEventService RemoteEventService
---@field isEquipped boolean
local ToolService = {}
ToolService.__index = ToolService

---@param diContainer DIContainer
---@return ClientToolService
function ToolService.new(diContainer)
	local self = setmetatable({}, ToolService)
	self.diContainer = diContainer
	self._currentTool = nil
	self.player = Players.LocalPlayer
	self.isEquipped = false
	self.debounce = false
	self.attackIndex = 1
	self.lastTime = nil
	self.maxCombo = 4 -- @TODO: get value from animationService

	return self
end

function ToolService:init()
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.constants = shared.constants
	self.remoteEventService = shared.remoteEventService
	self.playerService = application.services.playerService
	self.animationService = application.services.animationService
end

function ToolService:checkCharacterTool()
	local character = self.player.Character
	---@param child Instance
	local function _onChildAdded(child)
		if child:IsA("Tool") then
			self:_setupTool(child)
		end
	end
	---@param child Instance
	local function _onChildRemoved(child)
		if child:IsA("Tool") then
			self:_removeTool()
		end
	end
	character.ChildAdded:Connect(_onChildAdded)
	character.ChildRemoved:Connect(_onChildRemoved)
end

function ToolService:_setupTool(currentTool)
	self.isEquipped = true
	self._currentTool = currentTool
	self.animationService:playAnimation("OneHandedIdle")
end

function ToolService:_removeTool()
	self._currentTool = nil
	self.lastTime = nil
	self.isEquipped = false
	self.animationService:stopAnimation("OneHandedIdle")
end

function ToolService:activated()
	if not self.isEquipped then
		return
	end

	if self.debounce then
		return
	end

	self.debounce = true

	if self.lastTime == nil then
		print("First TIme")
	elseif os.time() - 2 > self.lastTime then
		self.attackIndex = 1
	else
		if self.attackIndex == self.maxCombo then
			self.attackIndex = 1
		else
			self.attackIndex = math.min(self.attackIndex + 1, self.maxCombo)
		end
	end

	self.lastTime = os.time()

	if self.animationService.animTracks["OneHanded" .. self.attackIndex] then
		self.animationService.animTracks["OneHanded" .. self.attackIndex]:Play()
		task.wait(self.animationService.animTracks["OneHanded" .. self.attackIndex].Length)
	else
		task.wait(0.5)
	end

	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.TOOL_ACTIVATED,
		data = {},
	})

	self.debounce = false
end

---@param setBlock boolean
function ToolService:block(setBlock)
	if setBlock then
		self.animationService:playAnimation("OneHandedBlock")
	else
		self.animationService:stopAnimation("OneHandedBlock")
	end
end

return ToolService
