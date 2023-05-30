local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STONES)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 2.605) + 28
	local max = (level / 5) + (maglevel * 4.395) + 46
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_RUNICVALUE, "onGetFormulaValues")

local rune = Spell("rune")

function rune.onCastSpell(creature, var, isHotkey)
	local target = Creature(var:getNumber())
	if not target then
		return false
	end
	return Chain.combat(creature, target, combat, 5, 5, CONST_ANI_EARTH, true)
end

rune:id(77)
rune:group("attack")
rune:name("stalagmite rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_STALAGMITE_RUNE)
rune:runeId(3179)
rune:allowFarUse(true)
rune:charges(10)
rune:level(24)
rune:magicLevel(3)
rune:cooldown(2 * 1000)
rune:groupCooldown(2 * 1000)
rune:needTarget(true) -- True = Solid / False = Creature
rune:register()
