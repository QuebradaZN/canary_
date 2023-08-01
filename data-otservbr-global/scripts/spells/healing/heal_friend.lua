local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

function onGetFormulaValues(player, level, magicLevel)
	local min = (level * 0.2 + magicLevel * 10) + 3
	local max = (level * 0.2 + magicLevel * 14) + 5
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

	local groupCooldown = 1000
	if hasSynergy then
		groupCooldown = 800
	end
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	if combat:execute(creature, variant) then
		local condition = Condition(CONDITION_SPELLGROUPCOOLDOWN , 2)
		condition:setTicks((groupCooldown) / configManager.getFloat(configKeys.RATE_SPELL_COOLDOWN))
		creature:addCondition(condition)
		return true
	end
	return false
end

spell:name("Heal Friend")
spell:words("exura sio")
spell:group("healing")
spell:vocation("druid;true", "elder druid;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_HEAL_FRIEND)
spell:id(84)
spell:cooldown(1000)
spell:groupCooldown(0) -- group cooldown is calculated on the casting
spell:level(18)
spell:mana(120)
spell:needTarget(true)
spell:hasParams(true)
spell:hasPlayerNameParam(true)
spell:allowOnSelf(false)
spell:isAggressive(false)
spell:isPremium(true)
spell:register()
