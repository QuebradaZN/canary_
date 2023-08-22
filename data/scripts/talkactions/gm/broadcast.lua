local broadcast = TalkAction("/b")

function broadcast.onSay(player, words, param)
	if param == "" then
		player:sendCancelMessage("Command param required.")
		return false
	end

	local text = player:getName() .. " broadcasted: " .. param
	logger.info(text)
	Webhook.sendMessage("Broadcast", text, WEBHOOK_COLOR_WARNING, announcementChannels["serverAnnouncements"])
	for _, targetPlayer in ipairs(Game.getPlayers()) do
		targetPlayer:sendPrivateMessage(player, param, TALKTYPE_BROADCAST)
	end
	return false
end

broadcast:separator(" ")
broadcast:groupType("god")
broadcast:register()
