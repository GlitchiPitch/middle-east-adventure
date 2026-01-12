---@class ServerLecternService
---@field diContainer DIContainer
---@field playerService ServerPlayerService
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
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")
	self.playerService = application.services.playerService
end

---@param player Player
---@param command UseLecternCommand
function LecternService:useLectern(player, command)
	local playerEntity = self.playerService:getPlayerEntity(player)
	if not table.find(playerEntity.playerProgress.usedLectern, command.lectern.Name) then
		table.insert(playerEntity.playerProgress.usedLectern, command.lectern.Name)
		playerEntity.attributes.ancientKnowledge += 5
	end
end

return LecternService
