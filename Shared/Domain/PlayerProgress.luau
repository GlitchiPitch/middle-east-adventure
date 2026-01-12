---@class PlayerProgressEntity
local PlayerProgress = {}
PlayerProgress.__index = PlayerProgress

---@return PlayerProgressEntity
function PlayerProgress.new(data)
	local self = setmetatable({}, PlayerProgress)
	self.usedLectern = data.usedLectern or {}
	return self
end

function PlayerProgress:toData()
    return self
end

return PlayerProgress
