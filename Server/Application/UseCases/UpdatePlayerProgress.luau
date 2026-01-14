---@class ServerUpdatePlayerProgress
---@field playerRepository ServerPlayerRepository
---@field playerService ServerPlayerService
---@field constants Constants
local UpdatePlayerProgress = {}
UpdatePlayerProgress.__index = UpdatePlayerProgress

---@param playerRepository ServerPlayerRepository
---@param playerService ServerPlayerService
---@param constants Constants
---@return ServerUpdatePlayerProgress
function UpdatePlayerProgress.new(playerRepository, playerService, constants)
	local self = setmetatable({}, UpdatePlayerProgress)
	self.playerRepository = playerRepository
	self.playerService = playerService
	self.constants = constants
	return self
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