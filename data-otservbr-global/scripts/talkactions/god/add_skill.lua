local function getSkillId(skillName)
	if skillName == "melee" then
		return SKILL_MELEE
	elseif skillName == "club" then
		return SKILL_MELEE
	elseif skillName == "sword" then
		return SKILL_MELEE
	elseif skillName == "axe" then
		return SKILL_MELEE
	elseif skillName:sub(1, 4) == "dist" then
		return SKILL_DISTANCE
	elseif skillName:sub(1, 3) == "def" then
		return SKILL_DEFENSE
	elseif skillName:sub(1, 4) == "toni" then
		return SKILL_TONICITY
	elseif skillName:sub(1, 4) == "runi" then
		return SKILL_RUNIC
	else
		return SKILL_LUCK
	end
end

local function getExpForLevel(level)
	level = level - 1
	return ((50 * level * level * level) - (150 * level * level) + (400 * level)) / 3
end


local addSkill = TalkAction("/addskill")

function addSkill.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	if param == "" then
		player:sendCancelMessage("Command param required.")
		return false
	end

	local split = param:split(",")
	if not split[2] then
		player:sendCancelMessage("Insufficient parameters.")
		return false
	end

	local target = Player(split[1])
	if not target then
		player:sendCancelMessage("A player with that name is not online.")
		return false
	end

	-- Trim left
	split[2] = split[2]:gsub("^%s*(.-)$", "%1")

	local count = 1
	if split[3] then
		count = tonumber(split[3])
	end

	local ch = split[2]:sub(1, 1)
	if ch == "l" or ch == "e" then
		targetLevel = target:getLevel() + count
		targetExp = getExpForLevel(targetLevel)
		addExp = targetExp - target:getExperience()
		target:addExperience(addExp, false)
	elseif split[2] == "magic" then
		for i = 1, count do
			target:addManaSpent(target:getVocation():getRequiredManaSpent(target:getBaseMagicLevel() + 1) - target:getManaSpent(), true)
		end
	else
		local skillId = getSkillId(split[2])
		for i = 1, count do
			target:addSkillTries(skillId, target:getVocation():getRequiredSkillTries(skillId, target:getSkillLevel(skillId) + 1) - target:getSkillTries(skillId), true)
		end
	end
	return false
end

addSkill:separator(" ")
addSkill:register()
