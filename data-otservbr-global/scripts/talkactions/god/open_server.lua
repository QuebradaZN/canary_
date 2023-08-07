local openServer = TalkAction("/openserver")

function openServer.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	-- create log
	logCommand(player, words, param)

	Game.setGameState(GAME_STATE_NORMAL)
	player:sendTextMessage(MESSAGE_ADMINISTRADOR, "Server is now open.")
	Webhook.send("Server Open", "Server was opened by: " .. player:getName(),
		WEBHOOK_COLOR_WARNING, announcementChannels["serverAnnouncements"])
	return false
end

openServer:separator(" ")
openServer:register()
