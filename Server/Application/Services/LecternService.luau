---@class ServerLecternService
---@field diContainer DIContainer
---@field playerRepository ServerPlayerRepository
local LecternService = {}
LecternService.__index = LecternService

---@param diContainer DIContainer
---@return ServerLecternService
function LecternService.new(diContainer)
	local self = setmetatable({}, LecternService)
	self.diContainer = diContainer
	return self
end

function LecternService:init()
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.playerRepository
end

---@param player Player
---@param command UseLecternCommand
function LecternService:useLectern(player, command)
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	if not table.find(playerEntity.playerProgress.usedLectern, command.lectern.Name) then
		table.insert(playerEntity.playerProgress.usedLectern, command.lectern.Name)
		playerEntity.attributes.ancientKnowledge += 5
	end
end

return LecternService
