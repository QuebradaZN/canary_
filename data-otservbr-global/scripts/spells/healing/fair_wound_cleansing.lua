local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

function onGetFormulaValues(player, level, magicLevel) -- already compared to the official tibia | compared date: 05/07/19(m/d/y)
	local party = player:getParty()
	local hasSynergy = false
	local multiplier = 1.0
	if party and party:isSharedExperienceEnabled() then
		hasSynergy = party:hasSorcerer()
	end

	if hasSynergy then
		multiplier = 1.05
	end

	local min = (level * 0.2 + magicLevel * 4 + 25) * 2 * multiplier
	local max = (level * 0.2 + magicLevel * 7.95 + 51) * 2 * multiplier
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:group("healing")
spell:id(239)
spell:name("Fair Wound Cleansing")
spell:words("exura med ico")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FAIR_WOUND_CLEANSING)
spell:level(300)
spell:mana(90)
spell:isPremium(true)
spell:isSelfTarget(true)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:isAggressive(false)
spell:vocation("knight;true", "elite knight;true")
spell:needLearn(false)
spell:register()
