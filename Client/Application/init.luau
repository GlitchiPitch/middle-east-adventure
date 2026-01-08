local Players = game:GetService("Players")
local Services = require(script.Services)

---@class ClientApplication
---@field diContainer DIContainer
---@field services ClientApplicationServices
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

	return self
end

function Application:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	local remoteEventService = shared.remoteEventService

	local function onCharacterAdded(character)
		---@type ClientApplication
		local application = self.diContainer:resolve("Application")
		application.services.toolService:checkCharacterTool(character)
		application.services.animationService:setupAnimationToCharacter(character)
		application.services.camerService:init()
	end

	remoteEventService:connectToEvents({

		---@param eventData eventData
		[shared.constants.REMOTE_EVENTS.UPDATE_PLAYER_DATA] = function(eventData)
			print(eventData)
			self.services.playerService:updatePlayerData(eventData.data)
		end,
	})

	self.services:init()

	if self.player.Character then
		onCharacterAdded(self.player.Character)
	else
		self.player.CharacterAdded:Connect(onCharacterAdded)
	end

	self.services.playerService:callUpdatePlayerData()
end

return Application
