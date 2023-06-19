ExerciseSpeedMultipliers = {
	Training = 1.0,
	Basic = 1.10,
	Enhanced = 1.20,
	Masterful = 1.30
}
ExerciseWeaponsTable = {
	-- MELE
	-- Training
	[28540] = { skill = SKILL_MELEE, effect = CONST_ANI_WHIRLWINDSWORD, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Training },
	[28541] = { skill = SKILL_MELEE, effect = CONST_ANI_WHIRLWINDAXE  , allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Training },
	[28542] = { skill = SKILL_MELEE, effect = CONST_ANI_WHIRLWINDCLUB , allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Training },

	-- Exercise
	[28552] = { skill = SKILL_MELEE, effect = CONST_ANI_WHIRLWINDSWORD, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Basic },
	[28553] = { skill = SKILL_MELEE, effect = CONST_ANI_WHIRLWINDAXE  , allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Basic },
	[28554] = { skill = SKILL_MELEE, effect = CONST_ANI_WHIRLWINDCLUB , allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Basic },

	-- Enhanced
	[35279] = { skill = SKILL_MELEE, effect = CONST_ANI_WHIRLWINDSWORD, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Enhanced },
	[35280] = { skill = SKILL_MELEE, effect = CONST_ANI_WHIRLWINDAXE  , allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Enhanced },
	[35281] = { skill = SKILL_MELEE, effect = CONST_ANI_WHIRLWINDCLUB , allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Enhanced },

	-- Supreme
	[35285] = { skill = SKILL_MELEE, effect = CONST_ANI_WHIRLWINDSWORD, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Masterful },
	[35286] = { skill = SKILL_MELEE, effect = CONST_ANI_WHIRLWINDAXE  , allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Masterful },
	[35287] = { skill = SKILL_MELEE, effect = CONST_ANI_WHIRLWINDCLUB , allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Masterful },

	-- ROD
	[28544] = { skill = SKILL_MAGLEVEL, effect = CONST_ANI_SMALLICE, allowFarUse = true },
	[28556] = { skill = SKILL_MAGLEVEL, effect = CONST_ANI_SMALLICE, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Basic },
	[35283] = { skill = SKILL_MAGLEVEL, effect = CONST_ANI_SMALLICE, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Enhanced },
	[35289] = { skill = SKILL_MAGLEVEL, effect = CONST_ANI_SMALLICE, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Masterful },
	-- RANGE
	[28543] = { skill = SKILL_DISTANCE, effect = CONST_ANI_SIMPLEARROW, allowFarUse = true },
	[28555] = { skill = SKILL_DISTANCE, effect = CONST_ANI_SIMPLEARROW, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Basic },
	[35282] = { skill = SKILL_DISTANCE, effect = CONST_ANI_SIMPLEARROW, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Enhanced },
	[35288] = { skill = SKILL_DISTANCE, effect = CONST_ANI_SIMPLEARROW, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Masterful },
	-- WAND
	[28545] = { skill = SKILL_MAGLEVEL, effect = CONST_ANI_FIRE, allowFarUse = true },
	[28557] = { skill = SKILL_MAGLEVEL, effect = CONST_ANI_FIRE, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Basic },
	[35284] = { skill = SKILL_MAGLEVEL, effect = CONST_ANI_FIRE, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Enhanced },
	[35290] = { skill = SKILL_MAGLEVEL, effect = CONST_ANI_FIRE, allowFarUse = true, speedMultiplier = ExerciseSpeedMultipliers.Masterful }
}

FreeDummies = {28558, 28565}
MaxAllowedOnADummy = configManager.getNumber(configKeys.MAX_ALLOWED_ON_A_DUMMY)
HouseDummies = {28559, 28560, 28561, 28562, 28563, 28564}

local magicLevelRate = configManager.getNumber(configKeys.RATE_MAGIC)
local skillLevelRate = configManager.getNumber(configKeys.RATE_SKILL)

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
		weapon:remove(1) -- ??
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your training weapon has disappeared.")
		LeaveTraining(playerId)
		return false
	end

	local isMagic = ExerciseWeaponsTable[weaponId].skill == SKILL_MAGLEVEL
	local bonusDummy = table.contains(HouseDummies, dummyId) or nil
	local multiplier = 1

	if bonusDummy then bonusDummy = 1.1 else bonusDummy = 1 end
	if not weapon:hasAttribute(ITEM_ATTRIBUTE_CHARGES) then multiplier = 0.2 end

	if isMagic then
		player:addManaSpent(500 * bonusDummy * multiplier)
	else
		player:addSkillTries(ExerciseWeaponsTable[weaponId].skill, 7 * bonusDummy * multiplier)
	end

	if weapon:hasAttribute(ITEM_ATTRIBUTE_CHARGES) then
		weapon:setAttribute(ITEM_ATTRIBUTE_CHARGES, (weaponCharges - 1))
	end

	tilePosition:sendMagicEffect(CONST_ME_HITAREA)

	if ExerciseWeaponsTable[weaponId].effect then
		playerPosition:sendDistanceEffect(tilePosition, ExerciseWeaponsTable[weaponId].effect)
	end

	if weapon:hasAttribute(ITEM_ATTRIBUTE_CHARGES) and weapon:getAttribute(ITEM_ATTRIBUTE_CHARGES) <= 0 then
		weapon:remove(1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your training weapon has disappeared.")
		LeaveTraining(playerId)
		return false
	end

	local vocation = player:getVocation()
	local speed = (vocation:getBaseAttackSpeed() / configManager.getFloat(configKeys.RATE_EXERCISE_TRAINING_SPEED)) / (ExerciseWeaponsTable[weaponId].speedMultiplier or 1)
	onExerciseTraining[playerId].event = addEvent(ExerciseEvent, speed, playerId, tilePosition, weaponId, dummyId)
	return true
end
