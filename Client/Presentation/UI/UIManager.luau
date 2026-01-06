local CollectionService = game:GetService("CollectionService")
---@alias _uiNames '"Inventory"' | '"Combat"'

---@class UIManager
local UIManager = {}
UIManager.__index = UIManager

---@return UIManager
function UIManager.new()
    local self = setmetatable({}, UIManager)
    return self
end

function UIManager:init()
    local animatedButton = CollectionService:GetTagged("")
    CollectionService:GetInstanceAddedSignal():Connect()
    CollectionService:GetInstanceRemovedSignal():Connect()
end

---@param name _uiNames
function UIManager:showUI(name)
    print(name)
end

return UIManager
