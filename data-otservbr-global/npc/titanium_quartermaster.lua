local internalNpcName = "Titanium Quartermaster"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1613,
	lookHead = 85,
	lookBody = 29,
	lookLegs = 10,
	lookFeet = 0,
	lookAddons = 0
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{text = 'Trading tokens! Titanium level equipment available!'}
}

npcConfig.currency = 22724

npcConfig.shop = {
	{ itemName = "(x500) basic exercise sword", clientId = 28552, buy = 10 },
	{ itemName = "(x500) basic exercise wand", clientId = 28557, buy = 10 },
	{ itemName = "(x500) basic exercise bow", clientId = 28555, buy = 10 },
	{ itemName = "(x500) enhanced exercise sword", clientId = 35279, buy = 15 },
	{ itemName = "(x500) enhanced exercise wand", clientId = 35284, buy = 15 },
	{ itemName = "(x500) enhanced exercise bow", clientId = 35282, buy = 15 },
	{ itemName = "(x500) masterful exercise sword", clientId = 35285, buy = 20 },
	{ itemName = "(x500) masterful exercise wand", clientId = 35290, buy = 20 },
	{ itemName = "(x500) masterful exercise bow", clientId = 35288, buy = 20 },
	{ itemName = "5x prey wildcard", clientId = 5779, buy = 50 },
	{ itemName = "bestiary betterment", clientId = 36728, buy = 100},
	{ itemName = "fire amplification", clientId = 36736, buy = 100},
	{ itemName = "ice amplification", clientId = 36737, buy = 100},
	{ itemName = "earth amplification", clientId = 36738, buy = 100},
	{ itemName = "energy amplification", clientId = 36739, buy = 100},
	{ itemName = "holy amplification", clientId = 36740, buy = 100},
	{ itemName = "death amplification", clientId = 36741, buy = 100},
	{ itemName = "physical amplification", clientId = 36742, buy = 100},
	{ itemName = "charm upgrade", clientId = 36726, buy = 100},
	{ itemName = "strike enhancement", clientId = 36724, buy = 100},
	{ itemName = "copper token", clientId = 22722, buy = 1},
	{ itemName = "iron token", clientId = 22720, buy = 1},
	{ itemName = "platinum token", clientId = 22723, buy = 1},
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	if itemId == 35285 or itemId == 35290 or itemId == 35288 or itemId == 35279 or itemId == 35284 or itemId == 35282 or itemId == 28552 or itemId == 28557 or itemId == 28555 then
		if player:removeItem(npcConfig.currency, totalCost) then
			local item = player:addItemStoreInbox(itemId, 500 * amount)
			player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Bought %ix %s for %i %s.", amount, item:getDescription(), totalCost, ItemType(npcConfig.currency):getPluralName()))
		end
	elseif itemId == 5779 then
		if player:removeItem(npcConfig.currency, totalCost) then
			player:addPreyCards(amount * 5)
			player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Bought %ix prey wildcards for %i %s.", amount, totalCost, ItemType(npcConfig.currency):getPluralName()))
		end
	elseif itemId >= 36724 and itemId <= 36742 then
		if player:removeItem(npcConfig.currency, totalCost) then
			local item = player:addItemStoreInbox(itemId, amount)
			player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Bought %ix %s for %i %s.", amount, item:getDescription(), totalCost, ItemType(npcConfig.currency):getPluralName()))
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
		npcHandler:say({"{Titanium Tokens} are pieces of currency. You can use them to buy advanced level (level 200) equipment from token traders like me.",
						"You can gain titanium tokens from gaining levels. For each level gained in the range of 200 to 500, you will earn 5 {titanium tokens}.", "You can also earn titanium tokens by completing tier 4 {hunting tasks}."}, npc, creature)
	elseif MsgContains(message, "tokens") then
		npc:openShopWindow(creature)
		npcHandler:say("If you have any titanium tokens with you, let's have a look! These are my offers.", npc, creature)
	elseif MsgContains(message, "trade") then
		npc:openShopWindow(creature)
		npcHandler:say("If you have any titanium tokens with you, let's have a look! These are my offers.", npc, creature)
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
npcHandler:setTalkRange(2)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
