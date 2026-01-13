local OneHanded = {
	Club = script:FindFirstChild("Club"),
	RustySword = script:FindFirstChild("RustySword"),
	AssassinDagger = script:FindFirstChild("AssassinDagger"),
	Sword = script:FindFirstChild("Sword"),
	OrcSlayer = script:FindFirstChild("OrcSlayer"),
	Rapier = script:FindFirstChild("Rapier"),
	AssassinSword = script:FindFirstChild("AssassinSword"),
	PaladinSword = script:FindFirstChild("PaladinSword"),
	BarbariansSword = script:FindFirstChild("BarbariansSword"),
	MasterSword = script:FindFirstChild("MasterSword"),
	GreatSword = script:FindFirstChild("GreatSword"),
}

local TwoHanded = {
	BarbedClub = script:FindFirstChild("BarbedClub"),
	Halberd = script:FindFirstChild("Halberd"),
	JaggedAxe = script:FindFirstChild("JaggedAxe"),
	Cleaver = script:FindFirstChild("Cleaver"),
	ExecutionersSword = script:FindFirstChild("ExecutionersSword"),
	WarHammer = script:FindFirstChild("WarHammer"),
	DemonSword = script:FindFirstChild("DemonSword"),
	JudgesStaff = script:FindFirstChild("JudgesStaff"),
	StaffOfWitchcraft = script:FindFirstChild("StaffOfWitchcraft"),
	WaterStaff = script:FindFirstChild("WaterStaff"),
	StaffOfFire = script:FindFirstChild("StaffOfFire"),
	StaffOfDarkness = script:FindFirstChild("StaffOfDarkness"),
	Mace = script:FindFirstChild("Mace"),
}

local Weapons = {
	OneHanded = OneHanded,
	TwoHanded = TwoHanded,
}

---@param weaponName string
---@return Tool?
function Weapons:getWeaponTool(weaponName)
	local weapon = self.OneHanded[weaponName] or self.TwoHanded[weaponName]
	if weapon then
		return weapon:Clone()
	end
	return
end

return Weapons
