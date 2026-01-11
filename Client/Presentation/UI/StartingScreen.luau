---@class StartingScreen
---@field body Frame
---@field donateButton TextButton
---@field playButton TextButton
---@field diContainer DIContainer
local StartingScreen = {}
StartingScreen.__index = StartingScreen

---@param diContainer DIContainer
---@return StartingScreen
function StartingScreen.new(diContainer)
	local self = setmetatable({}, StartingScreen)
	self.diContainer = diContainer
	return self
end

function StartingScreen:init()
	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")
	local screen = presentation.ui.uiManager.startingScreen

	self.body = screen.Body
	self.donateButton = self.body.DonateButton
	self.playButton = self.body.PlayButton

	presentation.ui.uiManager:setCurrentScreen("startingScreen")
	self:_setup()
end

function StartingScreen:_setup()
	local function _onClick()
		self:_onPlayClick()
	end

	self.playButtonConn = self.playButton.MouseButton1Click:Connect(_onClick)
end

function StartingScreen:_onPlayClick()
	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	---@type Presentation
	local presentation = self.diContainer:resolve("Presentation")

	application.controllers.cameraController:activateDefaultCamera()
	application.services.playerService:toggleRobloxControl(true)
	presentation.ui.uiManager:setCurrentScreen("primary")
	self.playButtonConn:Disconnect()
end

return StartingScreen
