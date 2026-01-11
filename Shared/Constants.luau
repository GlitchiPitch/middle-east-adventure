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
		SMITH = "Smith",
		LOOT = "Loot",
		NPC = "NPC",
		WEAPON = "Weapon",
		LECTERN = "Lectern",
		CHEST = "Chest",
	},

	ATTRIBUTES = {
		INTERACT_TYPE = "InteractType",
	},

	INTERACT_TYPES = {
		ALCHEMY = "Alchemy",
		LOOT = "Loot",
		SMITH = "Smith",
		LECTERN = "Lectern",
		CHEST = "Chest",
	},

	CAMERA_STATES = {
		DEFAULT = "Default",
		ALCHEMY = "Alchemy",
		TARGET = "Target",
		DIALOG = "Dialog",
		SMITH = "Smith",
		TRADE = "Trade",
	},
}

return Constants
