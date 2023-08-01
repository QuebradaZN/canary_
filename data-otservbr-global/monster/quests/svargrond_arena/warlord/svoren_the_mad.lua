local mType = Game.createMonsterType("Svoren the Mad")
local monster = {}

monster.description = "Svoren the Mad"
monster.experience = 3000
monster.outfit = {
	lookType = 254,
	lookHead = 80,
	lookBody = 61,
	lookLegs = 43,
	lookFeet = 5,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 6310
monster.maxHealth = 6310
monster.race = "blood"
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
	{text = "No mommy NO, Leave me alone!", yell = false},
	{text = "Not that tower again!", yell = false},
	{text = "The cat has grown some horns!", yell = false},
	{text = "What was I doing here again?", yell = false},
	{text = "Are we there soon mommy?", yell = false},
	{text = "Ah madness I embrace you!", yell = false},
}

monster.loot = {
}

-- TODO: monster-abilities
--monster.attacks = {
--	{name ="melee", interval = 2000, chance = 100, minDamage = -0, maxDamage = -516+},
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -Reduces 395, maxDamage = -425 speed points for 15 seconds, range = ?, effect = <>, target = ?}, --White Notes Bomb
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -79, maxDamage = -99, range = ?, effect = <>, target = ?}, --Poison Bomb
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -153, maxDamage = -219, range = ?, effect = <>, target = ?}, --Yellow Music Wave
--	{name ="healing", interval = 2000, chance = 20, minDamage = 74, maxDamage = 88 },
--}
monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -525},
	{name ="speed", interval = 3500, chance = 35, speedChange = -250, range = 1, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, duration = 40}
}

monster.defenses = {
	defense = 27,
	armor = 25
--	mitigation = ???,
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 100},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 100},
	{type = COMBAT_HOLYDAMAGE, percent = 0},
	{type = COMBAT_DEATHDAMAGE, percent = 0},
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
