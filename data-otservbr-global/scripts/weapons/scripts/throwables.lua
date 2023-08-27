local throwables = {
	{
		-- royal star
		itemid = 25759,
		level = 120,
		unproperly = true,
		breakchance = 30,
	},
	{
		-- leaf star
		itemid = 25735,
		level = 60,
		unproperly = true,
		breakchance = 40,
	},
	{
		-- glooth spear
		itemid = 21158,
		level = 60,
		unproperly = true,
		breakchance = 2,
	},
	{
		-- mean paladin spear
		itemid = 17110,
		breakchance = 3,
		vocation = {
			{ "None", true }
		},
	},
	{
		-- royal spear
		itemid = 7378,
		level = 25,
		unproperly = true,
		breakchance = 3,
	},
	{
		-- assassin star
		itemid = 7368,
		level = 80,
		unproperly = true,
		breakchance = 33,
	},
	{
		-- enchanted spear
		itemid = 7367,
		level = 42,
		unproperly = true,
		breakchance = 1,
	},
	{
		-- hunting spear
		itemid = 3347,
		level = 20,
		unproperly = true,
		breakchance = 6,
	},
	{
		-- throwing knife
		itemid = 3298,
		breakchance = 7,
	},
	{
		-- throwing star
		itemid = 3287,
		breakchance = 10,
	},
	{
		-- spear
		itemid = 3277,
		-- breakchance = 3,
	},
	{
		-- snowball
		itemid = 2992,
		breakchance = 20,
	},
	{
		-- small stone
		itemid = 1781,
		breakchance = 3,
	}
}

local combat = Combat()

combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_IMPACTSOUND, SOUND_EFFECT_TYPE_DIAMOND_ARROW_EFFECT)
combat:setParameter(COMBAT_PARAM_CASTSOUND, SOUND_EFFECT_TYPE_DIST_ATK_THROW)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 0.8, 0)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)

function getChainValue(creature)
	return 5, 3, true
end

combat:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValue")

for i = 1, #throwables do
	local w = throwables[i]
	local weapon = Weapon(WEAPON_MISSILE)
	weapon:id(w.itemid or w.itemId)

	if w.breakchance or w.breakChance then
		weapon:breakChance(w.breakchance or w.breakChance)
	end
	if w.level then
		weapon:level(w.level)
	end
	if w.mana then
		weapon:mana(w.mana)
	end
	if w.unproperly then
		weapon:wieldUnproperly(w.unproperly)
	end
	if w.vocation then
		for _, v in ipairs(w.vocation) do
			weapon:vocation(v[1], v[2] or false, v[3] or false)
		end
	end

	weapon.onUseWeapon = function(player, variant)
		local target = Creature(variant:getNumber())
		if not target then
			return false
		end

		return combat:execute(player, variant)
	end
	w.onUseWeapon = onUseWeapon

	weapon:register()
end
