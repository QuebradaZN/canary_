local spell = Spell("instant")
local combat = Combat()

combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setArea(createCombatArea(AREA_CIRCLE5X5))

function onGetFormulaValues(player, level, maglevel)
    local min = (level / 5) + (maglevel * 10)
    local max = (level / 5) + (maglevel * 14)
    return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function spell.onCastSpell(creature, variant)
    local condition = Condition(CONDITION_FIRE)
    condition:setParameter(CONDITION_PARAM_DELAYED, 1)

    local player = creature:getPlayer()

    if creature and player then
        local dotDmg = -1 * ((player:getLevel() / 5) + (player:getMagicLevel() * 12)) / 10
        condition:addDamage(3, 1000, dotDmg/3)
        combat:addCondition(condition)
    end

    return combat:execute(creature, variant)
end

spell:group("attack", "focus")
spell:id(24)
spell:name("Hell's Core")
spell:words("exevo gran mas flam")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_HELL_SCORE)
spell:level(60)
spell:mana(1100)
spell:isSelfTarget(true)
spell:isPremium(true)
spell:cooldown(40 * 1000)
spell:groupCooldown(4 * 1000, 40 * 1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()