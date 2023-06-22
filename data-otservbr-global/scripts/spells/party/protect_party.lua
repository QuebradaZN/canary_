local combat = Combat()
combat:setArea(createCombatArea(AREA_CIRCLE5X5))
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_SUBID, 2)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, 1)
condition:setParameter(CONDITION_PARAM_TICKS, 2 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_SKILL_DEFENSE, 3)

local baseMana = 90

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local position = creature:getPosition()
	local party = creature:getParty()
	local hasSynergy = false
	if party and party:isSharedExperienceEnabled() then
		hasSynergy = party:hasSorcerer()
	end

	local boostPercent = 99
	if hasSynergy then
		boostPercent = 98
	end

	local members = {party:getLeader()}

	for _, member in ipairs(party:getMembers()) do
		table.insert(members, member)
	end

	local tmp = #members
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

	for _, member in ipairs(members) do
		if creature:getId() ~= member:getId() then
			local trainParty = Condition(CONDITION_ATTRIBUTES)
			trainParty:setParameter(CONDITION_PARAM_SUBID, 5)
			trainParty:setParameter(CONDITION_PARAM_TICKS, 30000)
			trainParty:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
			trainParty:setParameter(CONDITION_PARAM_BUFF_DAMAGERECEIVED, boostPercent)
			member:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
			member:addCondition(trainParty)
		end
	end

	return true
end

spell:name("Protect Party")
spell:words("utamo mas sio")
spell:group("support")
spell:vocation("paladin;true", "royal paladin;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_PROTECT_PARTY)
spell:id(127)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(32)
spell:mana(90)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)
spell:needLearn(false)
spell:register()
