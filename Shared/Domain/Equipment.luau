---@class EquipmentEntity
local Equipment = {}
Equipment.__index = Equipment

function Equipment.new()
    local self = setmetatable({}, Equipment)
    self.slots = {
        head = nil,
        body = nil,
        boots = nil,
        ring = {
            left = nil,
            right = nil,
        },
        amulet = nil,
        gloves = nil,
    }
    return self
end

---@class equipdableItem
---@field itemType '"head"' | '"body"' | '"boots"' | '"ring"' | '"amulet"' | '"gloves"'

---@param item equipdableItem
function Equipment:equip(item)
    if item.itemType == "ring" then
        local freeHand
        if not self.slots.ring.left then
            freeHand = "left"
        elseif not self.slots.ring.right then
            freeHand = "right"
        end

        if freeHand then
            self.slots.ring[freeHand] = item
        end
    else

        if self.slots[item.itemType] and self.slots[item.itemType] == item then
            self.slots[item.itemType] = nil
            return
        end

        if self.slots[item.itemType] then
            -- self.slots[item.itemType]:unequip()
            self.slots[item.itemType] = nil
        end

        self.slots[item.itemType] = item
        -- self.slots[item.itemType]:equip()
    end
end

function Equipment:calculateBoosts()
    
end

function Equipment:toData()
    return {}
end

return Equipment