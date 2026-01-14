---@class Constants
local Constants = {
	INIT_SERVER = "InitServer",

	REMOTE_EVENTS = {
		UPDATE_PLAYER_DATA = "UpdatePlayerData",
		CLICK_INVENTORY_ITEM = "ClickInventoryItem",
		TOOL_ACTIVATED = "ToolActivated",
		PICKUP_LOOT = "PickupLoot",
		USE_LECTERN = "UseLectern",
		EQUIP_ITEM = "EquipItem",
		UNEQUIP_ITEM = "UnequipItem",
		TOGGLE_SPRINT = "ToggleSprint",
		START_ALCHEMY = "StartAlchemy",
		START_SMITHING = "StartSmithing",
		CRAFT_ITEM = "CraftItem",
		START_TRADE = "StartTrade",
		ACCEPT_TRADE = "AcceptTrade",
		ADD_ITEM_TO_TRADE = "AddItemToTrade",
		REMOVE_ITEM_FROM_TRADE = "RemoveItemFromTrade",
		SELECT_DIALOG_OPTION = "SelectDialogOption",
		CONTINUE_DIALOG = "ContinueDialog",
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
		IDLE = "Idle",
	},

	ATTRIBUTES = {
		INTERACT_TYPE = "InteractType",
	},

	ITEM_TYPES = {
		FOOD = "Food",
		WEAPON = "Weapon",
		POTION = "Potion",
		SCROLL = "Scroll",
		MAGIC = "Magic",
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
		INVENTORY = "Inventory",
	},
}

return Constants
