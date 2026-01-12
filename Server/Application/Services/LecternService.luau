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
end

return LecternService
