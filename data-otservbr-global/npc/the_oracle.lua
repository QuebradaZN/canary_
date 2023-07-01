local internalNpcName = "The Oracle"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookTypeEx = 2031
}

npcConfig.flags = {
	floorchange = false
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

local vocation = {}
local town = {}
local config = {
	towns = {
		["venore"] = TOWNS_LIST.VENORE,
		["thais"] = TOWNS_LIST.THAIS,
		["carlin"] = TOWNS_LIST.CARLIN
	},
	vocations = {
		["sorcerer"] = {
			text = "A SORCERER! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!",
			vocationId = VOCATION.ID.SORCERER
		},
		["druid"] = {
			text = "A DRUID! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!",
			vocationId = VOCATION.ID.DRUID
		},
		["paladin"] = {
			text = "A PALADIN! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!",
			vocationId = VOCATION.ID.PALADIN
		},
		["knight"] = {
			text = "A KNIGHT! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!",
			vocationId = VOCATION.ID.KNIGHT,
		}
	},
	starterItems = {
		[VOCATION.ID.KNIGHT] = {
			backpack = 2870,
			items = {
				7461, -- Krimhorn Helmet
				3357, -- Plate Armor
				3557, -- Plate Legs
				3428, -- Dwarven Shield
				7408, -- Wyvern Fang
				3572, -- Scarf
			}
		},
		[VOCATION.ID.PALADIN] = {
			backpack = 2866,
			items = {
				3575, -- Wood Cape
				3571, -- Ranger's Cloak
				8095, -- Ranger Legs
				7438, -- Elvish Bow
				3447, -- Arrow
				35562, -- Quiver
				3349, -- Crossbow
				3446, -- Bolt
				3428, -- Dwarven Shield
				3572, -- Scarf
			}
		},
		[VOCATION.ID.DRUID] = {
			backpack = 2865,
			items = {
				3210, -- Hat of the Mad
				8042, -- Spirit Cloak
				9014, -- Leaf Legs
				8072, -- Spellbook of Enlightenment
				3066, -- Snakebite Rod
				3572, -- Scarf
			}
		},
		[VOCATION.ID.SORCERER] = {
			backpack = 2867,
			items = {
				3210, -- Hat of the Mad
				8042, -- Spirit Cloak
				24404, -- Tatty Dragon Scale Legs
				8072, -- Spellbook of Enlightenment
				3074, -- Wand of Vortex
				3572, -- Scarf
			}
		},
	}
}

local function greetCallback(npc, creature)
	local playerId = creature:getId()
	local player = Player(creature)
	local level = player:getLevel()
	if level < 8 then
		npcHandler:say("CHILD! COME BACK WHEN YOU HAVE GROWN UP!", npc, creature)
		npcHandler:resetNpc(creature)
		return false
	elseif level > 10 then
		npcHandler:say(player:getName() ..", I CAN'T LET YOU LEAVE - YOU ARE TOO STRONG ALREADY! \z
		YOU CAN ONLY LEAVE WITH LEVEL 9 OR LOWER.", npc, creature)
		npcHandler:resetNpc(creature)
		return false
	elseif player:getVocation():getId() > VOCATION.ID.NONE then
		npcHandler:say("YOU ALREADY HAVE A VOCATION!", npc, creature)
		npcHandler:resetNpc(creature)
		return false
	else
		npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", ARE YOU PREPARED TO FACE YOUR DESTINY?")
	end
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if npcHandler:getTopic(playerId) == 0 then
		if MsgContains(message, "yes") then
			npcHandler:say("IN WHICH TOWN DO YOU WANT TO LIVE: {CARLIN}, {THAIS}, OR {VENORE}?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif npcHandler:getTopic(playerId) == 1 then
		local cityTable = config.towns[message:lower()]
		if cityTable then
			town[playerId] = cityTable
			npcHandler:say("IN ".. string.upper(message) .."! AND WHAT PROFESSION HAVE YOU CHOSEN: \z
			{KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		else
			npcHandler:say("IN WHICH TOWN DO YOU WANT TO LIVE: {CARLIN}, {THAIS}, OR {VENORE}?", npc, creature)
		end
	elseif npcHandler:getTopic(playerId) == 2 then
		local vocationTable = config.vocations[message:lower()]
		if vocationTable then
			npcHandler:say(vocationTable.text, npc, creature)
			npcHandler:setTopic(playerId, 3)
			vocation[playerId] = vocationTable.vocationId
		else
			npcHandler:say("{KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", npc, creature)
		end
	elseif npcHandler:getTopic(playerId) == 3 then
		if MsgContains(message, "yes") then
			npcHandler:say("SO BE IT!", npc, creature)
			local starter = config.starterItems[vocation[playerId]]
			local items = starter.items
			player:setBankBalance(player:getBankBalance() + 10000)
			local backpack = player:addItem(starter.backpack, INDEX_WHEREEVER, FLAG_NOLIMIT)
			if backpack then
				for i = 1, #items do
					backpack:addItem(items[i], 1, INDEX_WHEREEVER, FLAG_NOLIMIT)
				end
				backpack:addItem(3725, 100, INDEX_WHEREVER, FLAG_NOLIMIT)	-- Brown Mushrooms
				backpack:addItem(16277, 1, INDEX_WHEREEVER, FLAG_NOLIMIT)	-- Adventurer's stone
			end
			player:setVocation(Vocation(vocation[playerId]))
			player:setTown(Town(town[playerId]))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(Town(town[playerId]):getTemplePosition())
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
			npcHandler:say("THEN WHAT? {KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	end
	return true
end

local function onAddFocus(npc, player)
	local playerId = player:getId()
	town[playerId] = 0
	vocation[playerId] = 0
end

local function onReleaseFocus(npc, player)
	local playerId = player:getId()
	town[playerId] = nil
	vocation[playerId] = nil
end

npcHandler:setCallback(CALLBACK_SET_INTERACTION, onAddFocus)
npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:setMessage(MESSAGE_FAREWELL, "COME BACK WHEN YOU ARE PREPARED TO FACE YOUR DESTINY!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "COME BACK WHEN YOU ARE PREPARED TO FACE YOUR DESTINY!")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
