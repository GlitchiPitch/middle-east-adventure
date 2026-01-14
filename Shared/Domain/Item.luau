---@class ItemEntity
---@field name string
---@field description string
---@field rarity string
---@field value number
---@field itemType string
---@field equippable boolean
---@field durability number
---@field maxDurability number
local Item = {}
Item.__index = Item

---@param data table
---@return ItemEntity
function Item.new(data)
    local self = setmetatable({}, Item)
    data = data or {}

    self.name = data.name or "Unknown Item"
    self.description = data.description or ""
    self.rarity = data.rarity or "common"
    self.value = data.value or 0
    self.itemType = data.itemType or "misc"
    self.equippable = data.equippable or false
    self.durability = data.durability or 100
    self.maxDurability = data.maxDurability or 100

    return self
end

---@return string
function Item:getName()
    return self.name
end

---@return string
function Item:getDescription()
    return self.description
end

---@return string
function Item:getRarity()
    return self.rarity
end

---@return number
function Item:getValue()
    return self.value
end

---@return string
function Item:getType()
    return self.itemType
end

---@return boolean
function Item:isEquippable()
    return self.equippable
end

---@return number
function Item:getDurability()
    return self.durability
end

---@return number
function Item:getMaxDurability()
    return self.maxDurability
end

---@param amount number
function Item:damage(amount)
    self.durability = math.max(0, self.durability - amount)
end

---@param amount number
function Item:repair(amount)
    self.durability = math.min(self.maxDurability, self.durability + amount)
end

---@return boolean
function Item:isBroken()
    return self.durability <= 0
end

---@return table
function Item:toData()
    return {
        name = self.name,
        description = self.description,
        rarity = self.rarity,
        value = self.value,
        itemType = self.itemType,
        equippable = self.equippable,
        durability = self.durability,
        maxDurability = self.maxDurability
    }
end

return Item