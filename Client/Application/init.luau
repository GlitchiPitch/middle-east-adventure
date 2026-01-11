local Players = game:GetService("Players")
local Services = require(script.Services)
local Controllers = require(script.Controllers)
local UseCases = require(script.UseCases)

---@class ClientApplication
---@field diContainer DIContainer
---@field services ClientApplicationServices
---@field controllers ClientControllers
---@field useCases ClientUseCases
---@field player Player
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ClientApplication
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.diContainer = diContainer
	self.player = Players.LocalPlayer
	self.services = Services.new(diContainer)
	self.controllers = Controllers.new(diContainer)
	self.useCases = UseCases.new(diContainer)
	return self
end

function Application:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	local remoteEventService = shared.remoteEventService

	local function onCharacterAdded(_)
		---@type ClientApplication
		local application = self.diContainer:resolve("Application")
		application.services.toolService:checkCharacterTool()
		application.services.animationService:setupAnimationToCharacter()
		application.controllers.cameraController:init()
		application.controllers.sprintController:init()
		application.services.playerService:toggleRobloxControl(false)
	end

	remoteEventService:connectToEvents({
		---@param eventData eventData
		[shared.constants.REMOTE_EVENTS.UPDATE_PLAYER_DATA] = function(eventData)
			self.services.playerService:updatePlayerData(eventData.data)
		end,
	})

	self.services:init()
	self.useCases:init()
	self.controllers:init()

	if self.player.Character then
		onCharacterAdded(self.player.Character)
	else
		self.player.CharacterAdded:Connect(onCharacterAdded)
	end

	self.services.playerService:callUpdatePlayerData()
end

return Application
