local internalNpcName = "Zethra"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 575,
	lookHead = 97,
	lookBody = 109,
	lookLegs = 118,
	lookFeet = 58,
	lookAddons = 3
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{text = 'Want to look fabulous but don\'t have the time? Come see my wares.'}
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop =
{
	{ itemName = "piece of royal steel", clientId = 5887, buy = 18000 },
	{ itemName = "piece of hell steel", clientId = 5888, buy = 1500 },
	{ itemName = "piece of draconian steel", clientId = 5889, buy = 6000 },
	{ itemName = "huge chunk of crude iron", clientId = 5892, buy = 22500 },
	{ itemName = "flask of warrior's sweat", clientId = 5885, buy = 30000 },
	{ itemName = "enchanted chicken wing", clientId = 5891, buy = 45000 },
	{ itemName = "fighting spirit", clientId = 5884, buy = 90000 },
	{ itemName = "magic sulphur", clientId = 5904, buy = 18000},

}

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end

-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end

-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

-- npcType registering the npcConfig table
npcType:register(npcConfig)
