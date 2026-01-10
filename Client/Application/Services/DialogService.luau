local CollectionService = game:GetService("CollectionService")
-- local TweenService = game:GetService("TweenService")
-- local Debris = game:GetService("Debris")

---@class DialogService
---@field diContainer DIContainer
---@field constants Constants
---@field eventBus EventBus
---@field dialogs Dialogs
---@field targetService TargetService
local DialogService = {}
DialogService.__index = DialogService

---@param diContainer DIContainer
---@return DialogService
function DialogService.new(diContainer)
	local self = setmetatable({}, DialogService)
	self.diContainer = diContainer
	self.config = {
		INTERACTION_DISTANCE = 16, --// distance (in studs) of how far players must be in order to engage in conversation with an NPC
		MAIN_COLOR = Color3.fromRGB(46, 255, 255), --// main color of dialog
		SECONDARY_COLOR = Color3.fromRGB(255, 109, 192), --// secondary color of dialog
	}
	return self
end

--// This function is meant to be called whenever the player joins the game.
--// It's used for initializing the dialog system!
function DialogService:init()
	self.player = game.Players.LocalPlayer
	self._characterCache = {}

	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
	self.dialogs = shared.data.Dialogs

	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	self.targetService = application.services.targetService

	local function onCharacterAdded()
		self.character = self.player.Character
		self.humanoid = self.character:WaitForChild("Humanoid")
	end

	---@param npc Model
	local function onAdded(npc)
		if npc:IsDescendantOf(workspace) then
			self:setupCharacterWithDialog(npc)
		end
	end

	---@param npc Model
	local function onRemoved(npc) end

	--// Update character stuff when needed

	if self.player.Character then
		onCharacterAdded()
	end

	for _, v in CollectionService:GetTagged(self.constants.PLAYER_STATES.NPC) do
		onAdded(v)
	end

	CollectionService:GetInstanceAddedSignal(self.constants.PLAYER_STATES.NPC):Connect(onAdded)
	CollectionService:GetInstanceRemovedSignal(self.constants.PLAYER_STATES.NPC):Connect(onRemoved)
	self.player.CharacterAdded:Connect(onCharacterAdded)
end

---@param npc Model
function DialogService:setupCharacterWithDialog(npc)
	local npcDialog = self.dialogs[npc.Name] or self.dialogs.SimpleNpc
	local humanoid = npc.Humanoid :: Humanoid
	local function _onDied()
		self.eventBus:fire("deleteDialog", {})
		self._characterCache[npc].diedConn:Disconnect()
		self._characterCache[npc] = nil
	end

	self._characterCache[npc] = {
		dialogData = npcDialog,
		npc = npc,
		diedConn = humanoid.Died:Connect(_onDied),
	}

	self.eventBus:fire("setupDialog", {
		dialogData = npcDialog,
		npc = npc,
	})
end

function DialogService:activateDialog()
	local npc = self.targetService:getCurrentTarget()
	if npc.Humanoid and npc.Humanoid.Health <= 0 then
		return
	end

	self.eventBus:fire("showDialog", {
		npc = npc,
	})
end

function DialogService:finishDialog(npc)
	self.eventBus:fire("finishDialog", {
		npc = npc,
	})
end

-- 	local Dialog = {}

-- 	--// Fetch dialog/NPC info
-- 	local NPC = dialogModule.Parent
-- 	local dialogInfo = require(dialogModule)
-- 	local dialogConfig = dialogInfo.Config or {}

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

-- --// helpful function for darkening colors (or brightening them for when percentdarker is negative lol)
-- local function DarkenColor(color, percentDarker)
-- 	percentDarker = 100 - percentDarker
-- 	local h, s, v = Color3.toHSV(color)
-- 	return Color3.fromHSV(h, s, math.clamp(v * (percentDarker / 100), 0, 1))
-- end
