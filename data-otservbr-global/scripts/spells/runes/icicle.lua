local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)

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
	return Chain.combat(creature, target, combat, 5, 5, CONST_ANI_ICE, true)
end

rune:id(114)
rune:group("attack")
rune:name("icicle rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_ICICLE_RUNE)
rune:runeId(3158)
rune:allowFarUse(true)
rune:charges(5)
rune:level(28)
rune:magicLevel(4)
rune:cooldown(2 * 1000)
rune:groupCooldown(2 * 1000)
rune:needTarget(true) -- True = Solid / False = Creature
rune:register()
