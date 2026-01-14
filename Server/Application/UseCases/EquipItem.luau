---@class ServerEquipItem
---@field equipmentRepository ServerEquipmentRepository
---@field toolService ServerToolService
---@field playerService ServerPlayerService
---@field constants Constants
---@field unitOfWork UnitOfWork
---@field diContainer DIContainer
local EquipItem = {}
EquipItem.__index = EquipItem

---@param diContainer DIContainer
---@return ServerEquipItem
function EquipItem.new(diContainer)
	local self = setmetatable({}, EquipItem)
	self.diContainer = diContainer
	return self
end

function EquipItem:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	---@type ServerApplication
	local application = self.diContainer:resolve("Application")

	self.unitOfWork = shared.infrastructure.unitOfWork
	self.equipmentRepository = infrastructure.equipmentRepository
	self.toolService = application.services.toolService
	self.playerService = application.services.playerService
	self.constants = shared.constants
end

---@param player Player
---@param command EquipItemCommand
function EquipItem:execute(player, command)
	local playerEntity = self.playerService:getPlayerEntity(player)

	-- Начинаем транзакцию для атомарной операции экипировки
	self.unitOfWork:beginTransaction()

	local success = false
	local errorMessage = ""

	local successTransaction, transactionError = pcall(function()
		if playerEntity.equipment.slots[command.slotIndex] then
			if playerEntity.equipment.equippedItem then
				playerEntity.equipment:equipItem(nil)
			else
				playerEntity.equipment:equipItem(playerEntity.equipment.slots[command.slotIndex])
			end

			self:_setToolToPlayer(playerEntity)
			success = true
		else
			error("Invalid equipment slot: " .. command.slotIndex)
		end
	end)

	if not successTransaction then
		errorMessage = transactionError
	end

	if success then
		-- Фиксируем изменения
		self.unitOfWork:commit()
		self.playerService:updatePlayerData(player)
		print("Item equipped successfully in slot: " .. command.slotIndex)
	else
		-- Откатываем изменения при ошибке
		self.unitOfWork:rollback()
		error("Failed to equip item: " .. errorMessage)
	end
end

---@param playerEntity PlayerEntity
function EquipItem:_setToolToPlayer(playerEntity)
	if playerEntity.equipment.equippedItem then
		self.toolService:equipItem(playerEntity)
	else
		self.toolService:unequipItem(playerEntity)
	end
end

return EquipItem
