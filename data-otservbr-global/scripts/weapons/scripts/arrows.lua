local area = createCombatArea({
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 3, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
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
	{ id = 3447, element = "physical" }, -- arrow
	{ id = 774, element = "earth", level = 20 }, -- earth arrow
	{ id = 763, element = "fire", level = 20 }, -- flaming arrow
	{ id = 761, element = "energy", level = 20 }, -- flash arrow
	{ id = 762, element = "ice", level = 20 }, -- shiver arrow
	{ id = 7364, element = "physical", level = 20 }, -- sniper arrow
	{ id = 14251, element = "physical", level = 30 }, -- tarsal arrow
	{ id = 7365, element = "physical", level = 40 }, -- onyx arrow
	{ id = 16143, element = "earth", level = 70 }, -- envenomed arrow
	{ id = 15793, element = "physical", level = 90 }, -- crystalline arrow
	{ id = 35901, element = "physical", level = 150 }, -- diamond arrow
}

for i = 1, #arrowIds do
	local arrow = Weapon(WEAPON_AMMO)
	arrow:id(arrowIds[i].id)

	if i > 1 then
		arrow:action("removecount")
	end

	if arrowIds[i].element == "earth" then
		arrow.onUseWeapon = onUseWeaponEarth
	elseif arrowIds[i].element == "energy" then
		arrow.onUseWeapon = onUseWeaponEnergy
	elseif arrowIds[i].element == "fire" then
		arrow.onUseWeapon = onUseWeaponFire
	elseif arrowIds[i].element == "ice" then
		arrow.onUseWeapon = onUseWeaponIce
	else
		arrow.onUseWeapon = onUseWeapon
	end

	arrow:ammoType("arrow")
	arrow:maxHitChance(100)
	if arrowIds[i].level then
		arrow:level(arrowIds[i].level)
	end
	arrow:register()
end
