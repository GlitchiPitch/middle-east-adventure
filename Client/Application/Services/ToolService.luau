local Players = game:GetService("Players")
---@class ClientToolService
---@field _currentTool Tool
---@field diContainer DIContainer
---@field debounce boolean
---@field attackIndex number
---@field lastTime number
local ToolService = {}
ToolService.__index = ToolService

---@param diContainer DIContainer
---@return ClientToolService
function ToolService.new(diContainer)
	local self = setmetatable({}, ToolService)
	self.diContainer = diContainer
	self._currentTool = nil
	self.player = Players.LocalPlayer

	self.debounce = false
	self.attackIndex = 1
	self.lastTime = nil
	self.maxCombo = 4 -- @TODO: get value from animationService

	return self
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
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	self._currentTool = currentTool

	application.services.playerService:setPlayerState("Weapon")
	application.services.animationService:playAnimation("OneHandedIdle")
end

function ToolService:_removeTool()
	self._currentTool = nil
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	application.services.playerService:setPlayerState("")
	application.services.animationService:stopAnimation("OneHandedIdle")
end

function ToolService:activated()
	if self.debounce == true then
		return
	end

	self.debounce = true

	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	local animationService = application.services.animationService

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

	if animationService.animTracks["OneHanded" .. self.attackIndex] then
		animationService.animTracks["OneHanded" .. self.attackIndex]:Play()
		task.wait(animationService.animTracks["OneHanded" .. self.attackIndex].Length)
	else
		task.wait(0.5)
	end

	self.debounce = false
end

---@param setBlock boolean
function ToolService:block(setBlock)
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	local animationService = application.services.animationService
	if setBlock then
		animationService:playAnimation("OneHandedBlock")
	else
		animationService:stopAnimation("OneHandedBlock")
	end
end

return ToolService
