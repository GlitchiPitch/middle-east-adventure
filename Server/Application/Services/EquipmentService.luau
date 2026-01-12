---@class ServerEquipmentService
---@field diContainer DIContainer
---@field playerService ServerPlayerService
---@field assets Assets
local EquipmentService = {}
EquipmentService.__index = EquipmentService

---@param diContainer DIContainer
---@return ServerEquipmentService
function EquipmentService.new(diContainer)
	local self = setmetatable({}, EquipmentService)
	self.diContainer = diContainer
	return self
end

function EquipmentService:init()
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")
	---@type Shared
	local shared = self.diContainer:resolve("Shared")

	self.sharedData = shared.data
	self.playerService = application.services.playerService
	self.assets = shared.assets
end

---@param player Player
---@param command EquipItemCommand
function EquipmentService:equipItem(player, command)
	local playerEntity = self.playerService:getPlayerEntity(player)
	if playerEntity.equipment.slots[command.slotIndex] then
		if playerEntity.equipment.equippedWeapon then
			playerEntity.equipment:equipWeapon(nil)
		else
			playerEntity.equipment:equipWeapon(playerEntity.equipment.slots[command.slotIndex])
		end

		self:setToolToPlayer(playerEntity)
	end
end

---@param playerEntity PlayerEntity
function EquipmentService:setToolToPlayer(playerEntity)
	local character = playerEntity._instance.Character
	if playerEntity.equipment.equippedWeapon then
		local weaponTool = self.assets.Weapons:getWeaponTool(playerEntity.equipment.equippedWeapon)
		character.Humanoid:EquipTool(weaponTool)
	else
        character.Humanoid:UnequipTools()
	end
end

return EquipmentService
