local combat = Combat()
local cooldown = 2 * 60 * 1000

combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_REGENERATION)
condition:setParameter(CONDITION_PARAM_TICKS, cooldown)
condition:setParameter(CONDITION_PARAM_HEALTHGAIN, 40)
condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 2 * 1000)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("Intense Recovery")
spell:words("utura gran")
spell:group("healing")
spell:vocation("knight;true", "elite knight;true", "paladin;true", "royal paladin;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_INTENSE_RECOVERY)
spell:id(160)
spell:cooldown(cooldown)
spell:groupCooldown(1000)
spell:level(100)
spell:mana(165)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)
spell:needLearn(false)
spell:register()
