local area = createCombatArea({
     {0, 0, 0, 1, 0, 0, 0},
     {0, 1, 1, 1, 1, 1, 0},
     {0, 1, 1, 1, 1, 1, 0},
     {1, 1, 1, 3, 1, 1, 1},
     {0, 1, 1, 1, 1, 1, 0},
     {0, 1, 1, 1, 1, 1, 0},
     {0, 0, 0, 1, 0, 0, 0},
 })

local combat = Combat()

combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DIAMONDARROW)
combat:setParameter(COMBAT_PARAM_IMPACTSOUND, SOUND_EFFECT_TYPE_DIAMOND_ARROW_EFFECT)
combat:setParameter(COMBAT_PARAM_CASTSOUND, SOUND_EFFECT_TYPE_DIST_ATK_BOW)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

function onGetFormulaValues(player, skill, attack, factor)
    local distanceSkill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
    local min = (0.09 * factor) * distanceSkill * 10 + (player:getLevel() / 5)
    local max = (0.09 * factor) * distanceSkill * attack + (player:getLevel() / 5)
    return -min, -max
end

earthCallback = onGetFormulaValues
energyCallback = onGetFormulaValues
fireCallback = onGetFormulaValues
iceCallback = onGetFormulaValues

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
combat:setArea(area)

local earthCombat = Combat()
earthCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
earthCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREENSMOKE)
earthCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DIAMONDARROW)
earthCombat:setParameter(COMBAT_PARAM_IMPACTSOUND, SOUND_EFFECT_TYPE_DIAMOND_ARROW_EFFECT)
earthCombat:setParameter(COMBAT_PARAM_CASTSOUND, SOUND_EFFECT_TYPE_DIST_ATK_BOW)
earthCombat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

local energyCombat = Combat()
energyCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
energyCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PURPLESMOKE)
energyCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DIAMONDARROW)
energyCombat:setParameter(COMBAT_PARAM_IMPACTSOUND, SOUND_EFFECT_TYPE_DIAMOND_ARROW_EFFECT)
energyCombat:setParameter(COMBAT_PARAM_CASTSOUND, SOUND_EFFECT_TYPE_DIST_ATK_BOW)
energyCombat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

local fireCombat = Combat()
fireCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
fireCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREWORK_RED)
fireCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DIAMONDARROW)
fireCombat:setParameter(COMBAT_PARAM_IMPACTSOUND, SOUND_EFFECT_TYPE_DIAMOND_ARROW_EFFECT)
fireCombat:setParameter(COMBAT_PARAM_CASTSOUND, SOUND_EFFECT_TYPE_DIST_ATK_BOW)
fireCombat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

local iceCombat = Combat()
iceCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
iceCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREWORK_BLUE)
iceCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DIAMONDARROW)
iceCombat:setParameter(COMBAT_PARAM_IMPACTSOUND, SOUND_EFFECT_TYPE_DIAMOND_ARROW_EFFECT)
iceCombat:setParameter(COMBAT_PARAM_CASTSOUND, SOUND_EFFECT_TYPE_DIST_ATK_BOW)
iceCombat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)

earthCombat:setCallback(CALLBACK_PARAM_SKILLVALUE, "earthCallback")
earthCombat:setArea(area)

energyCombat:setCallback(CALLBACK_PARAM_SKILLVALUE, "energyCallback")
energyCombat:setArea(area)

fireCombat:setCallback(CALLBACK_PARAM_SKILLVALUE, "fireCallback")
fireCombat:setArea(area)

iceCombat:setCallback(CALLBACK_PARAM_SKILLVALUE, "iceCallback")
iceCombat:setArea(area)

function onUseWeaponEarth(player, variant)
    return earthCombat:execute(player, variant)
end

function onUseWeaponEnergy(player, variant)
    return energyCombat:execute(player, variant)
end

function onUseWeaponFire(player, variant)
    return fireCombat:execute(player, variant)
end

function onUseWeaponIce(player, variant)
    return iceCombat:execute(player, variant)
end

function onUseWeapon(player, variant)
    return combat:execute(player, variant)
end

local arrowIds = {
    {3447, "physical"}, -- arrow
    {774, "earth"}, -- earth arrow
    {763, "fire"}, -- flaming arrow
    {761, "energy"}, -- flash arrow
    {762, "ice"},   -- shiver arrow
    {7364, "physical"}, -- sniper arrow
    {14251, "physical"}, -- tarsal arrow
    {7365, "physical"}, -- onyx arrow
    {16143, "earth"}, -- envenomed arrow
    {15793, "physical"}, -- crystalline arrow
    {35901, "physical"}, -- diamond arrow
}

for i = 1, #arrowIds do
    local arrow = Weapon(WEAPON_AMMO)
    arrow:id(arrowIds[i][1])

    if i > 1 then
        arrow:action("removecount")
    end

    if arrowIds[i][2] == "earth" then
       arrow.onUseWeapon = onUseWeaponEarth
    elseif arrowIds[i][2] == "energy" then
        arrow.onUseWeapon = onUseWeaponEnergy
    elseif arrowIds[i][2] == "fire" then
        arrow.onUseWeapon = onUseWeaponFire
    elseif arrowIds[i][2] == "ice" then
        arrow.onUseWeapon = onUseWeaponIce
    else
       arrow.onUseWeapon = onUseWeapon
    end

    arrow:ammoType("arrow")
    arrow:maxHitChance(100)
    arrow:register()
end
