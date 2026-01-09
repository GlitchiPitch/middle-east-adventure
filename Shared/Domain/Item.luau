---@class ItemEntity
local Item = {}
Item.__index = Item

---@return ItemEntity
function Item.new()
    local self = setmetatable({}, Item)
    return self
end

return Item