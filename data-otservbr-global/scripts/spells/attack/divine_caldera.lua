local spell = Spell("instant")
local combat = Combat()

combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 7)
	local max = (level / 5) + (maglevel * 9)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function spell.onCastSpell(creature, var)
	-- local condition = Condition(CONDITION_DAZZLED)
	-- condition:setParameter(CONDITION_PARAM_DELAYED, 1)

	-- local player = creature:getPlayer()

	-- if creature and player then
	-- 	local dotDmg = -1 * ((player:getLevel() / 5) + (player:getMagicLevel() * 5)) / 10
	-- 	condition:addDamage(3, 1000, dotDmg/3)
	-- 	combat:addCondition(condition)
	-- end

	return combat:execute(creature, var)
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
