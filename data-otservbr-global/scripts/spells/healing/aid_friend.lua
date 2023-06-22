local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

function onGetFormulaValues(player, level, magicLevel)
	local min = 0.6 * (level * 0.2 + magicLevel * 10) + 3
	local max = 0.6 * (level * 0.2 + magicLevel * 14) + 5
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	local party = creature:getParty()
	local hasSynergy = false
	if party and party:isSharedExperienceEnabled() then
		hasSynergy = party:hasKnight()
	end

	if not hasSynergy then
		creature:sendCancelMessage("You can't use this spell if there's no knight in your party or shared experience isn't active.")
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return combat:execute(creature, variant)
end

spell:name("Aid Friend")
spell:words("exura med sio")
spell:group("healing")
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:id(84)
spell:cooldown(2000)
spell:groupCooldown(2000)
spell:level(100)
spell:mana(250)
spell:needTarget(true)
spell:hasParams(true)
spell:hasPlayerNameParam(true)
spell:allowOnSelf(false)
spell:isAggressive(false)
spell:isPremium(true)
spell:register()
