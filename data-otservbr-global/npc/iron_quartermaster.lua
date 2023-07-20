local internalNpcName = "Iron Quartermaster"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1445,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 38,
	lookFeet = 38,
	lookAddons = 0
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{text = 'Trading tokens! Iron level equipment available!'}
}

npcConfig.currency = 22720

npcConfig.shop = {
	{ name = "avenger", clientId = 6527, buy = 100 },
	{ name = "arbalest", clientId = 5803, buy = 100 },
	{ name = "warsinger bow", clientId = 8026, buy = 100 },
	{ name = "stonecutter axe", clientId = 3319, buy = 75 },
	{ name = "ornate mace", clientId = 14001, buy = 75 },
	{ name = "magic sword", clientId = 3288, buy = 75 },
	{ name = "dream blossom staff", clientId = 25700, buy = 75 },
	{ name = "zaoan helmet", clientId = 10385, buy = 50 },
	{ name = "zaoan legs", clientId = 10387, buy = 50 },
	{ name = "paladin armor", clientId = 14086, buy = 50 },
	{ name = "calopteryx cape", clientId = 3391, buy = 50 },
	{ name = "grasshopper legs", clientId = 14087, buy = 50 },
	{ name = "rubber cap", clientId = 21165, buy = 50 },
	{ name = "oriental shoes", clientId = 21981, buy = 25 },
	{ name = "draken boots", clientId = 4033, buy = 25 },
	{ name = "snake god's wristguard", clientId = 11691, buy = 25 },
	{ name = "mastermind shield", clientId = 3414, buy = 25 },
	{ name = "gearwheel chain", clientId = 21170, buy = 25 },
	{ name = "butterfly ring", clientId = 25698, buy = 25 },
	{ itemName = "(x1000) basic exercise sword", clientId = 28552, buy = 10 },
	{ itemName = "(x1000) basic exercise wand", clientId = 28557, buy = 10 },
	{ itemName = "(x1000) basic exercise bow", clientId = 28555, buy = 10 },
	--prey reroll x2
}

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)

	if itemId == 28552 or itemId == 28557 or itemId == 28555 then
		for i = 1, amount do
			npc:sellItem(player, itemId, amount, 42069, 0, ignore, inBackpacks)
			local item = player:getItemById(itemId, true, 42069)
			item:remove()

			local inboxItem = inbox:addItem(itemId, 1000)
			inboxItem:setAttribute(ITEM_ATTRIBUTE_STORE, systemTime())
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
		npcHandler:say({"{Iron Tokens} are pieces of currency. You can use them to buy mid level (level 100) equipment from token traders like me.",
						"You can gain iron tokens from advancing levels. For each level gained in the range of 100-150, you will earn 5 {iron tokens}.", "You can also earn iron tokens by completing tier 2 {hunting tasks}."}, npc, creature)
	elseif MsgContains(message, "tokens") then
		npc:openShopWindow(creature)
		npcHandler:say("If you have any iron tokens with you, let's have a look! These are my offers.", npc, creature)
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