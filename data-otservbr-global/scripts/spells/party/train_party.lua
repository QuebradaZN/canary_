local baseMana = 60

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local position = creature:getPosition()
	local party = creature:getParty()
	if not party then
		creature:sendCancelMessage("No party members in range.")
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local hasSynergy = false
	if party and party:isSharedExperienceEnabled() then
		hasSynergy = party:hasPaladin()
	end

	local boostPercent = 102
	if hasSynergy then
		boostPercent = 105
	end

	local members = {party:getLeader()}

	for _, member in ipairs(party:getMembers()) do
		table.insert(members, member)
	end

	local affectedMembers = {}
	for _, member in ipairs(members) do
		if creature:getId() ~= member:getId() and member:getVocation():getBaseId() ~= VOCATION.BASE_ID.KNIGHT then
			table.insert(affectedMembers, member)
		end
	end

	local tmp = #affectedMembers
	if tmp == 0 then
		creature:sendCancelMessage("No party members in range.")
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local mana = math.ceil((0.9 ^ (tmp - 1) * baseMana) * tmp)
	if creature:getMana() < mana then
		creature:sendCancelMessage(RETURNVALUE_NOTENOUGHMANA)
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end

	creature:addMana(-(mana - baseMana), FALSE)
	creature:addManaSpent((mana - baseMana))

	for _, member in ipairs(affectedMembers) do
		if creature:getId() ~= member:getId() then
			local trainParty = Condition(CONDITION_ATTRIBUTES)
			trainParty:setParameter(CONDITION_PARAM_SUBID, 5)
			trainParty:setParameter(CONDITION_PARAM_TICKS, 30000)
			trainParty:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

			if member:getVocation():getBaseId() == VOCATION.BASE_ID.SORCERER or member:getVocation():getBaseId() == VOCATION.BASE_ID.DRUID then
				trainParty:setParameter(CONDITION_PARAM_STAT_MAGICPOINTSPERCENT, boostPercent)
			elseif member:getVocation():getBaseId() == VOCATION.BASE_ID.PALADIN then
				trainParty:setParameter(CONDITION_PARAM_SKILL_DISTANCEPERCENT, boostPercent)
			end

			member:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
			member:addCondition(trainParty)
		end
	end

	return true
end

spell:name("Train Party")
spell:words("utito mas sio")
spell:group("support")
spell:vocation("knight;true", "elite knight;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_TRAIN_PARTY)
spell:id(126)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(32)
spell:mana(60)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)
spell:needLearn(false)
spell:register()
