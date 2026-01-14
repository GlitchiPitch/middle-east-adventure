---@class ServerUpdatePlayerProgress
---@field playerRepository ServerPlayerRepository
---@field playerService ServerPlayerService
---@field constants Constants
---@field diContainer DIContainer
local UpdatePlayerProgress = {}
UpdatePlayerProgress.__index = UpdatePlayerProgress

---@param diContainer DIContainer
---@return ServerUpdatePlayerProgress
function UpdatePlayerProgress.new(diContainer)
	local self = setmetatable({}, UpdatePlayerProgress)
	self.diContainer = diContainer
	return self
end

function UpdatePlayerProgress:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")

	self.playerRepository = infrastructure.playerRepository
	self.playerService = application.services.playerService
	self.constants = shared.constants
end

---@param player Player
---@param lecternId string
function UpdatePlayerProgress:addUsedLectern(player, lecternId)
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	local progress = playerEntity:getPlayerProgress()

	-- Check if already used
	for _, usedId in ipairs(progress.usedLectern) do
		if usedId == lecternId then
			return
		end
	end

	table.insert(progress.usedLectern, lecternId)
	self.playerService:updatePlayerData(player)
end

return UpdatePlayerProgress
