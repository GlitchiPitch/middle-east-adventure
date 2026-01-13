---@class ServerToolService
---@field diContainer DIContainer
---@field assets Assets
---@field constants Constants
---@field playerService ServerPlayerService
local ToolService = {}
ToolService.__index = ToolService

---@param diContainer DIContainer
---@return ServerToolService
function ToolService.new(diContainer)
	local self = setmetatable({}, ToolService)
	self.diContainer = diContainer
	return self
end

function ToolService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")

	self.assets = shared.assets
	self.constants = shared.constants
	self.sharedData = shared.data
	self.playerService = application.services.playerService
end

---@param player Player
function ToolService:activate(player)
	local playerEntity = self.playerService:getPlayerEntity(player)
	if playerEntity.equipment.equippedItem then
		local itemData = self.sharedData:getItemData(playerEntity.equipment.equippedItem)
		warn(itemData)
		if itemData.type == self.constants.ITEM_TYPES.FOOD then
			if playerEntity.inventory[itemData.name].amount > 0 then
				if itemData.effect and itemData.effect.action == "restore" then
					for i, v in itemData.effect.stats do
						playerEntity.stats[i].current = math.max(
							playerEntity.stats[i].current + (playerEntity.stats[i].current * v),
							playerEntity.stats[i].max
						)
					end
				end

				playerEntity.equipment:setSlot({
					itemName = itemData.name,
					state = "remove",
				})

				playerEntity.inventory:removeItem({
					name = itemData.name,
					data = {
						amount = playerEntity.inventory[itemData.name].amount - 1,
					},
				})

				self:unequipItem(playerEntity)
				return true
			end
		end
	end

	return false
end

function ToolService:getToolItem(name)
	return self.assets:getAsset(name)
end

function ToolService:equipItem(playerEntity)
	local character = playerEntity._instance.Character
	local itemTool = self:getToolItem(playerEntity.equipment.equippedItem)
	character.Humanoid:EquipTool(itemTool)
end

function ToolService:unequipItem(playerEntity)
	local character = playerEntity._instance.Character
	character.Humanoid:UnequipTools()
end

return ToolService
