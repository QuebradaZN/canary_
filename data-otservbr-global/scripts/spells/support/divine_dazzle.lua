local combat = Combat()
combat:setParameter(COMBAT_PARAM_CHAIN_EFFECT, CONST_ME_DIVINE_DAZZLE)

local function synergies(player)
	if not player then return {} end

	local party = player:getParty()
	local val = {
		knight = false,
		druid = false
	}
	if party and party:isSharedExperienceEnabled() then
		if party:hasKnight() then val.knight = true end
		if party:hasDruid() then val.druid = true end
	end
	return val
end

function canChain(creature, target)
	if not creature or not target then
		return false
	end
	if target:isMonster() then
		local player = creature:getPlayer()
		local monster = target:getMonster()
		if monster:getType():isRewardBoss() then
			return false
		end
		if synergies(player).knight and monster:isChallenged() then return false end

		if synergies(player).druid and not monster:isChallenged() then
			return true
		elseif synergies(player).druid and monster:getTarget() and monster:getTarget():getId() ~= creature:getId() then
			return true
		elseif monster:getPosition():getDistance(player:getPosition()) > 1 and monster:getType():getTargetDistance() > 1 then
			return true
		end
		return false
	end
	return false
end
combat:setCallback(CALLBACK_PARAM_CHAINPICKER, "canChain")

function getChainValue(creature)
	local targets = 6
	local player = creature:getPlayer()
	if creature and player then
		targets = targets + player:getWheelSpellAdditionalTarget("Divine Dazzle")
	end
	return targets, 8, false
end
combat:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValue")

function onChain(creature, target)
	local duration = 20000
	local player = creature:getPlayer()
	if synergies(player).knight then
		duration = duration + 10000
	end

	if player then
		duration = duration + (player:getWheelSpellAdditionalDuration("Divine Dazzle") * 1000)
	end
	if target and target:isMonster() then
		local monster = target:getMonster()
		local speedBoost = 20
		if synergies(player).knight then
			speedBoost = speedBoost + 20
		end
		local monsterHaste = createConditionObject(CONDITION_HASTE)
		setConditionParam(monsterHaste, CONDITION_PARAM_TICKS, duration)
		setConditionParam(monsterHaste, CONDITION_PARAM_SPEED, monster:getBaseSpeed() + 20)
		monster:addCondition(monsterHaste)
		if not monster:isChallenged() then
			monster:changeTargetDistance(1, duration)
			if synergies(player).druid then
				doChallengeCreature(player, monster, 6000)
			end
		end
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
spell:id(238)
spell:name("Divine Dazzle")
spell:words("exana amp res")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_DAZZLE)
spell:level(250)
spell:mana(80)
spell:isAggressive(false)
spell:isPremium(true)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("paladin;true", "royal paladin;true")
spell:needLearn(false)
spell:register()
