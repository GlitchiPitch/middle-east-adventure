local Players = game:GetService("Players")
---@class AnimationService
---@field diContainer DIContainer
---@field animTracks table<string, AnimationTrack>
local AnimationService = {}
AnimationService.__index = AnimationService

---@param diContainer DIContainer
---@return AnimationService
function AnimationService.new(diContainer)
	local self = setmetatable({}, AnimationService)
	self.diContainer = diContainer
	self.player = Players.LocalPlayer
	self.animTracks = {}
	return self
end

function AnimationService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	local animations = shared.assets.Animations
	self.oneHandedIdle = animations.OneHandedIdle
	self.oneHandedBlock = animations.OneHandedBlock

	self.pickupLoot = animations.PickupLoot
	self.lectern = animations.Lectern
	self.eat = animations.Eat

	self.OneHandedAnimations = {
		animations.OneHandednSlash1,
		animations.OneHandednSlash2,
		animations.OneHandednSlash3,
		animations.OneHandednSlash4,
	}
end

function AnimationService:setupAnimationToCharacter()
	local character = self.player.Character

	self.animTracks.OneHandedIdle = character.Humanoid.Animator:LoadAnimation(self.oneHandedIdle) :: AnimationTrack
	self.animTracks.OneHandedIdle.Looped = true
	self.animTracks.OneHandedIdle.Priority = Enum.AnimationPriority.Action

	self.animTracks.OneHandedBlock = character.Humanoid.Animator:LoadAnimation(self.oneHandedBlock) :: AnimationTrack
	self.animTracks.OneHandedBlock.Looped = true
	self.animTracks.OneHandedBlock.Priority = Enum.AnimationPriority.Action2



	self.animTracks.PickupLoot = character.Humanoid.Animator:LoadAnimation(self.pickupLoot)
	self.animTracks.PickupLoot.Looped = false
	self.animTracks.PickupLoot.Priority = Enum.AnimationPriority.Action2

	self.animTracks.Eat = character.Humanoid.Animator:LoadAnimation(self.eat)
	self.animTracks.Eat.Looped = false
	self.animTracks.Eat.Priority = Enum.AnimationPriority.Action2

	self.animTracks.Lectern = character.Humanoid.Animator:LoadAnimation(self.lectern)
	self.animTracks.Lectern.Looped = false
	self.animTracks.Lectern.Priority = Enum.AnimationPriority.Action2

	for i, animation in self.OneHandedAnimations do
		self.animTracks["OneHanded" .. i] = character.Humanoid.Animator:LoadAnimation(animation) :: AnimationTrack
		self.animTracks["OneHanded" .. i].Looped = false
		self.animTracks["OneHanded" .. i].Priority = Enum.AnimationPriority.Action2
	end
end

function AnimationService:clearAnimationToCharacter()
	self.animTracks = {}
end

---@param name string
function AnimationService:playAnimation(name)
	self.animTracks[name]:Play()
end

---@param name string
function AnimationService:stopAnimation(name)
	self.animTracks[name]:Stop()
end

---@param name string
function AnimationService:playCombatAnimation(name)
	print(name)
end

return AnimationService
