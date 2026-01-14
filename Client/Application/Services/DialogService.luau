local CollectionService = game:GetService("CollectionService")

---@class DialogService
---@field diContainer DIContainer
---@field constants Constants
---@field eventBus EventBus
---@field dialogs Dialogs
---@field targetController TargetController
---@field cameraController CameraController
---@field playerService ClientPlayerService
---@field dialogsCache table
local DialogService = {}
DialogService.__index = DialogService

---@param diContainer DIContainer
---@return DialogService
function DialogService.new(diContainer)
	local self = setmetatable({}, DialogService)
	self.diContainer = diContainer
	self.player = game.Players.LocalPlayer
	self.dialogsCache = {}
	return self
end

function DialogService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
	self.dialogs = shared.data.Dialogs

	---@type ClientApplication
	local application = self.diContainer:resolve("Application")
	self.targetController = application.controllers.targetController
	self.playerService = application.services.playerService
	self.cameraController = application.controllers.cameraController
	---@param npc Model
	local function onAdded(npc)
		if npc:IsDescendantOf(workspace) then
			self:setupCharacterWithDialog(npc)
		end
	end

	---@param npc Model
	local function onRemoved(npc)
		self.dialogsCache[npc] = nil
	end

	for _, v in CollectionService:GetTagged(self.constants.PLAYER_STATES.NPC) do
		onAdded(v)
	end

	CollectionService:GetInstanceAddedSignal(self.constants.PLAYER_STATES.NPC):Connect(onAdded)
	CollectionService:GetInstanceRemovedSignal(self.constants.PLAYER_STATES.NPC):Connect(onRemoved)
end

---@param npc Model
function DialogService:setupCharacterWithDialog(npc)
	local npcDialog = self.dialogs[npc.Name] or self.dialogs.SimpleNpc

	self.dialogsCache[npc] = {
		dialogData = npcDialog,
		npc = npc,
		index = 0,
		showingAnswers = false, -- Track if we're currently showing answers
	}
end

function DialogService:activateDialog()
	local npc = self.targetController:getCurrentTarget()
	if npc.Humanoid and npc.Humanoid.Health <= 0 then
		return
	end

	local cache = self.dialogsCache[npc]

	-- If we're currently showing a dialog and have answers to show, show them
	if cache.index > 0 and not cache.showingAnswers and cache.dialogData.answers then
		cache.showingAnswers = true
		self:_showAnswers(npc)
		return
	end

	-- Otherwise, show next dialog phrase
	if cache.index < #cache.dialogData.phrases then
		cache.index += 1
		cache.showingAnswers = false -- Reset answers state for new dialog
		self:_showDialog(npc)
	else
		self:_finishDialog(npc)
	end
end

---@param answerIndex number
function DialogService:selectAnswer(answerIndex)
	local npc = self.targetController:getCurrentTarget()
	if not self.dialogsCache[npc] or not self.dialogsCache[npc].dialogData.answers then
		return
	end

	local answers = self.dialogsCache[npc].dialogData.answers
	local selectedAnswer = answers[answerIndex]

	if selectedAnswer and selectedAnswer.nextPhraseIndex then
		-- Jump to the specified phrase
		self.dialogsCache[npc].index = selectedAnswer.nextPhraseIndex - 1 -- -1 because activateDialog will increment it
		self.dialogsCache[npc].showingAnswers = false -- Reset state for new phrase
		self:activateDialog()
	else
		-- No next phrase specified, end dialog
		self:_finishDialog(npc)
	end
end

function DialogService:_showDialog(npc)
	self.playerService:toggleRobloxControl(false)
	self.eventBus:fire("showDialog", {
		npc = npc,
	})

	--@TODO: multiply active camera is not good
	self.cameraController:activateDialogCamera()
end

function DialogService:_finishDialog(npc)
	self.eventBus:fire("finishDialog", {})

	self.dialogsCache[npc].index = 0
	self.dialogsCache[npc].showingAnswers = false
	self.playerService:toggleRobloxControl(true)
	self.cameraController:activateDefaultCamera()
end

function DialogService:_showAnswers(npc)
	self.eventBus:fire("showAnswers", {
		npc = npc,
	})
end

return DialogService
