--combat for if target exists
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_CHAIN_EFFECT, CONST_ME_YELLOW_ENERGY_SPARK)

local combatSharpshooter = Combat()
combatSharpshooter:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combatSharpshooter:setParameter(COMBAT_PARAM_EFFECT, COMBAT_ME_HOLYDAMAGE)
combatSharpshooter:setParameter(COMBAT_PARAM_CHAIN_EFFECT, CONST_ME_YELLOW_ENERGY_SPARK)


-- combat for if target does not exist
local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)

function onGetFormulaValues(player, level, maglevel)
	local min = 1.7*((level / 5) + (maglevel * 1.79) + 11)
	local max = 1.7*((level / 5) + (maglevel * 3) + 18)
	return -min, -max
end

function onGetFormulaValuesSharpshooter(player, level, maglevel)
	local min = 1.7*((level / 5) + (maglevel * 1.79) + 11)
	local max = 1.7*((level / 5) + (maglevel * 3) + 18)
	return -1.2*min, -1.2*max
end

function onGetFormulaValues2(player, level, maglevel)
	local min = (level / 5) + (maglevel * 1.79) + 11
	local max = (level / 5) + (maglevel * 3) + 18
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combat2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")
combatSharpshooter:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValuesSharpshooter")

local spell = Spell("instant")

function getChainValue(creature)
	return 5, 5, false
end

function getChainValueSharpshooter(creature)
	return 8, 5, false
end

combat:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValue")
combatSharpshooter:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValueSharpshooter")

function spell.onCastSpell(creature, var)
	local target = Creature(var:getNumber())
	local player = creature:getPlayer()
	
	if player and target then
		if player:getBuffStacks() > 0 then
			player:addCondition(createBuffStacksCondition(player:getBuffStacks() - 1))
			
			if player:getBuffStacks() == 0 then
				creature:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, 5)
			end

			return combatSharpshooter:execute(creature, var)
		else
			return combat:execute(creature, var)
		end
	else
		return combat2:execute(creature, var)
	end
end

spell:group("attack")
spell:id(122)
spell:name("Divine Missile")
spell:words("exori san")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_MISSILE)
spell:level(40)
spell:mana(20)
spell:isPremium(true)
spell:range(4)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()