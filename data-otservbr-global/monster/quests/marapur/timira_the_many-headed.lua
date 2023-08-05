local mType = Game.createMonsterType("Timira the Many-Headed")
local monster = {}

monster.name = "Timira The Many-Headed"
monster.description = "Timira the Many-Headed"
monster.experience = 45500
monster.outfit = {
	lookType = 1542,
}

monster.bosstiary = {
	bossRaceId = 2250,
	bossRace = RARITY_ARCHFOE,
	storageCooldown = Storage.Marapur.Timira,
}

monster.health = 75000
monster.maxHealth = 75000
monster.race = "blood"
monster.corpse = 39712
monster.speed = 400
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 25
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
	staticAttackChance = 70,
	targetDistance = 1,

	healthHidden = false,

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
	{text = "Harmony is just a vain illusion! ", yell = false},
	{text = " I'm ashamed of my former self! ", yell = false},
	{text = " You won't lead me astray!", yell = false},
}

monster.loot = {
	{name="crystal coin",chance = 100000, maxCount = 22},
	{name="ultimate mana potion", chance = 32653, maxCount = 14},
	{name="ultimate health potion",chance = 30612, maxCount = 14},
	{name= "bullseye potion",chance = 24490, maxCount = 5},
	{name= "berserk potion",chance = 22449, maxCount = 5},
	{name = "mastermind potion",chance = 18367, maxCount = 5},
	{name = "naga basin", chance = 12245},
	{name = "piece of timira's sensors", chance = 10204},
	{name = "giant amethyst", chance = 6122},
	{name = "giant ruby", chance = 4082},
	{name = "giant emerald", chance = 4082},
	{name = "one of timira's many heads", chance = 2041},
	{name = "giant sapphire", chance = 2041},
	{name = "giant topaz", chance = 2041},
	{name = "dawnfire sherwani", chance = 200},
	{name = "frostflower boots", chance = 200},
	{id = 39233, chance = 200}, -- enchanted turtle amulet
	{name = "midnight tunic", chance = 200},
	{name = "midnight sarong", chance = 200},
	{name = "naga sword", chance = 200},
	{name = "naga axe", chance = 200},
	{name = "naga club", chance = 200},
	{name = "naga wand", chance = 200},
	{name = "naga rod", chance = 200},
	{name = "naga crossbow", chance = 200}
}

-- TODO: monster-abilities
--monster.attacks = {
--	{name ="melee", interval = 2000, chance = 100, minDamage = -0, maxDamage = -230+},
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -, maxDamage = -, range = ?, effect = <>, target = ?}, --Fire Ring
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -560, maxDamage = -577, range = ?, effect = <>, target = ?}, --Fire Ultimate Explosion
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -, maxDamage = -, range = ?, effect = <>, target = ?}, --Fire Bomb
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -, maxDamage = -, range = ?, effect = <>, target = ?}, --Death Chain
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -273, maxDamage = -273, range = ?, effect = <>, target = ?}, --Energy Strike
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -150~, maxDamage = -150~, range = ?, effect = <>, target = ?}, --Purple Chain
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -, maxDamage = -, range = ?, effect = <>, target = ?}, --Explosion Wave
--	{name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -maybe healing, maxDamage = -maybe healing, range = ?, effect = <>, target = ?}, --Swarm
--}
monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -800, maxDamage = -1600},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -700, maxDamage = -1200, radius = 7, target = false, effect = CONST_ME_HITBYFIRE},
	{name ="combat", interval = 1800, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -700, maxDamage = -1500, range = 7, radius = 1, target = true, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYHIT},
	{name ="combat", interval = 3000, chance = 30, type = COMBAT_MANADRAIN, minDamage = -100, maxDamage = -700, effect = CONST_ME_PURPLEENERGY}
}

monster.defenses = {
	defense = 60,
	armor = 82,
--	mitigation = ???,
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 10},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE, percent = 0},
	{type = COMBAT_DEATHDAMAGE, percent = 10},
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType:register(monster)
