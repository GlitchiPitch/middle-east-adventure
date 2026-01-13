local Players = game:GetService("Players")
local Services = require(script.Services)
local Handlers = require(script.Handlers)
local UseCases = require(script.UseCases)
local Controllers = require(script.Controllers)

---@class ServerApplication
---@field diContainer DIContainer
---@field services ServerApplicationServices
---@field handlers ServerApplicationHandlers
---@field controllers ServerControllers
---@field useCases ServerUseCases
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ServerApplication
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.diContainer = diContainer
	self.services = Services.new(diContainer)
	self.handlers = Handlers.new()
	self.useCases = UseCases.new(diContainer)
	self.controllers = Controllers.new(diContainer)
	return self
end

function Application:init()
	---@param player Player
	local function onPlayerAdded(player)
		self.services.playerService:onPlayerAdded(player)
	end

	---@param player Player
	local function onPlayerRemoving(player)
		self.services.playerService:onPlayerRemoving(player)
	end

	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	local remoteEventService = shared.remoteEventService

	remoteEventService:connectToEvents({
		---@param player Player
		---@param _ eventData
		[shared.constants.REMOTE_EVENTS.UPDATE_PLAYER_DATA] = function(player, _)
			self.services.playerService:updatePlayerData(player)
		end,

		---@param player Player
		---@param eventData eventData
		[shared.constants.REMOTE_EVENTS.CLICK_INVENTORY_ITEM] = function(player, eventData)
			self.services.inventoryService:clickItem(player, eventData.data)
			self.services.playerService:updatePlayerData(player)
		end,

		[shared.constants.REMOTE_EVENTS.EQUIP_ITEM] = function(player, eventData)
			self.services.equipmentService:equipItem(player, eventData.data)
		end,
		
		[shared.constants.REMOTE_EVENTS.TOOL_ACTIVATED] = function(player, eventData)
			local needUpdate = self.services.toolService:activate(player)
			if needUpdate then
				self.services.playerService:updatePlayerData(player)
			end
		end,

		[shared.constants.REMOTE_EVENTS.PICKUP_LOOT] = function(player, eventData)
			self.services.lootService:pickupLoot(player, eventData.data)
			self.services.playerService:updatePlayerData(player)
		end,

		[shared.constants.REMOTE_EVENTS.USE_LECTERN] = function(player, eventData)
			self.services.lecternService:useLectern(player, eventData.data)
			self.services.playerService:updatePlayerData(player)
		end,

		[shared.constants.REMOTE_EVENTS.TOGGLE_SPRINT] = function(player, eventData)
			self.controllers.playerController:toggleSprint(player, eventData.data)
		end,
	})

	self.services:init()
	self.useCases:init()
	self.controllers:init()

	Players.PlayerRemoving:Connect(onPlayerRemoving)
	Players.PlayerAdded:Connect(onPlayerAdded)
end

return Application
