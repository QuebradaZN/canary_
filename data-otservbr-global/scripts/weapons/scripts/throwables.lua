local throwables = {
	{
		-- royal star
		itemid = 25759,
		level = 120,
		unproperly = true,
		breakchance = 30,
		animation = CONST_ANI_ROYALSTAR,
	},
	{
		-- leaf star
		itemid = 25735,
		level = 60,
		unproperly = true,
		breakchance = 40,
		animation = CONST_ANI_LEAFSTAR,
	},
	{
		-- glooth spear
		itemid = 21158,
		level = 60,
		unproperly = true,
		breakchance = 2,
		animation = CONST_ANI_GLOOTHSPEAR,
	},
	{
		-- mean paladin spear
		itemid = 17110,
		breakchance = 3,
		vocation = {
			{"None", true}
		},
		animation = CONST_ANI_SPEAR,
	},
	{
		-- royal spear
		itemid = 7378,
		level = 25,
		unproperly = true,
		breakchance = 3,
		animation = CONST_ANI_ROYALSPEAR,
	},
	{
		-- assassin star
		itemid = 7368,
		level = 80,
		unproperly = true,
		breakchance = 33,
		animation = CONST_ANI_REDSTAR,
	},
	{
		-- enchanted spear
		itemid = 7367,
		level = 42,
		unproperly = true,
		breakchance = 1,
		animation = CONST_ANI_ENCHANTEDSPEAR,
	},
	{
		-- hunting spear
		itemid = 3347,
		level = 20,
		unproperly = true,
		breakchance = 6,
		animation = CONST_ANI_HUNTINGSPEAR,
	},
	{
		-- throwing knife
		itemid = 3298,
		breakchance = 7,
		animation = CONST_ANI_THROWINGKNIFE,
	},
	{
		-- throwing star
		itemid = 3287,
		breakchance = 10,
		animation = CONST_ANI_THROWINGSTAR,
	},
	{
		-- spear
		itemid = 3277,
		-- breakchance = 3,
		animation = CONST_ANI_SPEAR,
	},
	{
		-- snowball
		itemid = 2992,
		breakchance = 20,
		animation = CONST_ANI_SNOWBALL,
	},
	{
		-- small stone
		itemid = 1781,
		breakchance = 3,
		animation = CONST_ANI_SMALLSTONE,
	}
}

local combat = Combat()

combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_IMPACTSOUND, SOUND_EFFECT_TYPE_DIAMOND_ARROW_EFFECT)
combat:setParameter(COMBAT_PARAM_CASTSOUND, SOUND_EFFECT_TYPE_DIST_ATK_BOW)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 0.8, 0)

for i = 1, #throwables do
	local w = throwables[i]
	local weapon = Weapon(WEAPON_MISSILE)
	weapon:id(w.itemid or w.itemId)

	if(w.breakchance or w.breakChance) then
		weapon:breakChance(w.breakchance or w.breakChance)
	end
	if(w.level) then
		weapon:level(w.level)
	end
	if(w.mana) then
		weapon:mana(w.mana)
	end
	if(w.unproperly) then
		weapon:wieldUnproperly(w.unproperly)
	end
	if(w.vocation) then
		for _, v in ipairs(w.vocation) do
			weapon:vocation(v[1], v[2] or false, v[3] or false)
		end
	end

	weapon.onUseWeapon = function(player, variant)
		local target = Creature(variant:getNumber())
		if not target then
			return false
		end

		return Chain.combat(player, target, combat, 5, 2, w.animation, w.animation)
	end
	w.onUseWeapon = onUseWeapon

	weapon:register()
end

