local combat = Combat()
combat:setParameter(COMBAT_PARAM_CHAIN_EFFECT, CONST_ME_CHIVALRIOUS_CHALLENGE)
function canChain(creature, target)
	if not creature or not target then
		return false
	end
	if target:isMonster() then
		local monster = target:getMonster()
		if monster:getType():isRewardBoss() then
			return false
		end

		if monster:getPosition():getDistance(creature:getPosition()) > 1 and monster:getType():getTargetDistance() > 1 then
			return true
		elseif not monster:isChallenged() then
			return true
		elseif monster:getTarget() and monster:getTarget():getId() ~= creature:getId() then
			return true
		end
	end
	return false
end

combat:setCallback(CALLBACK_PARAM_CHAINPICKER, "canChain")

function getChainValue(creature)
	local targets = 6
	local player = creature:getPlayer()
	if creature and player then
		targets = targets + player:getWheelSpellAdditionalTarget("Chivalrous Challenge")
	end
	return targets, 6, false
end

combat:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValue")

function onChain(creature, target)
	local party = creature:getParty()
	local hasSynergy = false
	if party and party:isSharedExperienceEnabled() then
		hasSynergy = party:hasPaladin()
	end
	local duration = 20000
	if hasSynergy then
		duration = duration + 10000
	end
	local challengeDuration = 6000
	if hasSynergy then
		challengeDuration = challengeDuration + 2000
	end

	local player = creature:getPlayer()
	if creature and player then
		duration = duration + (player:getWheelSpellAdditionalDuration("Chivalrous Challenge") * 1000)
	end
	if target and target:isMonster() then
		doChallengeCreature(player, target, challengeDuration)
		target:changeTargetDistance(1, duration)
	end
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onChain")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	local spectators = Game.getSpectators(creature:getPosition(), false, false)
	for _, spectator in pairs(spectators) do
		if spectator:isMonster() then
			if spectator:getType():isRewardBoss() then
				creature:sendCancelMessage("You can't use this spell if there's a boss.")
				creature:getPosition():sendMagicEffect(CONST_ME_POFF)
				return false
			end
		end
	end

	if not combat:execute(creature, variant) then
		creature:sendCancelMessage("There are no ranged monsters.")
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	return true
end

spell:group("support")
spell:id(237)
spell:name("Chivalrous Challenge")
spell:words("exeta amp res")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_CHIVALROUS_CHALLENGE)
spell:level(150)
spell:mana(80)
spell:isAggressive(false)
spell:isPremium(true)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("knight;true", "elite knight;true")
spell:needLearn(false)
spell:register()
