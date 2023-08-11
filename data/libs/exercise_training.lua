ExerciseSpeedMultipliers = {
	Training = 1.0,
	Basic = 1.00,
	Enhanced = 1.20,
	Masterful = 1.30
}
ExerciseWeaponsTable = {
	-- MELE
	-- Training
	[28540] = { skill = SKILL_MELEE, effect = CONST_ME_WHITE_ENERGY_SPARK, shootEffect = CONST_ANI_THROWINGKNIFE, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Training },
	[28541] = { skill = SKILL_MELEE, effect = CONST_ME_WHITE_ENERGY_SPARK, shootEffect = CONST_ANI_THROWINGKNIFE, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Training },
	[28542] = { skill = SKILL_MELEE, effect = CONST_ME_WHITE_ENERGY_SPARK, shootEffect = CONST_ANI_THROWINGKNIFE, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Training },

	-- Exercise
	[28552] = { skill = SKILL_MELEE, effect = CONST_ME_BLUE_ENERGY_SPARK, shootEffect = CONST_ANI_WHIRLWINDSWORD, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Basic },
	[28553] = { skill = SKILL_MELEE, effect = CONST_ME_GREEN_ENERGY_SPARK, shootEffect = CONST_ANI_WHIRLWINDAXE, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Basic },
	[28554] = { skill = SKILL_MELEE, effect = CONST_ME_PINK_ENERGY_SPARK, shootEffect = CONST_ANI_WHIRLWINDCLUB, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Basic },

	-- Enhanced
	[35279] = { skill = SKILL_MELEE, effect = CONST_ME_BLUE_ENERGY_SPARK, shootEffect = CONST_ANI_WHIRLWINDSWORD, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Enhanced },
	[35280] = { skill = SKILL_MELEE, effect = CONST_ME_GREEN_ENERGY_SPARK, shootEffect = CONST_ANI_WHIRLWINDAXE, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Enhanced },
	[35281] = { skill = SKILL_MELEE, effect = CONST_ME_PINK_ENERGY_SPARK, shootEffect = CONST_ANI_WHIRLWINDCLUB, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Enhanced },

	-- Supreme
	[35285] = { skill = SKILL_MELEE, effect = CONST_ME_BLUE_ENERGY_SPARK, shootEffect = CONST_ANI_WHIRLWINDSWORD, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Masterful },
	[35286] = { skill = SKILL_MELEE, effect = CONST_ME_GREEN_ENERGY_SPARK, shootEffect = CONST_ANI_WHIRLWINDAXE, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Masterful },
	[35287] = { skill = SKILL_MELEE, effect = CONST_ME_PINK_ENERGY_SPARK, shootEffect = CONST_ANI_WHIRLWINDCLUB, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Masterful },

	-- ROD
	[28544] = { skill = SKILL_MAGLEVEL, effect = CONST_ME_WHITE_ENERGY_SPARK, shootEffect = CONST_ANI_SMALLEARTH, allowFarUse = true },
	[28556] = { skill = SKILL_MAGLEVEL, effect = CONST_ME_BLUE_ENERGY_SPARK, shootEffect = CONST_ANI_SMALLICE, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Basic },
	[35283] = { skill = SKILL_MAGLEVEL, effect = CONST_ME_GREEN_ENERGY_SPARK, shootEffect = CONST_ANI_EARTH, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Enhanced },
	[35289] = { skill = SKILL_MAGLEVEL, effect = CONST_ME_PINK_ENERGY_SPARK, shootEffect = CONST_ANI_ENERGY, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Masterful },
	-- RANGE
	[28543] = { skill = SKILL_DISTANCE, effect = CONST_ME_WHITE_ENERGY_SPARK, shootEffect = CONST_ANI_SMALLSTONE, allowFarUse = true },
	[28555] = { skill = SKILL_DISTANCE, effect = CONST_ME_BLUE_ENERGY_SPARK, shootEffect = CONST_ANI_FLASHARROW, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Basic },
	[35282] = { skill = SKILL_DISTANCE, effect = CONST_ME_GREEN_ENERGY_SPARK, shootEffect = CONST_ANI_EARTHARROW, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Enhanced },
	[35288] = { skill = SKILL_DISTANCE, effect = CONST_ME_PINK_ENERGY_SPARK, shootEffect = CONST_ANI_SNIPERARROW, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Masterful },
	-- WAND
	[28545] = { skill = SKILL_MAGLEVEL, effect = CONST_ME_WHITE_ENERGY_SPARK, shootEffect = CONST_ANI_SMALLEARTH, allowFarUse = true },
	[28557] = { skill = SKILL_MAGLEVEL, effect = CONST_ME_BLUE_ENERGY_SPARK, shootEffect = CONST_ANI_SMALLICE, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Basic },
	[35284] = { skill = SKILL_MAGLEVEL, effect = CONST_ME_GREEN_ENERGY_SPARK, shootEffect = CONST_ANI_EARTH, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Enhanced },
	[35290] = { skill = SKILL_MAGLEVEL, effect = CONST_ME_PINK_ENERGY_SPARK, shootEffect = CONST_ANI_ENERGY, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Masterful }
}

local dummies = Game.getDummies()

function LeaveTraining(playerId)
	if onExerciseTraining[playerId] then
		stopEvent(onExerciseTraining[playerId].event)
		onExerciseTraining[playerId] = nil
	end

	local player = Player(playerId)
	if player then
		player:setTraining(false)
	end
	return
end

function ExerciseEvent(playerId, tilePosition, weaponId, dummyId)
	local player = Player(playerId)
	if not player then
		return LeaveTraining(playerId)
	end

	if player:isTraining() == 0 then
		return LeaveTraining(playerId)
	end

	if not Tile(tilePosition):getItemById(dummyId) then
		player:sendTextMessage(MESSAGE_FAILURE, "Someone has moved the dummy, the training has stopped.")
		LeaveTraining(playerId)
		return false
	end

	local playerPosition = player:getPosition()
	if not playerPosition:isProtectionZoneTile() then
		player:sendTextMessage(MESSAGE_FAILURE, "You are no longer in a protection zone, the training has stopped.")
		LeaveTraining(playerId)
		return false
	end

	if player:getItemCount(weaponId) <= 0 then
		player:sendTextMessage(MESSAGE_FAILURE, "You need the training weapon in the backpack, the training has stopped.")
		LeaveTraining(playerId)
		return false
	end

	local weapon = player:getItemById(weaponId, true)
	if not weapon:isItem() then
		player:sendTextMessage(MESSAGE_FAILURE, "The selected item is not a training weapon, the training has stopped.")
		LeaveTraining(playerId)
		return false
	end

	local weaponCharges = weapon:getAttribute(ITEM_ATTRIBUTE_CHARGES)
	if weapon:hasAttribute(ITEM_ATTRIBUTE_CHARGES) and weaponCharges <= 0 then
		weapon:remove(1)
		local weapon = player:getItemById(weaponId, true)
		if not weapon or (not weapon:isItem() or not weapon:hasAttribute(ITEM_ATTRIBUTE_CHARGES)) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your training weapon has disappeared.")
			LeaveTraining(playerId)
			return false
		end
	end

	local isMagic = ExerciseWeaponsTable[weaponId].skill == SKILL_MAGLEVEL
	local rate = dummies[dummyId] / 100
	local multiplier = 1
	if not weapon:hasAttribute(ITEM_ATTRIBUTE_CHARGES) then multiplier = 0.2 end

	if isMagic then
		player:addManaSpent(math.ceil(500 * rate * multiplier))
	else
		player:addSkillTries(ExerciseWeaponsTable[weaponId].skill, 7 * rate * multiplier)
	end
	player:addSkillTries(SKILL_DEFENSE, math.ceil(6 * rate * multiplier))
	player:addSkillTries(SKILL_DEXTERITY, math.ceil(3 * rate * multiplier))

	if weapon:hasAttribute(ITEM_ATTRIBUTE_CHARGES) then
		weapon:setAttribute(ITEM_ATTRIBUTE_CHARGES, (weaponCharges - 1))
	end

	tilePosition:sendMagicEffect(CONST_ME_HITAREA)

	if ExerciseWeaponsTable[weaponId].shootEffect then
		playerPosition:sendDistanceEffect(tilePosition, ExerciseWeaponsTable[weaponId].shootEffect)
	end
	if ExerciseWeaponsTable[weaponId].effect then
		playerPosition:sendMagicEffect(ExerciseWeaponsTable[weaponId].effect)
	end

	if weapon:hasAttribute(ITEM_ATTRIBUTE_CHARGES) and weapon:getAttribute(ITEM_ATTRIBUTE_CHARGES) <= 0 then
		weapon:remove(1)
		local weapon = player:getItemById(weaponId, true)
		if not weapon or (not weapon:isItem() or not weapon:hasAttribute(ITEM_ATTRIBUTE_CHARGES)) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your training weapon has disappeared.")
			LeaveTraining(playerId)
			return false
		end
	end

	local vocation = player:getVocation()
	local speed = (vocation:getBaseAttackSpeed() / configManager.getFloat(configKeys.RATE_EXERCISE_TRAINING_SPEED)) / (ExerciseWeaponsTable[weaponId].speedMultiplier or 1)
	onExerciseTraining[playerId].event = addEvent(ExerciseEvent, speed, playerId, tilePosition, weaponId, dummyId)
	return true
end
