local Players = game:GetService("Players")
-- local CollectionService = game:GetService("CollectionService")
--
---@alias _uiNames '"inventory"' | '"combat"' | '"startingScreen"' | '"misc"' | '"primary"' | '"trade"'

---@class UIManager
---@field _mainUI ScreenGui
---@field startingScreen Folder
---@field _currentScreen Folder
---@field inventory Folder
---@field primary Folder
---@field trade Folder
---@field misc Folder
local UIManager = {}
UIManager.__index = UIManager

---@return UIManager
function UIManager.new()
	local self = setmetatable({}, UIManager)
	self.player = Players.LocalPlayer
	self._mainUI = self.player.PlayerGui:WaitForChild("MainUI")
	self.startingScreen = self._mainUI.StartingScreen
	self.inventory = self._mainUI.Inventory
	self.primary = self._mainUI.Primary
	self.trade = self._mainUI.Trade
	self.misc = self._mainUI.Misc
	self._currentScreen = nil

	return self
end

function UIManager:init()
	-- local animatedButton = CollectionService:GetTagged("")
	-- CollectionService:GetInstanceAddedSignal():Connect()
	-- CollectionService:GetInstanceRemovedSignal():Connect()
end

---@param name _uiNames
function UIManager:showUI(name)
	for _, v in self[name]:GetChildren() do
		v.Visible = true
	end
end

---@param name _uiNames
function UIManager:setCurrentScreen(name)
	if self._currentScreen and self._currentScreen ~= name then
		self:hideUI(self._currentScreen)
	end

	self._currentScreen = name
	self:showUI(name)
end

---@param name _uiNames
function UIManager:hideUI(name)
	for _, v in self[name]:GetChildren() do
		v.Visible = false
	end
end

return UIManager
