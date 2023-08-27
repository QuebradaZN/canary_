local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)

local physicalCombat = Combat()
physicalCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
physicalCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
physicalCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)

local energyCombat = Combat()
energyCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
energyCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
energyCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)

local earthCombat = Combat()
earthCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
earthCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_CARNIPHILA)
earthCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLEARTH)

local fireCombat = Combat()
fireCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
fireCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREATTACK)
fireCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)

local iceCombat = Combat()
iceCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
iceCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
iceCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLICE)

local holyCombat = Combat()
holyCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
holyCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
holyCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)

local deathCombat = Combat()
deathCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
deathCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
deathCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)

combats = { physicalCombat, energyCombat, earthCombat, fireCombat, iceCombat, holyCombat, deathCombat }

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	local distSkill = player:getEffectiveSkillLevel(SKILL_DISTANCE)

	local min = (level / 1.5) + (distSkill * 4.605) / 1.4 + 28
	local max = (level / 1.5) + (distSkill * 7.395) / 1.4 + 46

	return -min, -max
end

function onGetFormulaValuesSharpshooter(player, skill, attack, factor)
	local level = player:getLevel()
	local distSkill = player:getEffectiveSkillLevel(SKILL_DISTANCE)

	local min = (level / 1.5) + (distSkill * 4.605) / 1.4 + 28
	local max = (level / 1.5) + (distSkill * 7.395) / 1.4 + 46

	return -1.2 * min, -1.2 * max
end

physicalCallback = onGetFormulaValuesSharpshooter
earthCallback = onGetFormulaValuesSharpshooter
energyCallback = onGetFormulaValuesSharpshooter
fireCallback = onGetFormulaValuesSharpshooter
iceCallback = onGetFormulaValuesSharpshooter
holyCallback = onGetFormulaValuesSharpshooter
deathCallback = onGetFormulaValuesSharpshooter

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
physicalCombat:setCallback(CALLBACK_PARAM_SKILLVALUE, "physicalCallback")
energyCombat:setCallback(CALLBACK_PARAM_SKILLVALUE, "energyCallback")
earthCombat:setCallback(CALLBACK_PARAM_SKILLVALUE, "earthCallback")
fireCombat:setCallback(CALLBACK_PARAM_SKILLVALUE, "fireCallback")
iceCombat:setCallback(CALLBACK_PARAM_SKILLVALUE, "iceCallback")
holyCombat:setCallback(CALLBACK_PARAM_SKILLVALUE, "holyCallback")
deathCombat:setCallback(CALLBACK_PARAM_SKILLVALUE, "deathCallback")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local target = Creature(var:getNumber())
	local player = creature:getPlayer()

	if not target or not target:isMonster() then
		creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if player and target then
		if player:getBuffStacks() > 0 then
			local monsterType = target:getType()
			local resistanceTable = monsterType:getElementList()
			local lowestResistanceValue = 100
			local lowestResistanceType = COMBAT_PHYSICALDAMAGE
			local resistancePhysical = resistanceTable[COMBAT_PHYSICALDAMAGE]
			local resistanceEnergy = resistanceTable[COMBAT_ENERGYDAMAGE]
			local resistanceEarth = resistanceTable[COMBAT_EARTHDAMAGE]
			local resistanceFire = resistanceTable[COMBAT_FIREDAMAGE]
			local resistanceIce = resistanceTable[COMBAT_ICEDAMAGE]
			local resistanceHoly = resistanceTable[COMBAT_HOLYDAMAGE]
			local resistanceDeath = resistanceTable[COMBAT_DEATHDAMAGE]

			if resistancePhysical < lowestResistanceValue then
				lowestResistanceValue = resistancePhysical
				lowestResistanceType = COMBAT_PHYSICALDAMAGE
			end

			if resistanceEnergy < lowestResistanceValue then
				lowestResistanceValue = resistanceEnergy
				lowestResistanceType = COMBAT_ENERGYDAMAGE
			end

			if resistanceEarth < lowestResistanceValue then
				lowestResistanceValue = resistanceEarth
				lowestResistanceType = COMBAT_EARTHDAMAGE
			end

			if resistanceFire < lowestResistanceValue then
				lowestResistanceValue = resistanceFire
				lowestResistanceType = COMBAT_FIREDAMAGE
			end

			if resistanceIce < lowestResistanceValue then
				lowestResistanceValue = resistanceIce
				lowestResistanceType = COMBAT_ICEDAMAGE
			end

			if resistanceHoly < lowestResistanceValue then
				lowestResistanceValue = resistanceHoly
				lowestResistanceType = COMBAT_HOLYDAMAGE
			end

			if resistanceDeath < lowestResistanceValue then
				lowestResistanceValue = resistanceDeath
				lowestResistanceType = COMBAT_DEATHDAMAGE
			end

			if lowestResistanceType == COMBAT_PHYSICALDAMAGE then
				physicalCombat:execute(creature, var)
			end

			if lowestResistanceType == COMBAT_ENERGYDAMAGE then
				energyCombat:execute(creature, var)
			end

			if lowestResistanceType == COMBAT_EARTHDAMAGE then
				earthCombat:execute(creature, var)
			end

			if lowestResistanceType == COMBAT_FIREDAMAGE then
				fireCombat:execute(creature, var)
			end

			if lowestResistanceType == COMBAT_ICEDAMAGE then
				iceCombat:execute(creature, var)
			end

			if lowestResistanceType == COMBAT_HOLYDAMAGE then
				holyCombat:execute(creature, var)
			end

			if lowestResistanceType == COMBAT_DEATHDAMAGE then
				deathCombat:execute(creature, var)
			end

			player:addCondition(createBuffStacksCondition(player:getBuffStacks() - 1))

			if player:getBuffStacks() == 0 then
				creature:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, 5)
			end
		else
			combat:execute(creature, var)
		end
	end
	return true
end

spell:group("attack")
spell:id(57)
spell:name("Strong Ethereal Spear")
spell:words("exori gran con")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_STRONG_ETHEREAL_SPEAR)
spell:level(90)
spell:mana(55)
spell:isPremium(true)
spell:range(7)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(8 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()
