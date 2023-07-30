local mType = Game.createMonsterType("Crypt Warden")
local monster = {}

monster.description = "a crypt warden"
monster.experience = 8400
monster.outfit = {
	lookType = 1190,
	lookHead = 41,
	lookBody = 38,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1805
monster.Bestiary = {
	class = "Magical",
	race = BESTY_RACE_MAGICAL,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Kilmaresh Catacombs."
}

monster.health = 8300
monster.maxHealth = 8300
monster.race = "blood"
monster.corpse = 31650
monster.speed = 145
monster.manaCost = 0

monster.faction = FACTION_ANUMA
monster.enemyFactions = {FACTION_FAFNAR, FACTION_PLAYER}

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 100,
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
	{text = "You set foot on forbidden ground? Outrageous!", yell = false},
	{text = "Let the deceased rest in peace!", yell = false},
	{text = "Sacrilege!", yell = false},
}

monster.loot = {
	{name = "platinum coin", chance = 100000, maxCount = 3},
	{name = "cyan crystal fragment", chance = 13670},
	{name = "green crystal fragment", chance = 1770},
	{name = "lamassu horn", chance = 10770},
	{name = "lamassu hoof", chance = 9700},
	{name = "small amethyst", chance = 8680},
	{name = "gold ingot", chance = 4660},
	{name = "green gem", chance = 1290},
	{name = "elven amulet", chance = 800}
}

-- TODO: monster-abilities
--monster.attacks = {
--	{name ="melee", interval = 2000, chance = 100, minDamage = -0, maxDamage = -570},
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_HOLYDAMAGE, minDamage = -300, maxDamage = -500, range = ?, effect = <>, target = ?}, --Holy Beam
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -350, range = ?, effect = <>, target = ?}, --Earth Explosion on itself
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -350, range = ?, effect = <>, target = ?}, --Earth X on itself
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -0, maxDamage = -0, range = ?, effect = <>, target = ?}, --Earth Ring
--}
monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -500},
	{name ="warden x", interval = 2000, chance = 15, minDamage = -250, maxDamage = -430, target = false},
	{name ="warden ring", interval = 2000, chance = 8, minDamage = -250, maxDamage = -380, target = false},
	{name ="combat", interval = 2000, chance = 12, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -480, radius = 2, effect = CONST_ME_GROUNDSHAKER, target = false},
	{name ="combat", interval = 2000, chance = 13, type = COMBAT_HOLYDAMAGE, minDamage = -300, maxDamage = -450, length = 5, spread = 3, effect = CONST_ME_HOLYAREA, target = false}
}

monster.defenses = {
	defense = 84,
	armor = 84,
	mitigation = 2.31,
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 20},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE, percent = 25},
	{type = COMBAT_DEATHDAMAGE, percent = -35},
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
