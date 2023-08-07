local addTutor = TalkAction("/addtutor")
function addTutor.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	-- create log
	logCommand(player, words, param)

	-- Check the first param (player name) exists
	if param == "" then
		player:sendCancelMessage("Player name param required")
		-- Distro log
		Spdlog.error("[addTutor.onSay] - Player name param not found")
		return false
	end

	local split = param:split(",")
	local name = split[1]

	-- Check if player is online
	local targetPlayer = Player(name)
	if not targetPlayer then
		player:sendCancelMessage("Player " .. string.titleCase(name) .. " is not online.")
		-- Distro log
		Spdlog.error("[addTutor.onSay] - Player " .. string.titleCase(name) .. " is not online")
		return false
	end

	if targetPlayer:getAccountType() ~= ACCOUNT_TYPE_NORMAL then
		player:sendCancelMessage("You can only promote a normal player to a tutor.")
		return false
	end

	targetPlayer:setAccountType(ACCOUNT_TYPE_TUTOR)
	targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been promoted to a tutor by " .. player:getName() .. ".")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have promoted " .. targetPlayer:getName() .. " to a tutor.")
	return true
end

addTutor.separator(" ")
addTutor.register()

local removeTutor = TalkAction("/removetutor")
function removeTutor.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	-- create log
	logCommand(player, words, param)

	-- Check the first param (player name) exists
	if param == "" then
		player:sendCancelMessage("Player name param required")
		-- Distro log
		Spdlog.error("[removeTutor.onSay] - Player name param not found")
		return false
	end

	local split = param:split(",")
	local name = split[1]

	-- Check if player is online
	local targetPlayer = Player(name)
	if not targetPlayer then
		player:sendCancelMessage("Player " .. string.titleCase(name) .. " is not online.")
		-- Distro log
		Spdlog.error("[removeTutor.onSay] - Player " .. string.titleCase(name) .. " is not online")
		return false
	end

	if targetPlayer:getAccountType() ~= ACCOUNT_TYPE_TUTOR then
		player:sendCancelMessage("You can only demote a tutor to a normal player")
		return false
	end

	targetPlayer:setAccountType(ACCOUNT_TYPE_NORMAL)
	--targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been demoted to a normal player by " .. player:getName() .. ".")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have demoted " .. targetPlayer:getName() .. " to a normal player.")
	return true
end

removeTutor.separator(" ")
removeTutor.register()
