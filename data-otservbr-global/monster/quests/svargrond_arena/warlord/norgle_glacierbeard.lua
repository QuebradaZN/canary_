local mType = Game.createMonsterType("Norgle Glacierbeard")
local monster = {}

monster.description = "Norgle Glacierbeard"
monster.experience = 2100
monster.outfit = {
	lookType = 257,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 4280
monster.maxHealth = 4280
monster.race = "blood"
monster.corpse = 7349
monster.speed = 97
monster.manaCost = 0

monster.changeTarget = {
	interval = 0,
	chance = 0
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I'll extinguish you warmbloods.", yell = false },
	{ text = "REVENGE!", yell = true },
	{ text = "Far too hot.", yell = false },
	{ text = "DISGUSTING WARMBLOODS!", yell = true },
	{ text = "Revenge is sweetest when served cold.", yell = false },
}

monster.loot = {
}

-- TODO: monster-abilities
--monster.attacks = {
--	{name ="melee", interval = 2000, chance = 100, minDamage = -0, maxDamage = -279},
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -?, maxDamage = -?, range = ?, effect = <>, target = ?}, --Dizzy Hits
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -93, maxDamage = -121, range = ?, effect = <>, target = ?}, --Smoke Wave
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -0, maxDamage = -0, range = ?, effect = <>, target = ?}, --Paralyze
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -119, maxDamage = -159, range = ?, effect = <>, target = ?}, --Snowball Bomb
--	{name ="healing", interval = 2000, chance = 20, minDamage = 66, maxDamage = 90 },
--}
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -225 }
}

monster.defenses = {
	defense = 27,
	armor = 25
	--	mitigation = ???,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 100 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -1 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false }
}

mType:register(monster)
