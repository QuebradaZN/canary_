local spell = Spell("instant")

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local combatSharpshooter = Combat()
combatSharpshooter:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combatSharpshooter:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
combatSharpshooter:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 14)
	local max = (level / 5) + (maglevel * 16)
	return -min, -max
end

function onGetForumulaValuesSharpshooter(player, level, maglevel)
	local min = (level / 5) + (maglevel * 14)
	local max = (level / 5) + (maglevel * 16)
	min = min * 1.1
	max = max * 1.1
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combatSharpshooter:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetForumulaValuesSharpshooter")

function castDivineCalderaSharpshooter(cid, var)
	local creature = Creature(cid)
	if creature and var then
		combatSharpshooter:execute(creature, var)
	end
end

function spell.onCastSpell(creature, var)
	if not creature then return false end
	local player = creature:getPlayer()
	if not player then return false end
	if player:getBuffStacks() > 0 then
		combatSharpshooter:execute(creature, var)
		addEvent(castDivineCalderaSharpshooter, 150, player:getId(), var)
		player:addCondition(createBuffStacksCondition(player:getBuffStacks() - 1))
		if player:getBuffStacks() == 0 then
			creature:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, 5)
		end
	else
		return combat:execute(creature, var)
	end

	return true
end

spell:group("attack")
spell:id(124)
spell:name("Divine Caldera")
spell:words("exevo mas san")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_CALDERA)
spell:level(50)
spell:mana(160)
spell:isPremium(true)
spell:isSelfTarget(true)
spell:cooldown(3 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()
