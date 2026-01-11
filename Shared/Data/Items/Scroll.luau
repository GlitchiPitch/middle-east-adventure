local Scroll = {}

---@param scrollName string
function Scroll:getScrollData(scrollName)
    return self[scrollName]
end

return Scroll