local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREATTACK)
combat:setParameter(COMBAT_PARAM_CHAIN_EFFECT, CONST_ME_PINK_ENERGY_SPARK)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 2.605) + 28
	local max = (level / 5) + (maglevel * 4.395) + 46
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_RUNICVALUE, "onGetFormulaValues")

local rune = Spell("rune")

function getChainValue(creature)
	return 5, 4, false
end

combat:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValue")

function rune.onCastSpell(creature, var, isHotkey)
	local target = Creature(var:getNumber())
	if not target then
		return false
	end
	return combat:execute(creature, var)
end

rune:id(15)
rune:group("attack")
rune:name("fireball rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_FIREBALL_RUNE)
rune:runeId(3189)
rune:allowFarUse(true)
rune:charges(5)
rune:level(27)
rune:magicLevel(4)
rune:cooldown(2 * 1000)
rune:groupCooldown(2 * 1000)
rune:needTarget(true)
rune:isBlocking(true) -- True = Solid / False = Creature
rune:register()
