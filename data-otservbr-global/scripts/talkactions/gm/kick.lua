local kick = TalkAction("/kick")

function kick.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
	logCommand(player, words, param)

	local target = Player(param)
	if not target then
		player:sendCancelMessage("Player not found.")
		return false
	end

	if target:getGroup():getAccess() then
		player:sendCancelMessage("You cannot kick this player.")
		return false
	end

	Webhook.send("Player Kicked", target:getName() .. " has been kicked by " .. player:getName(),
		WEBHOOK_COLOR_WARNING, announcementChannels["serverAnnouncements"])
	target:remove()
	return false
end

kick:separator(" ")
kick:register()