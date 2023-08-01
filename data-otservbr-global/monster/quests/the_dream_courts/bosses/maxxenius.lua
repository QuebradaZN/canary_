local mType = Game.createMonsterType("Maxxenius")
local monster = {}

monster.description = "Maxxenius"
monster.experience = 55000
monster.outfit = {
	lookType = 1142,
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
monster.corpse = 30151
monster.speed = 125
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.bosstiary = {
	bossRaceId = 1697,
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
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 6},
	{name = "gold token", chance = 100000, maxCount = 3},
	{name = "silver token", chance = 100000, maxCount = 3},
	{name = "piggy bank", chance = 100000},
	{name = "energy bar", chance = 100000},
	{name = "mysterious remains", chance = 100000},
	{name = "supreme health potion", chance = 85710, maxCount = 32},
	{name = "royal star", chance = 57140, maxCount = 194},
	{name = "ultimate spirit potion", chance = 57140, maxCount = 9},
	{name = "mastermind potion", chance = 42860, maxCount = 6},
	{name = "yellow gem", chance = 42860},
	{name = "huge chunk of crude iron", chance = 42860},
	{name = "berserk potion", chance = 28570, maxCount = 19},
	{name = "ultimate mana potion", chance = 28570, maxCount = 12},
	{name = "green gem", chance = 28570},
	{name = "ornate locket", chance = 28570},
	{name = "red gem", chance = 28570},
	{name = "crystal coin", chance = 28570},
	{name = "soul stone", chance = 14290},
	{name = "ring of red plasma", chance = 14290},
	{name = "ring of blue plasma", chance = 14290},
	{name = "collar of blue plasma", chance = 14290},
	{name = "magic sulphur", chance = 14290},
	{name = "chaos mace", chance = 14290},
	{name = "gold ingot", chance = 14290},
	{name = "silver token", chance = 96430, maxCount = 3},
	{name = "platinum coin", chance = 92860},
	{name = "piggy bank", chance = 89290},
	{name = "mysterious remains", chance = 85710},
	{name = "energy bar", chance = 82140},
	{name = "ultimate spirit potion", chance = 64290, maxCount = 20},
	{name = "gold token", chance = 60710},
	{name = "royal star", chance = 50000},
	{name = "supreme health potion", chance = 50000, maxCount = 20},
	{name = "yellow gem", chance = 50000, maxCount = 2},
	{name = "ultimate mana potion", chance = 42860, maxCount = 14},
	{name = "huge chunk of crude iron", chance = 42860},
	{name = "mastermind potion", chance = 25000},
	{name = "skull staff", chance = 21430},
	{name = "pomegranate", chance = 21430},
	{name = "giant shimmering pearl", chance = 21430},
	{name = "berserk potion", chance = 17860},
	{name = "giant ruby", chance = 17860},
	{name = "green gem", chance = 17860},
	{name = "collar of red plasma", chance = 17860},
	{name = "crystal coin", chance = 14290, maxCount = 3},
	{name = "red gem", chance = 14290, maxCount = 2},
	{name = "ornate locket", chance = 14290},
	{name = "gold ingot", chance = 14290},
	{name = "bullseye potion", chance = 10710},
	{name = "collar of green plasma", chance = 10710},
	{name = "ring of green plasma", chance = 10710},
	{name = "blue gem", chance = 10710},
	{name = "ring of the sky", chance = 7140},
	{name = "ring of red plasma", chance = 7140},
	{name = "chaos mace", chance = 7140},
	{name = "maxxenius head", chance = 7140},
	{name = "abyss hammer", chance = 3570},
	{name = "collar of blue plasma", chance = 3570},
	{name = "energized limb", chance = 3570},
	{name = "ring of blue plasma", chance = 3570},
	{name = "violet gem", chance = 3570},
	{name = "magic sulphur", chance = 3570},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -500, maxDamage = -1000},
	{name ="energy beam", interval = 2000, chance = 10, minDamage = -500, maxDamage = -1200, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYAREA, target = false},
	{name ="energy wave", interval = 2000, chance = 10, minDamage = -500, maxDamage = -1200, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYAREA, target = false}
}

monster.defenses = {
	defense = 60,
	armor = 60
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 5},
	{type = COMBAT_ENERGYDAMAGE, percent = 600},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 15},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 20}
}

monster.heals = {
{type = COMBAT_ENERGYDAMAGE, percent = 500}
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
