local broadcast = TalkAction("/b")

function broadcast.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
	logCommand(player, words, param)

	if param == "" then
		player:sendCancelMessage("Command param required.")
		return false
	end

	local text = player:getName() .. " broadcasted: " .. param
	Spdlog.info(text)
	Webhook.send("Broadcast", text, WEBHOOK_COLOR_WARNING, announcementChannels["serverAnnouncements"])
	for _, targetPlayer in ipairs(Game.getPlayers()) do
		targetPlayer:sendPrivateMessage(player, param, TALKTYPE_BROADCAST)
	end
	return false
end

broadcast:separator(" ")
broadcast:register()
