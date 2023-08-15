local mType = Game.createMonsterType("Midnight Asura")
local monster = {}

monster.description = "a midnight asura"
monster.experience = 4100
monster.outfit = {
	lookType = 150,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 90,
	lookFeet = 90,
	lookAddons = 1,
	lookMount = 0
}

monster.raceId = 1135
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 1000,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 25,
	Stars = 3,
	Occurrence = 0,
	Locations = "Asura Palace."
}

monster.health = 3100
monster.maxHealth = 3100
monster.race = "blood"
monster.corpse = 21988
monster.speed = 120
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 80,
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
	{text = "Death and Darkness!", yell = false},
	{text = "Embrace the night!", yell = false},
	{text = "May night fall upon you!", yell = false},
}

monster.loot = {
	{id = 3031, chance = 70980, maxCount = 100}, -- gold coin
	{id = 3035, chance = 80500, maxCount = 6}, -- platinum coin
	{id = 7368, chance = 6640, maxCount = 5}, -- assassin star
	{id = 3027, chance = 3670, maxCount = 2}, -- black pearl
	{id = 3007, chance = 440}, -- crystal ring
	{id = 6558, chance = 14110}, -- flask of demonic blood
	{id = 6499, chance = 9950}, -- demonic essence
	{id = 3028, chance = 5680, maxCount = 3}, -- small diamond
	{id = 3032, chance = 3240, maxCount = 1}, -- small emerald
	{id = 3030, chance = 3090, maxCount = 1}, -- small ruby
	{id = 3029, chance = 5550, maxCount = 3}, -- small sapphire
	{id = 9057, chance = 2910, maxCount = 1}, -- small topaz
	{id = 239, chance = 8450, maxCount = 2}, -- great health potion
	{id = 3026, chance = 5660 }, -- white pearl
	{id = 7404, chance = 350}, -- assassin dagger
	{id = 3041, chance = 290}, -- blue gem
	{id = 3567, chance = 530}, -- blue robe
	{id = 9058, chance = 140}, -- gold ingot
	{id = 21974, chance = 12700}, -- golden lotus brooch
	{id = 3069, chance = 2460}, -- necrotic rod
	{id = 21981, chance = 390}, -- oriental shoes
	{id = 21975, chance = 10740}, -- peacock feather fan
	{id = 8061, chance = 180}, -- skullcracker armor
	{id = 3017, chance = 3650}, -- silver brooch
	{id = 3054, chance = 1050}, -- silver amulet
	{id = 5944, chance = 14580}, -- soul orb
	{id = 8074, chance = 150}, -- spellbook of mind control
	{id = 3403, chance = 2030}, -- tribal mask
	{id = 8082, chance = 760}, -- underworld rod
	{id = 3037, chance = 870} -- yellow gem
}

-- TODO: monster-abilities
--monster.attacks = {
--	{name ="melee", interval = 2000, chance = 100, minDamage = -0, maxDamage = -387+},
--	{name ="healing", interval = 2000, chance = 20, minDamage = 120, maxDamage = 170+},
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -0, maxDamage = -110+, range = ?, effect = <>, target = ?}, --Energy Beam
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -0, maxDamage = -209+, range = ?, effect = <>, target = ?}, --Great Death Beam
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -, maxDamage = -, range = ?, effect = <>, target = ?}, --Invisibility
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -0, maxDamage = -209+, range = ?, effect = <>, target = ?}, --Sudden Death
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -, maxDamage = -, range = ?, effect = <>, target = ?}, --GFB area [[Stars Effect]]
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -0, maxDamage = -107+, range = ?, effect = <>, target = ?}, --Mana Drain
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -0, maxDamage = -95+, range = ?, effect = <>, target = ?}, --Energy Strike
--}
monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -269},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = 0, maxDamage = -70, range = 7, target = false},
	{name ="firefield", interval = 2000, chance = 10, range = 7, radius = 1, shootEffect = CONST_ANI_FIRE, target = true},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -50, maxDamage = -200, length = 8, spread = 3, effect = CONST_ME_PURPLEENERGY, target = false},
	{name ="energy strike", interval = 2000, chance = 10, minDamage = -10, maxDamage = -100, range = 1, target = false},
	{name ="speed", interval = 2000, chance = 15, speedChange = -100, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, duration = 30000}
}

monster.defenses = {
	defense = 55,
	armor = 55,
	mitigation = 1.60,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 50, maxDamage = 100, effect = CONST_ME_MAGIC_BLUE, target = false},
	{name ="speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = -10},
	{type = COMBAT_EARTHDAMAGE, percent = -10},
	{type = COMBAT_FIREDAMAGE, percent = 10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE, percent = 30},
	{type = COMBAT_DEATHDAMAGE, percent = 100},
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
