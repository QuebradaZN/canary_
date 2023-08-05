local mType = Game.createMonsterType("The Primal Menace")
local monster = {}

monster.description = "The Primal Menace"
monster.experience = 0
monster.outfit = {
	lookType = 1566,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 5000000
monster.maxHealth = 5000000
monster.race = "blood"
monster.corpse = 39530
monster.speed = 180
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 10
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

monster.summon = {
	maxSummons = 2,
	summons = {
		{name = "Headpecker", chance = 20, interval = 2000},
		{name = "Sulphider", chance = 20, interval = 2000},
	}
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{name = "primal bag", chance = 50},
}

-- TODO: monster-abilities
--monster.attacks = {
--	{name ="melee", interval = 2000, chance = 100, minDamage = -763, maxDamage = -763},
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -1518, maxDamage = -2199, range = ?, effect = <>, target = ?}, --Earth Wave
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -968, maxDamage = -968, range = ?, effect = <>, target = ?}, --Fire Wave
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -258, maxDamage = -276, range = ?, effect = <>, target = ?}, --Death Wave
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -1213, maxDamage = -1221, range = ?, effect = <>, target = ?}, --Energy Strike
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -626, maxDamage = -1811, range = ?, effect = <>, target = ?}, --Poison Missile
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -?, maxDamage = -?, range = ?, effect = <>, target = ?}, --Chain Attack
--	{name ="healing", interval = 2000, chance = 20, minDamage = 0, maxDamage = 0},
--}
monster.attacks = {
	{name ="melee", interval = 2000, chance = 85, minDamage = -2500, maxDamage = -3500},
	{name ="combat", interval = 4000, chance = 35, type = COMBAT_EARTHDAMAGE, minDamage = -3000, maxDamage = -4000, length = 10, spread = 3, effect = CONST_ME_CARNIPHILA, target = false},
	{name ="combat", interval = 2500, chance = 45, type = COMBAT_FIREDAMAGE, minDamage = -3000, maxDamage = -7000, length = 10, spread = 3, effect = CONST_ME_HITBYFIRE, target = false},
	{name ="big death wave", interval = 3500, chance = 35, minDamage = -4000, maxDamage = -7000, target = false},
	{name ="combat", interval = 5000, chance = 40, type = COMBAT_ENERGYDAMAGE, effect = CONST_ME_ENERGYHIT, minDamage = -3500, maxDamage = -4000, range = 4, target = false},
	{name ="combat", interval = 2700, chance = 45, type = COMBAT_EARTHDAMAGE, shootEffect = CONST_ANI_POISON, effect = CONST_ANI_EARTH, minDamage = -1500, maxDamage = -4000, range = 4, target = false},
}

monster.defenses = {
	defense = 80,
	armor = 0,
--	mitigation = ???,
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = -5},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 5},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 50},
	{type = COMBAT_HOLYDAMAGE, percent = 40},
	{type = COMBAT_DEATHDAMAGE, percent = 0},
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
