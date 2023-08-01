local mType = Game.createMonsterType("Malofur Mangrinder")
local monster = {}

monster.description = "Malofur Mangrinder"
monster.experience = 55000
monster.outfit = {
	lookType = 1120,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 320000
monster.maxHealth = 320000
monster.race = "blood"
monster.corpse = 30017
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.bosstiary = {
	bossRaceId = 1696,
	bossRace = RARITY_NEMESIS
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "RAAAARGH! I'M MASHING YE TO DUST BOOM!", yell = true},
	{text = "BOOOM!", yell = true},
	{text = "BOOOOM!!!", yell = true},
	{text = "BOOOOOM!!!", yell = true},
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 8},
	{name = "silver token", chance = 100000, maxCount = 3},
	{name = "piggy bank", chance = 100000},
	{name = "mysterious remains", chance = 100000},
	{name = "energy bar", chance = 100000},
	{name = "supreme health potion", chance = 80000, maxCount = 29},
	{name = "ultimate spirit potion", chance = 80000, maxCount = 13},
	{name = "gold token", chance = 60000, maxCount = 3},
	{name = "red gem", chance = 40000, maxCount = 2},
	{name = "giant shimmering pearl", chance = 40000},
	{name = "ring of red plasma", chance = 40000},
	{name = "huge chunk of crude iron", chance = 40000},
	{name = "bullseye potion", chance = 20000},
	{name = "royal star", chance = 20000},
	{name = "berserk potion", chance = 20000},
	{name = "ultimate mana potion", chance = 20000},
	{name = "skull staff", chance = 20000},
	{name = "blue gem", chance = 20000},
	{name = "magic sulphur", chance = 20000},
	{name = "platinum coin", chance = 97220},
	{name = "piggy bank", chance = 97220},
	{name = "silver token", chance = 91670, maxCount = 3},
	{name = "energy bar", chance = 88890},
	{name = "mysterious remains", chance = 88890},
	{name = "ultimate spirit potion", chance = 66670, maxCount = 20},
	{name = "gold token", chance = 58330},
	{name = "ultimate mana potion", chance = 55560, maxCount = 20},
	{name = "supreme health potion", chance = 55560, maxCount = 14},
	{name = "royal star", chance = 52780},
	{name = "red gem", chance = 47220},
	{name = "yellow gem", chance = 44440, maxCount = 2},
	{name = "berserk potion", chance = 30560},
	{name = "crystal coin", chance = 25000, maxCount = 2},
	{name = "mastermind potion", chance = 22220},
	{name = "bullseye potion", chance = 22220},
	{name = "collar of red plasma", chance = 22220},
	{name = "gold ingot", chance = 22220},
	{name = "blue gem", chance = 22220},
	{name = "huge chunk of crude iron", chance = 19440},
	{name = "collar of green plasma", chance = 16670},
	{name = "pomegranate", chance = 16670},
	{name = "ring of blue plasma", chance = 13890},
	{name = "green gem", chance = 11110},
	{name = "collar of blue plasma", chance = 8330},
	{name = "soul stone", chance = 8330},
	{name = "ring of green plasma", chance = 8330},
	{name = "skull staff", chance = 8330},
	{name = "chaos mace", chance = 8330},
	{name = "violet gem", chance = 8330},
	{name = "giant shimmering pearl", chance = 8330},
	{name = "ring of red plasma", chance = 5560},
	{name = "magic sulphur", chance = 5560},
	{name = "ring of the sky", chance = 2780},
	{name = "resizer", chance = 2780},
}

monster.attacks = {
	{name = "combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -5500, target = true},	-- -_groundshaker
}

monster.defenses = {
	defense = 60,
	armor = 60
--	mitigation = ???,
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 5},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE, percent = 0},
	{type = COMBAT_DEATHDAMAGE, percent = 0},
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType.onThink = function(monster, interval)
end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)
