local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)
combat1:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)
combat2:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	local distSkill = player:getEffectiveSkillLevel(SKILL_DISTANCE)

	local min = factor * (level / 2.5) + (distSkill * 4.605) / 3 + 28
	local max = factor * (level / 2.5) + (distSkill * 7.395) / 3 + 46

	return -min, -max
end

function onGetFormulaValuesSharpshooter(player, skill, attack, factor)
	local level = player:getLevel()
	local distSkill = player:getEffectiveSkillLevel(SKILL_DISTANCE)

	local min = factor * (level / 2.5) + (distSkill * 4.605) / 3 + 28
	local max = factor * (level / 2.5) + (distSkill * 7.395) / 3 + 46

	min = min * 0.75
	max = max * 0.75

	return -min, -max
end

combat1:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
combat2:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValuesSharpshooter")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if not creature then return false end
	local player = creature:getPlayer()
	if not player then return false end
	if player:getBuffStacks() > 0 then
		combat2:execute(creature, var)
		addEvent(castEtherealSpearSharpshooter, 150, player:getId(), var)
		addEvent(castEtherealSpearSharpshooter, 300, player:getId(), var)
		addEvent(castEtherealSpearSharpshooter, 450, player:getId(), var)
		addEvent(castEtherealSpearSharpshooter, 600, player:getId(), var)
		player:addCondition(createBuffStacksCondition(player:getBuffStacks() - 1))

		if player:getBuffStacks() == 0 then
			creature:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, 5)
		end
	else
		return combat1:execute(creature, var)
	end

	return true
end

function castEtherealSpearSharpshooter(cid, var)
	local creature = Creature(cid)
	if creature and var then
		combat2:execute(creature, var)
	end
end

spell:group("attack")
spell:id(111)
spell:name("Ethereal Spear")
spell:words("exori con")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_ETHEREAL_SPEAR)
spell:level(23)
spell:mana(25)
spell:isPremium(true)
spell:range(7)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()
