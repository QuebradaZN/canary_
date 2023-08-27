local mType = Game.createMonsterType("Spirit of Earth")
local monster = {}

monster.description = "a spirit of earth"
monster.experience = 800
monster.outfit = {
	lookType = 67,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 1200
monster.maxHealth = 1200
monster.race = "undead"
monster.corpse = 7349
monster.speed = 90
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
	canWalkOnFire = false,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Show your strength ... or perish.", yell = false },
	{ text = "You're so soft and vulnerable.", yell = false },
	{ text = "When the dust settles there will only be one.", yell = false },
}

monster.loot = {
}

-- TODO: monster-abilities
--monster.attacks = {
--	{name ="melee", interval = 2000, chance = 100, minDamage = -0, maxDamage = -180+},
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -0, maxDamage = -130+, range = ?, effect = <>, target = ?}, --Throws [[Small Stone]]
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -67, maxDamage = -170+, range = ?, effect = <>, target = ?}, --Dust Beam
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -97, maxDamage = -160+, range = ?, effect = <>, target = ?}, --Life Drain Berserk
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -Reduces 200, maxDamage = -285+ speed for 15+ seconds, range = ?, effect = <>, target = ?}, --Paralyze
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -poisons up to 13 hp per turn, maxDamage = -poisons up to 13 hp per turn, range = ?, effect = <>, target = ?}, --Poisoning Beam
--	{name ="healing", interval = 2000, chance = 20, minDamage = 66, maxDamage = 127 },
--}
monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -180 }
}

monster.defenses = {
	defense = 0,
	armor = 0
	--	mitigation = ???,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 50 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false }
}

mType:register(monster)
