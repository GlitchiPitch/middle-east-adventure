---@class Dialogs
local Dialogs = {
	SimpleNpc = {
		phrases = {
			"How is going",
			"What's up",
			"Go Away",
		},
		answers = nil, -- No answers for simple NPCs
	},
	Seller = {
		phrases = {
			"Hi, what do you need",
			"Wanna some items",
			"Great! Here are my wares",
			"Maybe next time then",
		},
		answers = {
			-- After first phrase (index 1)
			{ text = "Show me your items", nextPhraseIndex = 3 },
			{ text = "Nothing, thanks", nextPhraseIndex = 4 },
		}
	},
}

return Dialogs
