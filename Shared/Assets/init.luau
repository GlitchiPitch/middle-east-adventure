---@class Assets
local Assets = {
	Animations = require(script.Animations),
	Weapons = require(script.Weapons),
	Food = require(script.Food),
}

function Assets:getAsset(name)
	return self.Weapons:getWeaponTool(name) or self.Food:getFoodTool(name)
end

return Assets
