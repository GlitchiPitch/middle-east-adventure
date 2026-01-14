---@class ServerAddExperience
---@field attributesRepository ServerAttributesRepository
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local AddExperience = {}
AddExperience.__index = AddExperience

---@param diContainer DIContainer
---@return ServerAddExperience
function AddExperience.new(diContainer)
	local self = setmetatable({}, AddExperience)
	self.diContainer = diContainer
	return self
end

function AddExperience:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")

	self.attributesRepository = infrastructure.attributesRepository
	self.playerService = application.services.playerService
	self.constants = shared.constants
end

---@param player Player
---@param expAmount number
function AddExperience:execute(player, expAmount)
	local playerEntity = self.playerService:getPlayerEntity(player)
	self.attributesRepository:addExp(playerEntity, expAmount)
	self.playerService:updatePlayerData(player)
end

return AddExperience