local internalNpcName = "Platinum Quartermaster"
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
	{text = 'Trading tokens! Platinum level equipment available!'}
}

npcConfig.currency = 22723

npcConfig.shop = {
	{ name = "rift bow", clientId = 22866, buy = 100 },
	{ name = "rift crossbow", clientId = 22867, buy = 100 },
	{ name = "crystalline axe", clientId = 16161, buy = 75 },
	{ name = "shiny blade", clientId = 16175, buy = 75 },
	{ name = "mycological mace", clientId = 16162, buy = 75 },
	{ name = "muck rod", clientId = 16117, buy = 75 },
	{ name = "glacial rod", clientId = 16118, buy = 75 },
	{ name = "wand of everblazing", clientId = 16115, buy = 75 },
	{ name = "wand of defiance", clientId = 16096, buy = 75 },
	{ name = "prismatic helmet", clientId = 16109, buy = 50 },
	{ name = "prismatic legs", clientId = 16111, buy = 50 },
	{ name = "prismatic armor", clientId = 16110, buy = 50 },
	{ name = "prismatic boots", clientId = 16112, buy = 50 },
	{ name = "guardian boots", clientId = 10323, buy = 50 },
	{ name = "gill coat", clientId = 16105, buy = 50 },
	{ name = "gill gugel", clientId = 16104, buy = 50 },
	{ name = "gill legs", clientId = 16106, buy = 50 },
	{ name = "yalahari mask", clientId = 8864, buy = 50 },
	{ name = "elite draken helmet", clientId = 11689, buy = 50 },
	{ name = "royal scale robe", clientId = 11687, buy = 50 },
	{ name = "spellbook of vigilance", clientId = 16107, buy = 25 },
	{ name = "prismatic shield", clientId = 16116, buy = 25 },
	{ name = "foxtail amulet", clientId = 27565, buy = 25 },
	{ itemName = "(x3800) enhanced exercise sword", clientId = 35279, buy = 10 },
	{ itemName = "(x3800) enhanced exercise wand", clientId = 35284, buy = 10 },
	{ itemName = "(x3800) enhanced exercise bow", clientId = 35282, buy = 10 },
	{ itemName = "3x prey wildcard", clientId = 5779, buy = 5 },
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	if itemId == 35279 or itemId == 35284 or itemId == 35282 then
		if player:removeItem(npcConfig.currency, totalCost) then
			local item = player:addItemStoreInbox(itemId, 3800 * amount)
			player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Bought %ix %s for %i %s.", amount, item:getDescription(), totalCost, ItemType(npcConfig.currency):getPluralName()))
		end
	elseif itemId == 5779 then
		if player:removeItem(npcConfig.currency, totalCost) then
			player:addPreyCards(amount * 3)
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
		npcHandler:say({"{Platinum Tokens} are pieces of currency. You can use them to buy advanced level (level 150) equipment from token traders like me.",
						"You can gain platinum tokens from gaining levels. For each level gained in the range of 150-200, you will earn 5 {platinum tokens}.", "You can also earn platinum tokens by completing tier 3 {hunting tasks}."}, npc, creature)
	elseif MsgContains(message, "tokens") then
		npc:openShopWindow(creature)
		npcHandler:say("If you have any platinum tokens with you, let's have a look! These are my offers.", npc, creature)
	elseif MsgContains(message, "trade") then
		npc:openShopWindow(creature)
		npcHandler:say("If you have any iron tokens with you, let's have a look! These are my offers.", npc, creature)
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
