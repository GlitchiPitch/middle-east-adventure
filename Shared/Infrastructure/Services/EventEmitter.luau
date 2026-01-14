---@class EventEmitter
---@field _listeners table<string, function[]>
---@field diContainer DIContainer
local EventEmitter = {}
EventEmitter.__index = EventEmitter

---@param diContainer DIContainer
---@return EventEmitter
function EventEmitter.new(diContainer)
	local self = setmetatable({}, EventEmitter)
	self.diContainer = diContainer
	self._listeners = {}
	return self
end

---@class EntityEventData
---@field entityType string
---@field entityId string | number
---@field changes table?

--- Публикует событие
---@param eventName '"EntityUpdated"' | '"EntityDeleted"' | '"EntityCreated"'
---@param data EntityEventData
function EventEmitter:emit(eventName, data)
	if not self._listeners[eventName] then
		return
	end

	for _, listener in ipairs(self._listeners[eventName]) do
		local success, err = pcall(listener, data)
		if not success then
			warn(string.format("Error in event listener for %s: %s", eventName, err))
		end
	end
end

--- Подписывается на событие
---@param eventName '"EntityUpdated"' | '"EntityDeleted"' | '"EntityCreated"'
---@param listener function
---@return function -- функция для отписки
function EventEmitter:on(eventName, listener)
	if not self._listeners[eventName] then
		self._listeners[eventName] = {}
	end

	table.insert(self._listeners[eventName], listener)

	-- Возвращаем функцию для отписки
	return function()
		for i, registeredListener in ipairs(self._listeners[eventName]) do
			if registeredListener == listener then
				table.remove(self._listeners[eventName], i)
				break
			end
		end
	end
end

--- Удаляет все слушатели для события
---@param eventName string
function EventEmitter:removeAllListenersForEvent(eventName)
	self._listeners[eventName] = nil
end

--- Удаляет все слушатели
function EventEmitter:removeAllListeners()
	self._listeners = {}
end

return EventEmitter
