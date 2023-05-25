local spell = Spell("instant")
local combat = Combat()

combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()	
	local min = (level / 5) + (skill + 2 * attack) * 1.0
	local max = (level / 5) + (skill + 2 * attack) * 2.5
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function spell.onCastSpell(creature, var)
	local condition = Condition(CONDITION_BLEEDING)
	condition:setParameter(CONDITION_PARAM_DELAYED, 1)

	local player = creature:getPlayer()
	local weaponAttack = ItemType(player:getSlotItem(CONST_SLOT_LEFT)):getAttack()

	if creature and player and weaponAttack then
		local dotDmg = -1 * ((player:getLevel() / 5) + ((player:getSkillLevel() + 2 * weaponAttack) * 1.8))/ 10
		condition:addDamage(3, 1000, dotDmg/3)
		combat:addCondition(condition)
	end

	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(106)
spell:name("Groundshaker")
spell:words("exori mas")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_GROUNDSHAKER)
spell:level(33)
spell:mana(160)
spell:isPremium(true)
spell:needWeapon(true)
spell:cooldown(16 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("knight;true", "elite knight;true")
spell:register()
