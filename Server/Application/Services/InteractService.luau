---@class ServerInteractService
local InteractService = {}
InteractService.__index = InteractService

---@return ServerInteractService
function InteractService.new()
    local self = setmetatable({}, InteractService)
    return self
end

function InteractService:init()
    
end

function InteractService:activate(player, command)
    local currentTarget = self.targetController:getCurrentTarget()
	if currentTarget:HasTag(self.constants.PLAYER_STATES.INTERACT) then
		local interactType = currentTarget:GetAttribute(self.constants.ATTRIBUTES.INTERACT_TYPE)

		self.playerService:toggleRobloxControl(false)

		if currentTarget:FindFirstChild("PlayerPoint") then
			self.playerService:moveTo(currentTarget)
		end

		if interactType == self.constants.INTERACT_TYPES.ALCHEMY then
			self.alchemyService:start(currentTarget)
			self.playerService:setPlayerState(self.constants.PLAYER_STATES.ALCHEMY)
		elseif interactType == self.constants.INTERACT_TYPES.LECTERN then
			self.lecternService:start(currentTarget)
			self.playerService:setPlayerState(self.constants.PLAYER_STATES.LECTERN)
		elseif interactType == self.constants.INTERACT_TYPES.SMITH then
			self.smithService:start(currentTarget)
			self.playerService:setPlayerState(self.constants.PLAYER_STATES.SMITH)
		elseif interactType == self.constants.INTERACT_TYPES.CHEST then
			self.chestService:openChest(currentTarget)
			self.playerService:setPlayerState(self.constants.PLAYER_STATES.CHEST)
		elseif interactType == self.constants.INTERACT_TYPES.LOOT then
			self.lootService:pickupLoot(currentTarget)
			self.playerService:setPlayerState(self.constants.PLAYER_STATES.LOOT)
		end
	end
end

return InteractService