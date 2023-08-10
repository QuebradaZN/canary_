local function getSkillId(skillName)
	if skillName == "melee" then
		return SKILL_MELEE
	elseif skillName:sub(1, 4) == "dist" then
		return SKILL_DISTANCE
	elseif skillName:sub(1, 3) == "def" then
		return SKILL_DEFENSE
	elseif skillName:sub(1, 4) == "toni" then
		return SKILL_TONICITY
	elseif skillName:sub(1, 4) == "runi" then
		return SKILL_RUNIC
	elseif skillName:sub(1, 4) == "luck" then
		return SKILL_LUCK
	elseif skillName:sub(1, 3) == "dex" then
		return SKILL_DEXTERITY
	else
		return nil
	end
end

local function getExpForLevel(level)
	level = level - 1
	return ((50 * level * level * level) - (150 * level * level) + (400 * level)) / 3
end


local setSkill = TalkAction("/setskill")

function setSkill.onSay(player, words, param)
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
	local skill = split[2]:gsub("^%s*(.-)$", "%1")

	local level = split[3]
	if not level then
		player:sendCancelMessage("Insufficient parameters.")
		return false
	end

	if skill == "level" then
		target:setLevel(level)
	elseif skill == "magic" then
		target:setMagicLevel(level)
	else
		local skillId = getSkillId(skill)
		if not skillId then
			player:sendCancelMessage("Invalid skill name.")
			return false
		end
		target:setSkillLevel(skillId, level)
	end
	return false
end

setSkill:separator(" ")
setSkill:groupType("god")
setSkill:register()
