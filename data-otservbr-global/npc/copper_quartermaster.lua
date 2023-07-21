local internalNpcName = "Copper Quartermaster"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 745,
	lookHead = 77,
	lookBody = 77,
	lookLegs = 96,
	lookFeet = 77,
	lookAddons = 3
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{text = 'Trading tokens! Copper level equipment available!'}
}

npcConfig.currency = 22722

npcConfig.shop = {
	{ name = "demonrage sword", clientId = 7382, buy = 100 },
	{ name = "dragon lance", clientId = 3302, buy = 100 },
	{ name = "abyss hammer", clientId = 7414, buy = 100 },
	{ name = "composite hornbow", clientId = 8027, buy = 100 },
	{ name = "ornate crossbow", clientId = 14247, buy = 100 },
	{ name = "cranial basher", clientId = 7415, buy = 75 },
	{ name = "heroic axe", clientId = 7389, buy = 75 },
	{ name = "mystic blade", clientId = 7384, buy = 75 },
	{ name = "wand of starstorm", clientId = 8092, buy = 75 },
	{ name = "wand of inferno", clientId = 3071, buy = 75 },
	{ name = "springsprout rod", clientId = 8084, buy = 75 },
	{ name = "hailstorm rod", clientId = 3067, buy = 75 },
	{ name = "crusader helmet", clientId = 3391, buy = 50 },
	{ name = "knight armor", clientId = 3370, buy = 50 },
	{ name = "knight legs", clientId = 3371, buy = 50 },
	{ name = "spirit cloak", clientId = 8042, buy = 50 },
	{ name = "hat of the mad", clientId = 3210, buy = 50 },
	{ name = "blue robe", clientId = 3567, buy = 50 },
	{ name = "wood cape", clientId = 3575, buy = 50 },
	{ name = "boots of haste", clientId = 3079, buy = 25 },
	{ name = "badger boots", clientId = 22086, buy = 25 },
	{ name = "platinum amulet", clientId = 3055, buy = 25 },
	{ name = "spellbook of mind control", clientId = 8074, buy = 25 },
	{ name = "dragon shield", clientId = 3416, buy = 25 },
	{ itemName = "(x500) basic exercise sword", clientId = 28552, buy = 10 },
	{ itemName = "(x500) basic exercise wand", clientId = 28557, buy = 10 },
	{ itemName = "(x500) basic exercise bow", clientId = 28555, buy = 10 },
	{ itemName = "1x prey wildcard", clientId = 5779, buy = 5 },
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	if itemId == 28552 or itemId == 28557 or itemId == 28555 then
		if player:removeItem(npcConfig.currency, totalCost) then
			local item = player:addItemStoreInbox(itemId, 500 * amount)
			player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Bought %ix %s for %i %s.", amount, item:getDescription(), totalCost, ItemType(npcConfig.currency):getPluralName()))
		end
	elseif itemId == 5779 then
		if player:removeItem(npcConfig.currency, totalCost) then
			player:addPreyCards(amount)
			player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Bought %ix prey wildcards for %i %s.", amount, totalCost, ItemType(npcConfig.currency):getPluralName()))
		end
	else
		npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
	end
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

local products = {}

local answerType = {}
local answerLevel = {}

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

local function greetCallback(npc, creature)
	local playerId = creature:getId()
	npcHandler:setTopic(playerId, 0)
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "information") then
		npcHandler:say({"{Copper Tokens} are pieces of currency. You can use them to buy low level (level 50) equipment from token traders like me.",
						"You can gain copper tokens from advancing levels. For each level gained in the range of 50-100, you will earn 5 {copper tokens}.", "You can also earn copper tokens by completing tier 1 {hunting tasks}."}, npc, creature)
	elseif MsgContains(message, "tokens") then
		npc:openShopWindow(creature)
		npcHandler:say("If you have any copper tokens with you, let's have a look! These are my offers.", npc, creature)
	elseif MsgContains(message, "trade") then
		npc:openShopWindow(creature)
		npcHandler:say("If you have any copper tokens with you, let's have a look! These are my offers.", npc, creature)
	elseif MsgContains(message, "tasks") then
		npcHandler:say("You may also complete hunting tasks to earn iron tokens. Type \"!task\", to see the list of available tasks.", npc, creature)
	else
		npcHandler:say("Would you like to {trade}, or are you looking for {information}.", npc, creature)
	end
	return true
end

npcHandler:setCallback(CALLBACK_SET_INTERACTION, onAddFocus)
npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, false)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
