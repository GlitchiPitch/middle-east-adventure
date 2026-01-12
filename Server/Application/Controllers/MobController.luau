---@class ServerMobController
---@field diContainer DIContainer
---@field _updateTime number
---@field _mobZones Part[]
---@field _deltaTime number
local MobController = {}
MobController.__index = MobController

---@param diContainer DIContainer
---@return ServerMobController
function MobController.new(diContainer)
	local self = setmetatable({}, MobController)
	self.diContainer = diContainer
	self._updateTime = 50
	self._deltaTime = 0
	self._mobZones = {}
	return self
end

function MobController:init()
	---@type SharedDomain
	local domain = self.diContainer:resolve("Domain")

	for _, v in workspace.Workspace.MobZones:GetChildren() do
		domain.Zone.new({
			type = "Mod",
			_instance = v,
		})
	end
end

function MobController:update(deltaTime)
	self._deltaTime += deltaTime
	if self._deltaTime >= self._updateTime then
		for i, v in self._mobZones do
            print(i,v)
		end
	end
end

return MobController
