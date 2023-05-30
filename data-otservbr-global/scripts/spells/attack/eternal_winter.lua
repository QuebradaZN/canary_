local spell = Spell("instant")
local combat = Combat()

combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat:setArea(createCombatArea(AREA_CIRCLE5X5))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 6)
	local max = (level / 5) + (maglevel * 12)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function spell.onCastSpell(creature, var)
	local condition = Condition(CONDITION_FREEZING)
	condition:setParameter(CONDITION_PARAM_DELAYED, 1)

	local player = creature:getPlayer()

	if creature and player then
		local dotDmg = -1 * ((player:getLevel() / 5) + (player:getMagicLevel() * 9)) / 10
		condition:addDamage(3, 1000, dotDmg/3)
		combat:addCondition(condition)
	end

	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(118)
spell:name("Eternal Winter")
spell:words("exevo gran mas frigo")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_ETERNAL_WINTER)
spell:level(60)
spell:mana(1050)
spell:isPremium(true)
spell:range(5)
spell:isSelfTarget(true)
spell:cooldown(20 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("druid;true", "elder druid;true")
spell:register()
