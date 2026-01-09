-- local TweenService = game:GetService("TweenService")
-- local Debris = game:GetService("Debris")

---@class DialogService
local DialogService = {}
DialogService.__index = DialogService

---@return DialogService
function DialogService.new()
	local self = setmetatable({}, DialogService)
	self.config = {
		INTERACTION_DISTANCE = 16, --// distance (in studs) of how far players must be in order to engage in conversation with an NPC
		ONLY_CAPS = true, --// whether or not all dialog will be forced to capitalization
		HIDE_BODY = true, --// whether or not the body will be hidden when a rig is being used as a character
		MAIN_COLOR = Color3.fromRGB(46, 255, 255), --// main color of dialog
		SECONDARY_COLOR = Color3.fromRGB(255, 109, 192), --// secondary color of dialog
	}
	return self
end

--// This function is meant to be called whenever the player joins the game.
--// It's used for initializing the dialog system!
function DialogService:init()
	self.Player = game.Players.LocalPlayer
	self.Character = self.Player.Character or self.Player.CharacterAdded:Wait()
	self.Humanoid = self.Character:WaitForChild("Humanoid")

	self.CharacterCache = {}

	--// Update character stuff when needed
	self.Player.CharacterAdded:Connect(function()
		self.Character = self.Player.Character
		self.Humanoid = self.Character:WaitForChild("Humanoid")
	end)

	--// Add dialog modules & work to add more if there's ever any added by the server/client
	for _, dialogModule in pairs(workspace:GetDescendants()) do
		self:setupCharacterWithDialog(dialogModule)
	end
	workspace.DescendantAdded:Connect(function(dialogModule)
		self:setupCharacterWithDialog(dialogModule)
	end)
end

function DialogService:activateDialog()
	
end

--// This function processes dialog modules & adds functionality onto them for whenever they're added to workspace!
function DialogService:setupCharacterWithDialog(dialogModule)
	-- local NPC = dialogModule.Parent
	-- if dialogModule:IsA("ModuleScript") and dialogModule.Name == "Dialog" and NPC:IsA("Model") then
	-- 	-- local dialogInfo = require(dialogModule)
	-- end
end

-- --// helpful function for darkening colors (or brightening them for when percentdarker is negative lol)
-- local function DarkenColor(color, percentDarker)
-- 	percentDarker = 100 - percentDarker
-- 	local h, s, v = Color3.toHSV(color)
-- 	return Color3.fromHSV(h, s, math.clamp(v * (percentDarker / 100), 0, 1))
-- end

-- --// Create a new dialog instance
-- function DialogService:activateDialog(dialogModule)
-- 	if self.Humanoid and self.Humanoid.Health > 0 then
-- 		return
-- 	end
-- 	local Dialog = {}

-- 	--// Fetch dialog/NPC info
-- 	local NPC = dialogModule.Parent
-- 	local dialogInfo = require(dialogModule)
-- 	local dialogConfig = dialogInfo.Config or {}

	
-- 	--// Prevent player from walking around
-- 	local humanoid = DialogService.Humanoid
-- 	local originalSpeed = humanoid.WalkSpeed
-- 	humanoid.WalkSpeed = 0
-- 	humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)

-- 	--// Cleanup when player dies (there are two connections because I'm paranoid :3)
-- 	humanoid.Died:Connect(function()
-- 		Dialog:Cleanup()
-- 	end)

-- 	humanoid:GetPropertyChangedSignal("Parent"):Connect(function()
-- 		Dialog:Cleanup()
-- 	end)

-- 	--// Add player character cuz why not
-- 	DialogService.CharacterCache["Player"] = nil
-- 	DialogService.CharacterCache["Player"] = { Rig = DialogService.Character }

-- 	--// Function for creating characters
-- 	function Dialog:CreateCharacter(data)
-- 		if data.Name == "Player" then
-- 			warn("can't make character name the same as Player!")
-- 			return
-- 		end
-- 		if not data.Name then
-- 			warn("no character name given while creating character!")
-- 			return
-- 		end
-- 		if not data.Rig and not data.Expressions then
-- 			warn("no rig or expressions found while creating character!")
-- 			return
-- 		end
-- 		if data.Rig and not data.Rig:FindFirstChild("Head") then
-- 			warn("no head found in rig while creating character!")
-- 			return
-- 		end
-- 		if DialogService.CharacterCache[data.Name] then
-- 			return
-- 		end

-- 		--// Create character info
-- 		DialogService.CharacterCache[data.Name] = {}
-- 		DialogService.CharacterCache[data.Name].Rig = data.Rig
-- 		DialogService.CharacterCache[data.Name].Expressions = data.Expressions
-- 	end

-- 	--// Function for loading dialog onto the UI\
-- 	function Dialog:CreateDialog(data)
-- 		if not dialogUI.Parent then
-- 			return
-- 		end
-- 		data.Text = data.Text or "Uhhhhhhh"
-- 		data.Character = data.Character or NPC.Name
-- 		dialogContainer.Continue.Interactable = false

-- 		--// Change characters if needed
-- 		if Dialog.CurrentCharacter and Dialog.CurrentCharacter ~= data.Character then
-- 			TweenService:Create(dialogUI.CharacterHolder, TweenInfo.new(0.3), { Position = UDim2.fromScale(1.5, 0.4) })
-- 				:Play()
-- 			TweenService:Create(
-- 				dialogUI.CharacterBackground,
-- 				TweenInfo.new(0.25),
-- 				{ Rotation = 90, Position = UDim2.fromScale(1.35, 0.475) }
-- 			):Play()
-- 			task.wait(0.25)
-- 			worldModel:ClearAllChildren()
-- 			dialogUI.CharacterHolder.Sprite.Visible = false
-- 		end

-- 		--// Add character to cache if it isn't there already
-- 		if not DialogService.CharacterCache[data.Character] then
-- 			local data = {
-- 				Name = NPC.Name,
-- 				Rig = dialogConfig.Rig,
-- 				Expressions = dialogConfig.Expressions,
-- 			}
-- 			if not data.Rig and not data.Expressions then
-- 				data.Rig = NPC
-- 			end
-- 			Dialog:CreateCharacter(data)
-- 		end

-- 		--// Function for adding sprites cuz this code is used twice
-- 		local function AddSprite(expressionInfo)
-- 			Dialog.CurrentExpression = data.Expression
-- 			dialogUI.CharacterHolder.Sprite.Visible = true
-- 			dialogUI.CharacterHolder.Sprite.ResampleMode = (
-- 				expressionInfo.Antialiasing and Enum.ResamplerMode.Default or Enum.ResamplerMode.Pixelated
-- 			)
-- 			dialogUI.CharacterHolder.Sprite.Size = UDim2.fromScale(1, 1)
-- 				+ (expressionInfo.SizeOffset or UDim2.fromScale())
-- 			dialogUI.CharacterHolder.Sprite.Position = UDim2.fromScale(0.5, 0.5)
-- 				+ (expressionInfo.PositionOffset or UDim2.fromScale())
-- 			dialogUI.CharacterHolder.Sprite.Image = expressionInfo.Textures[1]
-- 			game.ContentProvider:PreloadAsync(expressionInfo.Textures)
-- 			task.spawn(function()
-- 				local i = 0
-- 				while
-- 					task.wait(expressionInfo.Framerate / 60)
-- 					and data.Expression == Dialog.CurrentExpression
-- 					and data.Character == Dialog.CurrentCharacter
-- 					and dialogUI.Parent
-- 				do
-- 					local texture = expressionInfo.Textures[(i % #expressionInfo.Textures) + 1]
-- 					if texture then
-- 						dialogUI.CharacterHolder.Sprite.Image = texture
-- 					end
-- 					i += 1
-- 				end
-- 			end)
-- 		end

-- 		--// Add character rig to viewport if needed
-- 		if Dialog.CurrentCharacter ~= data.Character then
-- 			local characterInfo = DialogService.CharacterCache[data.Character]
-- 			if characterInfo.Expressions then
-- 				if data.Expression then
-- 					local expressionInfo = characterInfo.Expressions[data.Expression]
-- 					if expressionInfo then
-- 						AddSprite(expressionInfo)
-- 					else
-- 						warn(
-- 							"no expression found while using expression-based character! did you spell the expression wrong?"
-- 						)
-- 					end
-- 				else
-- 					warn(
-- 						"no expression given while using expression-based character! did you forget to state one to be used?"
-- 					)
-- 				end
-- 			elseif characterInfo.Rig then
-- 				local rig = characterInfo.Rig:Clone()
-- 				if not rig.PrimaryPart then
-- 					rig.PrimaryPart = rig:FindFirstChild("HumanoidRootPart") or rig:FindFirstChildOfClass("BasePart")
-- 				end

-- 				--// Get rid of scripts before anything
-- 				for _, thing in pairs(rig:GetDescendants()) do
-- 					if thing:IsA("Script") or thing:IsA("LocalScript") then
-- 						thing.Enabled = false
-- 						thing:Destroy()
-- 					end
-- 				end

-- 				--// Continue on with editing rig properties
-- 				rig:SetPrimaryPartCFrame(CFrame.new())
-- 				rig.Name = "Rig"
-- 				rig.Parent = worldModel

-- 				--// Create camera for viewing rig
-- 				local camera = Instance.new("Camera")
-- 				camera.Parent = dialogUI.CharacterHolder
-- 				camera.FieldOfView = 15
-- 				camera.CFrame = rig.Head.CFrame * CFrame.Angles(0, math.rad(180 + 30), 0) * CFrame.new(0, 0, 10)

-- 				--// Hide body if needed
-- 				if config.HIDE_BODY then
-- 					camera.CFrame *= CFrame.new(-0.2, 0.225, 0)
-- 					camera.FieldOfView = 12.5
-- 					local validAttachments = {
-- 						"NeckAttachment",
-- 						"FaceFrontAttachment",
-- 						"FaceCenterAttachment",
-- 						"FaceFrontAttachment",
-- 						"HairAttachment",
-- 						"HatAttachment",
-- 					}

-- 					for _, thing in pairs(rig:GetChildren()) do
-- 						if thing:IsA("BasePart") and thing.Name ~= "Head" then
-- 							thing:Destroy()
-- 						elseif thing:IsA("Accessory") then
-- 							local handle = thing:FindFirstChild("Handle")
-- 							if handle then
-- 								local didFindValidAttachment = false
-- 								for _, attachmentName in pairs(validAttachments) do
-- 									if handle:FindFirstChild(attachmentName) then
-- 										didFindValidAttachment = true
-- 										break
-- 									end
-- 								end
-- 								if not didFindValidAttachment then
-- 									thing:Destroy()
-- 								end
-- 							end
-- 						end
-- 					end
-- 				end

-- 				dialogUI.CharacterHolder.CurrentCamera = camera
-- 			end
-- 		end

-- 		--// Some stuff for expressions & pos/size offsets
-- 		if Dialog.CurrentCharacter == data.Character and Dialog.CurrentExpression ~= data.Expression then
-- 			local characterInfo = DialogService.CharacterCache[data.Character]
-- 			if characterInfo.Expressions and data.Expression then
-- 				local expressionInfo = characterInfo.Expressions[data.Expression]
-- 				if expressionInfo then
-- 					AddSprite(expressionInfo)
-- 				end
-- 			end
-- 		end

-- 		--// Show character holder
-- 		TweenService:Create(dialogUI.CharacterHolder, TweenInfo.new(0.4), { Position = UDim2.fromScale(1, 0.4) }):Play()
-- 		TweenService:Create(
-- 			dialogUI.CharacterBackground,
-- 			TweenInfo.new(0.4),
-- 			{ Rotation = 75, Position = UDim2.fromScale(1, 0.475) }
-- 		):Play()

-- 		--// Setup connection that's used for detecting when the dialog UI is clicked
-- 		local clickConnection = dialogContainer.Continue.MouseButton1Click:Connect(function()
-- 			Dialog.FinishedReading = true
-- 		end)

-- 		--// Cancel dialog tweens if they exist
-- 		if Dialog.TextTweens then
-- 			for _, tween in pairs(Dialog.TextTweens) do
-- 				tween:Cancel()
-- 				tween = nil
-- 			end
-- 		end

-- 		--// Set dialog properties
-- 		dialogContainer.Label.Text = (config.ONLY_CAPS and data.Text:upper() or data.Text)
-- 		dialogContainer.Continue.Text = (config.ONLY_CAPS and data.Text:upper() or data.Text)
-- 		dialogContainer.Label.TextTransparency = 1
-- 		dialogContainer.Continue.TextTransparency = 1

-- 		--// Tweening
-- 		Dialog.TextTweens = {}
-- 		Dialog.TextTweens.Label =
-- 			TweenService:Create(dialogContainer.Label, TweenInfo.new(0.25), { TextTransparency = 0 }):Play()
-- 		Dialog.TextTweens.Continue =
-- 			TweenService:Create(dialogContainer.Continue, TweenInfo.new(0.25), { TextTransparency = 0 }):Play()

-- 		--// Callback if necessary
-- 		if data.Callback then
-- 			data.Callback()
-- 		end

-- 		--// Other stuff
-- 		Dialog.CurrentCharacter = data.Character
-- 		dialogContainer.Continue.Interactable = true

-- 		--// Yield
-- 		repeat
-- 			task.wait()
-- 		until Dialog.FinishedReading or not dialogUI.Parent

-- 		--// Failsafe stuff
-- 		if Dialog.Destroyed or not dialogUI.Parent then
-- 			return
-- 		end
-- 		Dialog.FinishedReading = nil

-- 		--// Cleanup
-- 		clickConnection:Disconnect()
-- 		clickConnection = nil
-- 		dialogContainer.Label.Text = ""
-- 		dialogContainer.Continue.Text = ""
-- 	end

-- 	function Dialog:Cleanup()
-- 		if not Dialog.Destroyed then
-- 			Dialog.Destroyed = true

-- 			Debris:AddItem(dialogUI, 0.5)
-- 			TweenService:Create(dialogUI.Bars.Top, TweenInfo.new(0.5), { Size = UDim2.fromScale(1, 0) }):Play()
-- 			TweenService:Create(dialogUI.Bars.Bottom, TweenInfo.new(0.5), { Size = UDim2.fromScale(1, 0) }):Play()
-- 			TweenService:Create(dialogUI.CharacterHolder, TweenInfo.new(0.3), { Position = UDim2.fromScale(1.5, 0.4) })
-- 				:Play()
-- 			TweenService:Create(
-- 				dialogUI.CharacterBackground,
-- 				TweenInfo.new(0.3),
-- 				{ Rotation = 90, Position = UDim2.fromScale(1.35, 0.475) }
-- 			):Play()

-- 			humanoid.WalkSpeed = originalSpeed
-- 			humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
-- 		end
-- 	end

-- 	dialogInfo.Interacted(Dialog)
-- 	Dialog:Cleanup()
-- end

return DialogService
