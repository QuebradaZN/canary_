local mType = Game.createMonsterType("Izcandar the Banished")
local monster = {}

monster.description = "Izcandar the Banished"
monster.experience = 55000
monster.outfit = {
	lookType = 1137,
	lookHead = 19,
	lookBody = 95,
	lookLegs = 76,
	lookFeet = 38,
	lookAddons = 2,
	lookMount = 0
}

monster.bosstiary = {
	bossRaceId = 1699,
	bossRace = RARITY_NEMESIS,
}

monster.health = 320000
monster.maxHealth = 320000
monster.race = "blood"
monster.corpse = 6068
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
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
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 9},
	{name = "silver token", chance = 100000, maxCount = 2},
	{name = "piggy bank", chance = 100000},
	{name = "mysterious remains", chance = 100000},
	{name = "energy bar", chance = 100000},
	{name = "gold token", chance = 83330, maxCount = 3},
	{name = "supreme health potion", chance = 66670, maxCount = 14},
	{name = "ultimate spirit potion", chance = 66670, maxCount = 5},
	{name = "royal star", chance = 50000, maxCount = 199},
	{name = "ultimate mana potion", chance = 50000, maxCount = 22},
	{name = "blue gem", chance = 50000},
	{name = "crystal coin", chance = 33330, maxCount = 3},
	{name = "gold ingot", chance = 33330},
	{name = "collar of blue plasma", chance = 33330},
	{name = "red gem", chance = 33330},
	{name = "giant shimmering pearl", chance = 33330},
	{name = "huge chunk of crude iron", chance = 33330},
	{name = "bullseye potion", chance = 16670},
	{name = "magic sulphur", chance = 16670},
	{name = "mastermind potion", chance = 16670},
	{name = "soul stone", chance = 16670},
	{name = "green gem", chance = 16670},
	{name = "ring of green plasma", chance = 16670},
	{name = "yellow gem", chance = 16670},
	{name = "skull staff", chance = 16670},
	{name = "pomegranate", chance = 16670},
	{name = "platinum coin", chance = 96880},
	{name = "silver token", chance = 96880, maxCount = 3},
	{name = "piggy bank", chance = 93750},
	{name = "energy bar", chance = 93750},
	{name = "mysterious remains", chance = 93750},
	{name = "gold token", chance = 71880},
	{name = "supreme health potion", chance = 59380, maxCount = 20},
	{name = "ultimate spirit potion", chance = 56250, maxCount = 20},
	{name = "ultimate mana potion", chance = 56250, maxCount = 20},
	{name = "huge chunk of crude iron", chance = 50000},
	{name = "royal star", chance = 40630},
	{name = "yellow gem", chance = 34380, maxCount = 2},
	{name = "bullseye potion", chance = 25000},
	{name = "crystal coin", chance = 25000, maxCount = 2},
	{name = "red gem", chance = 25000, maxCount = 2},
	{name = "green gem", chance = 21880, maxCount = 2},
	{name = "blue gem", chance = 21880},
	{name = "berserk potion", chance = 18750},
	{name = "giant shimmering pearl", chance = 18750},
	{name = "soul stone", chance = 15630},
	{name = "pomegranate", chance = 15630},
	{name = "ring of the sky", chance = 12500},
	{name = "collar of green plasma", chance = 12500},
	{name = "gold ingot", chance = 12500},
	{name = "mastermind potion", chance = 9380},
	{name = "collar of blue plasma", chance = 9380},
	{name = "ring of red plasma", chance = 9380},
	{name = "collar of red plasma", chance = 9380},
	{name = "chaos mace", chance = 9380},
	{name = "winterblade", chance = 6250},
	{name = "skull staff", chance = 6250},
	{name = "ring of blue plasma", chance = 6250},
	{name = "giant sapphire", chance = 3130},
	{name = "summerblade", chance = 3130},
	{name = "ring of green plasma", chance = 3130},
	{name = "arcane staff", chance = 3130},
	{name = "violet gem", chance = 3130},
	{name = "izcandars sundial", chance = 3130},
	{name = "izcandars snow globe", chance = 3130},
}

monster.attacks = {
	{ name ="melee", interval = 2000, chance = 100, minDamage = -300, maxDamage = -500 },
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = 0, maxDamage = -120, range = 7, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -150, maxDamage = -950, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -60, maxDamage = -950, length = 5, spread = 2, effect = CONST_ME_ICETORNADO, target = false},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = 8300, length = 8, spread = 0, effect = CONST_ME_PURPLEENERGY, target = false},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -210, maxDamage = -300, range = 1, shootEffect = CONST_ANI_ENERGY, target = false},
	{name ="speed", interval = 2000, chance = 15, speedChange = -700, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, duration = 30000}
}

monster.defenses = {
	defense = 60,
	armor = 60,
--	mitigation = ???,
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 5},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE, percent = 0},
	{type = COMBAT_DEATHDAMAGE, percent = 10},
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
