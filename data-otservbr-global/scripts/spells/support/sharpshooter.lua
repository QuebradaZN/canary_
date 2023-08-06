local spellDuration = 10000

function createBuffStacksCondition(stacks)
	local condition = Condition(CONDITION_ATTRIBUTES)
	condition:setParameter(CONDITION_PARAM_SUBID, 5)
	condition:setParameter(CONDITION_PARAM_TICKS, spellDuration)
	condition:setParameter(CONDITION_PARAM_BUFF_STACKS, stacks)
	condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
	return condition
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if not creature then return false end
	local player = creature:getPlayer()
	if not player then return false end
	local grade = creature:upgradeSpellsWOD("Sharpshooter")
	local stacks = 1
	if grade == WHEEL_GRADE_UPGRADED then
		stacks = 2
	end
	local condition = createBuffStacksCondition(stacks)
	player:addCondition(condition)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	return true
end

spell:name("Sharpshooter")
spell:words("utito tempo san")
spell:group("support", "focus")
spell:vocation("paladin;true", "royal paladin;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_SHARPSHOOTER)
spell:id(135)
spell:cooldown(10 * 1000)
spell:groupCooldown(2 * 1000, 10 * 1000)
spell:level(60)
spell:mana(450)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(false)
spell:needLearn(false)
spell:register()
