local spell = Spell("instant")
local spellId = 1000

function spell.onCastSpell(player, variant)
	return player:dispellFamiliar(spellId)
end

spell:group("support")
spell:id(spellId)
spell:name("Dispell familiar")
spell:words("exana gran res")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_SUMMON_DRUID_FAMILIAR)
spell:level(200)
spell:mana(200)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:isAggressive(false)
spell:vocation("druid;true", "elder druid;true", "paladin;true", "royal paladin;true", "sorcerer;true", "master sorcerer;true", "knight;true", "elite knight;true")
spell:register()
