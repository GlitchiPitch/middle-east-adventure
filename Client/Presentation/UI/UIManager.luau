local Players = game:GetService("Players")

---@alias _uiNames2 '"smith"' | '"inventory"' | '"combat"' |
---@alias _uiNames3 '"startingScreen"' | '"misc"' | '"primary"' | '"trade"' | '"alchemy"' | '"dialog"'
---@alias _uiNames _uiNames2 | _uiNames3

---@class UIManager
---@field _mainUI ScreenGui
---@field startingScreen Folder
---@field _currentScreen Folder
---@field inventory Folder
---@field primary Folder
---@field alchemy Folder
---@field trade Folder
---@field dialog Folder
---@field misc Folder
---@field smith Folder
local UIManager = {}
UIManager.__index = UIManager

---@return UIManager
function UIManager.new()
	local self = setmetatable({}, UIManager)
	self.player = Players.LocalPlayer
	self._mainUI = self.player.PlayerGui:WaitForChild("MainUI")
	self.startingScreen = self._mainUI.StartingScreen
	self.inventory = self._mainUI.Inventory
	self.alchemy = self._mainUI.Alchemy
	self.primary = self._mainUI.Primary
	self.trade = self._mainUI.Trade
	self.misc = self._mainUI.Misc
	self.dialog = self._mainUI.Dialog
	self.smith = self._mainUI.Smith
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
