---@class Constants
local Constants = {
	INIT_SERVER = "InitServer",

	REMOTE_EVENTS = {
		UPDATE_PLAYER_DATA = "UpdatePlayerData",
		CLICK_INVENTORY_ITEM = "ClickInventoryItem",
		TOOL_ACTIVATED = "ToolActivated",
	},

	PLAYER_STATES = {
		INTERACT = "Interact",
		ALCHEMY = "Alchemy",
		LOOT = "Loot",
		NPC = "NPC",
		WEAPON = "Weapon",
	},

	ATTRIBUTES = {
		INTERACT_TYPE = "InteractType",
	},

	INTERACT_TYPES = {
		ALCHEMY = "Alchemy",
		LOOT = "Loot",
	},

	CAMERA_STATES = {
		DEFAULT = "Default",
		ALCHEMY = "Alchemy",
		TARGET = "Target",
	}
}

return Constants
