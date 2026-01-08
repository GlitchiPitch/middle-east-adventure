repeat wait() until game:IsLoaded() and game:GetService("Players").LocalPlayer.Character
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)
local UserInputService = game:GetService("UserInputService")
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")
local EquipTool
local toolss = {}

function AddTemplate(tool)
	
	toolss = {}
	for i,v in pairs(Player.Backpack:GetChildren()) do
		table.insert(toolss,v)
		local Template = script.Template:Clone()
		Template.Name = v.Name
		Template.Parent = script.Parent.Holder
		Template.Number_slot.Text = i
		ZIndex = i
		if v.TextureId ~= "" then
			Template.Tool_Data.Text = ""
			Template.Texture_tool.Image = v.TextureId
		else
			Template.Tool_Data.Text = v.Name
		end
		Template.Visible = true
		Template.Tool_Obj.Value = v
	end
	if tool then
		table.insert(toolss,tool)
		local Template = script.Template:Clone()
		Template.Name = tool.Name
		Template.Parent = script.Parent.Holder
		Template.Number_slot.Text = ZIndex+1
		if tool.TextureId ~= "" then
			Template.Tool_Data.Text = ""
			Template.Texture_tool.Image = tool.TextureId
		else
			Template.Tool_Data.Text = tool.Name
		end
		Template.Visible = true
		Template.Tool_Obj.Value = tool
		Template.IsEquip.Value = true
		Template.UIStroke.Transparency = 0
		Template.Size = UDim2.new(1, 10, 1, 10)
	end
	for i,v in pairs(script.Parent.Holder:GetChildren()) do
		if v:IsA("TextButton") then
			v.MouseButton1Down:Connect(function()
				if EquipTool ~= v.Tool_Obj.Value then
					for _,b in pairs(script.Parent.Holder:GetChildren()) do
						if b:IsA("BoolValue") and b.Tool_Obj.Value ~= v.Tool_Obj.Value then
							b.Value = false
						end
						if b:IsA("TextLabel") and b ~= v.Number_slot then
							v.Parent.UIStroke.Transparency = 0.2
							v.Parent.Size = UDim2.new(1, 0, 1, 0)
						end
					end
				end
				v.IsEquip.Value = not v.IsEquip.Value
				if v.IsEquip.Value then
					v.Parent.UIStroke.Transparency = 0
					v.Parent.Size = UDim2.new(1, 10, 1, 10)
				else
					v.Parent.UIStroke.Transparency = 0.2
					v.Parent.Size = UDim2.new(1, 0, 1, 0)
				end
				Equip(v.Tool_Obj.Value,not v.IsEquip.Value)
			end)
		end
	end
end
UserInputService.InputBegan:Connect(function(i,g)
	if not g and i.UserInputType == Enum.UserInputType.Keyboard and ConvertKey(i) then
		local Slot = ConvertKey(i)
		for _,v in pairs(script.Parent.Holder:GetDescendants()) do
			if v:IsA("TextLabel") then
				if v.Text == tostring(Slot) then
					if EquipTool ~= v.Parent.Tool_Obj.Value then
						for _,b in pairs(script.Parent.Holder:GetDescendants()) do
							if b:IsA("BoolValue") and b.Parent.Tool_Obj.Value ~= v.Parent.Tool_Obj.Value then
								b.Value = false
							end
							if b:IsA("TextLabel") and b ~= v then
								b.Parent.UIStroke.Transparency = 0.2
								b.Parent.Size = UDim2.new(1, 0, 1, 0)							end
						end
					end
					v.Parent.IsEquip.Value = not v.Parent.IsEquip.Value
					if v.Parent.IsEquip.Value then
						v.Parent.UIStroke.Transparency = 0
						v.Parent.Size = UDim2.new(1, 10, 1, 10)
					else
						v.Parent.UIStroke.Transparency = 0.2
						v.Parent.Size = UDim2.new(1, 0, 1, 0)
					end
					Equip(v.Parent.Tool_Obj.Value,not v.Parent.IsEquip.Value)
				end
			end
		end
	end 
end)

---@class EquippedSlotsService
---@field diContainer DIContainer
local EquippedSlotsService = {}
EquippedSlotsService.__index = EquippedSlotsService

---@param diContainer DIContainer
---@return EquippedSlotsService
function EquippedSlotsService.new(diContainer)
    local self = setmetatable({}, EquippedSlotsService)
    self.diContainer = diContainer
    return self
end

function EquippedSlotsService:init()
    ---@type ClientApplication
    local application = self.diContainer:resolve("Application")
    local equipment = application.services.playerService:getPlayerEquipment()
    
	---@type Shared
	
end

return EquippedSlotsService