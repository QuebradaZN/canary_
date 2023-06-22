local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setArea(createCombatArea(AREA_CIRCLE2X2))

function onTargetCreature(creature, target)
	local party = creature:getParty()
	local hasSynergy = false
	if party and party:isSharedExperienceEnabled() then
		hasSynergy = party:hasDruid()
	end

	local duration = 6000
	if hasSynergy then
		duration = duration + 2000
	end
	if target:isMonster() then
		local monster = target:getMonster()
		if not target:getType():isRewardBoss() then
			monster:changeTargetDistance(1, duration)
		end
	end
	return doChallengeCreature(creature, target, duration)
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("Challenge")
spell:words("exeta res")
spell:group("support")
spell:vocation("elite knight;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_CHALLENGE)
spell:id(93)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(20)
spell:mana(30)
spell:isAggressive(false)
spell:isPremium(true)
spell:needLearn(false)
spell:register()
