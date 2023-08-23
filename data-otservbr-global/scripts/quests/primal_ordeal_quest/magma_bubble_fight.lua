local stages = {
	NotStarted = 0,
	MagmaCrystals = 1,
	TheEndOfDays = 2,
	MagmaBubble = 3,
	Completed = 4,

	Intermission = -1,
}

local magicFieldId = 39232
local chargedFlameId = 39230
local heatedCrystalId = 39168
local cooledCrystalId = 39169

local fight = {
	stage = stages.NotStarted,

	overheatedZone = Zone('fight.magma-bubble.overheated'),
	bossZone = Zone("bosslever.magma-bubble"),
	spawnZone = Zone('fight.magma-bubble.spawn'),

	events = {},
}

-- top left
fight.overheatedZone:addArea({ x = 33634, y = 32891, z = 15 }, { x = 33645, y = 32898, z = 15 })
fight.overheatedZone:addArea({ x = 33634, y = 32886, z = 15 }, { x = 33648, y = 32892, z = 15 })

-- top right
fight.overheatedZone:addArea({ x = 33651, y = 32890, z = 15 }, { x = 33670, y = 32896, z = 15 })
fight.overheatedZone:addArea({ x = 33664, y = 32896, z = 15 }, { x = 33671, y = 32899, z = 15 })

-- bottom left
fight.overheatedZone:addArea({ x = 33635, y = 32911, z = 15 }, { x = 33643, y = 32929, z = 15 })
fight.overheatedZone:addArea({ x = 33644, y = 32921, z = 15 }, { x = 33647, y = 32928, z = 15 })


-- central area where monsters/boss spawns
fight.spawnZone:addArea({ x = 33644, y = 32899, z = 15 }, { x = 33658, y = 32921, z = 15 })
fight.spawnZone:addArea({ x = 33641, y = 32899, z = 15 }, { x = 33643, y = 32908, z = 15 })
fight.spawnZone:addArea({ x = 33645, y = 32897, z = 15 }, { x = 33660, y = 32898, z = 15 })

fight.spawnZone:trapMonsters()

local callbacks = {
	[stages.MagmaCrystals] = {
		prepare = function()
			local players = fight.bossZone:getPlayers()
			for _, player in ipairs(players) do
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You've entered the volcano.")
			end
		end,

		start = function()
			fight:spawnMonsters("The End of Days", 3, "TheEndOfDaysHealth")
			local crystalPositions = {
				Position(33647, 32891, 15),
				Position(33647, 32926, 15),
				Position(33670, 32898, 15),
			}
			for _, position in ipairs(crystalPositions) do
				local crystal = Game.createMonster("Magma Crystal", position)
				crystal:registerEvent("MagmaCrystalDeath")
			end
		end,
	},

	[stages.TheEndOfDays] = {
		prepare = function()
			local players = fight.bossZone:getPlayers()
			for _, player in ipairs(players) do
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The whole Volcano starts to vibrate! Prepare yourself!")
			end
		end,

		start = function()
			fight:spawnMonsters("The End of Days", 6, "TheEndOfDaysDeath")
		end,

		tick = function()
			local count = 0
			local monsters = fight.bossZone:getMonsters()
			for _, monster in ipairs(monsters) do
				if monster:getName():lower() == "the end of days" then
					count = count + 1
				end
			end
			Spdlog.info("The End of Days has been killed! Count: " .. count)
			if count == 0 then
				fight:setStage(stages.MagmaBubble)
			end
		end,
},

	[stages.MagmaBubble] = {
		prepare = function()
			local players = fight.bossZone:getPlayers()
			for _, player in ipairs(players) do
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You've upset the volcano and now it's going to take its revenge!")
			end
		end,

		start = function()
			local monster = Game.createMonster("Magma Bubble", Position(33654, 32909, 15))
			monster:registerEvent("MagmaBubbleDeath")
			for i = 0, 3 do
				table.insert(fight.events, addEvent(fight.spawnMonsters, (60 * i + 10) * 1000, fight, "Unchained Fire", 4))
			end
		end,
	},
}

function fight:spawnMonsters(name, amount, event)
	for _ = 1, amount do
		local position = self.spawnZone:randomPosition()
		local monster = Game.createMonster(name, position)
		if event then
			monster:registerEvent(event)
		end
	end
end

function fight:enterStage(stage)
	if self.stage == stage then return end
	self.stage = stage
	local callback = callbacks[stage]
	if callback and callback.start then
		callback.start()
	end
end

function fight:prepareStage(stage)
	if self.stage == stage then return end
	local callback = callbacks[stage]
	if callback and callback.prepare then
		callback.prepare()
	end
	addEvent(self.enterStage, 3000, self, stage)
end

function fight:setStage(stage)
	self.stage = stages.Intermission
	self.bossZone:removeMonsters()
	for _, event in ipairs(self.events) do
		stopEvent(event)
	end
	addEvent(self.prepareStage, 100, self, stage)
end

local zoneEvents = ZoneEvent(fight.bossZone)

function zoneEvents.onEnter(zone, creature)
	local player = creature:getPlayer()
	if not player then return true end
	if fight.stage == stages.NotStarted then fight.spawnZone:refresh() end
	fight:setStage(stages.MagmaCrystals)
	return true
end

function zoneEvents.onLeave(zone, creature)
	if not creature:getPlayer() then return true end
	local players = zone:getPlayers()
	if #players > 0 then return true end
	-- last player left, reset the fight
	fight:setStage(stages.NotStarted)
	return true
end

zoneEvents:register()

local function addShieldStack(player)
	local currentIcon = player:getIcon()
	if not currentIcon or currentIcon.category ~= CreatureIconCategory_Quests or currentIcon.icon ~= CreatureIconQuests_GreenShield then
		player:setIcon(CreatureIconCategory_Quests, CreatureIconQuests_GreenShield, 5)
		return true
	end
	player:setIcon(CreatureIconCategory_Quests, CreatureIconQuests_GreenShield, currentIcon.count + 5)
end

local function tickShields(player)
	local currentIcon = player:getIcon()
	if not currentIcon or currentIcon.category ~= CreatureIconCategory_Quests or currentIcon.icon ~= CreatureIconQuests_GreenShield then
		return 0
	end
	if currentIcon.count <= 0 then
		player:clearIcon()
		return 0
	end
	local newCount = currentIcon.count - 1
	player:setIcon(CreatureIconCategory_Quests, CreatureIconQuests_GreenShield, newCount)
	return newCount
end

local overheatedDamage = GlobalEvent("self.magma-bubble.overheated.onThink")
function overheatedDamage.onThink(interval, lastExecution)
	local players = fight.overheatedZone:getPlayers()
	for _, player in ipairs(players) do
		if player:getHealth() <= 0 then goto continue end
		local shields = tickShields(player)
		if shields > 0 then
			local effect = CONST_ME_BLACKSMOKE
			if shields > 20 then
				effect = CONST_ME_GREENSMOKE
			elseif shields > 10 then
				effect = CONST_ME_YELLOWSMOKE
			elseif shields > 5 then
				effect = CONST_ME_REDSMOKE
			elseif shields > 1 then
				effect = CONST_ME_PURPLESMOKE
			end
			player:getPosition():sendMagicEffect(effect)
		else
			local damage = player:getMaxHealth() * 0.6 * -1
			doTargetCombatHealth(0, player, COMBAT_AGONYDAMAGE, damage, damage, CONST_ME_NONE)
		end
		::continue::
	end
	return true
end

overheatedDamage:interval(1000)
overheatedDamage:register()

local crystalsCycle = GlobalEvent("self.magma-bubble.crystals.onThink")

function crystalsCycle.onThink(interval, lastExecution)
	local zoneItems = fight.spawnZone:getItems()
	local minCooled = 2
	local crystals = {}
	for _, item in ipairs(zoneItems) do
		if item:getId() == cooledCrystalId or item:getId() == heatedCrystalId then
			table.insert(crystals, item)
		end
	end
	local shouldChange = math.random(1, 100) <= 50
	if shouldChange and #crystals > 0 then
		local item = crystals[math.random(1, #crystals)]
		local newItemId = item:getId() == cooledCrystalId and heatedCrystalId or cooledCrystalId
		item:transform(newItemId)
	end
	local cooledCount = 0
	local heatedCyrstas = {}
	for _, item in ipairs(zoneItems) do
		if item:getId() == cooledCrystalId then
			cooledCount = cooledCount + 1
		elseif item:getId() == heatedCrystalId then
			table.insert(heatedCyrstas, item)
		end
	end
	if cooledCount < minCooled then
		for _ = 1, minCooled - cooledCount do
			local index = math.random(1, #heatedCyrstas)
			local item = heatedCyrstas[index]
			if item then
				table.remove(heatedCyrstas, index)
				item:transform(cooledCrystalId)
			end
		end
	end
	return true
end

crystalsCycle:interval(4000)
crystalsCycle:register()

local chargedFlameAction = Action()

local function randomPosition(positions)
	local destination = positions[math.random(1, #positions)]
	local tile = destination:getTile()
	while not tile or not tile:isWalkable(false, false, false, false, true) do
		destination = positions[math.random(1, #positions)]
		tile = destination:getTile()
	end
	return destination
end

function chargedFlameAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then return false end
	if not target or not target:isItem() then return false end
	if target:getId() ~= cooledCrystalId then return false end
	target:transform(heatedCrystalId)
	local positions = {
		Position(toPosition.x - 1, toPosition.y, toPosition.z),
		Position(toPosition.x + 1, toPosition.y, toPosition.z),
		Position(toPosition.x, toPosition.y - 1, toPosition.z),
		Position(toPosition.x, toPosition.y + 1, toPosition.z),
		Position(toPosition.x - 1, toPosition.y - 1, toPosition.z),
		Position(toPosition.x + 1, toPosition.y + 1, toPosition.z),
		Position(toPosition.x - 1, toPosition.y + 1, toPosition.z),
		Position(toPosition.x + 1, toPosition.y - 1, toPosition.z),
	}
	local position = randomPosition(positions)
	position:sendMagicEffect(CONST_ME_FIREAREA)
	local field = Game.createItem(magicFieldId, 1, position)
	field:decay()
	item:remove()
end

chargedFlameAction:id(chargedFlameId)
chargedFlameAction:register()

local shieldField = MoveEvent()
function shieldField.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then return false end
	local zones = position:getZones()
	if not zones then return true end
	local found = false
	for _, zone in ipairs(zones) do
		if zone == fight.bossZone then
			found = true
			break
		end
	end
	if not found then return true end

	item:remove()
	addShieldStack(player)
end

shieldField:type("stepin")
shieldField:id(magicFieldId)
shieldField:register()

local theEndOfDaysHealth = CreatureEvent("TheEndOfDaysHealth")
function theEndOfDaysHealth.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType)
	if not creature then return primaryDamage, primaryType, secondaryDamage, secondaryType end
	local newHealth = creature:getHealth() - primaryDamage - secondaryDamage
	if newHealth <= creature:getMaxHealth() * 0.5 then
		creature:setHealth(creature:getMaxHealth())
		fight:spawnMonsters("Lava Creature", 8)
		return false
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

theEndOfDaysHealth:register()

local magmaCrystalDeath = CreatureEvent("MagmaCrystalDeath")
function magmaCrystalDeath.onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
	local crystals = 0
	local monsters = fight.bossZone:getMonsters()
	for _, monster in ipairs(monsters) do
		if monster:getName():lower() == "magma crystal" then
			crystals = crystals + 1
		end
	end
	if crystals == 0 then
		fight:setStage(stages.TheEndOfDays)
		return
	else
		local players = fight.bossZone:getPlayers()
		for _, player in ipairs(players) do
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A magma crystal has been destroyed!")
		end
	end
end

magmaCrystalDeath:register()

local fightTick = GlobalEvent("fight.magma-bubble.tick")
function fightTick.onThink(interval)
	local callback = callbacks[fight.stage]
	if callback and callback.tick then
		callback.tick()
	end
	return true
end
fightTick:interval(1000)
fightTick:register()

local magmaBubbleDeath = CreatureEvent("MagmaBubbleDeath")
function magmaBubbleDeath.onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
	fight:setStage(stages.Completed)
end

magmaBubbleDeath:register()
