local closeServer = TalkAction("/closeserver")

function closeServer.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	-- create log
	logCommand(player, words, param)

	if param == "shutdown" then
		Game.setGameState(GAME_STATE_SHUTDOWN)
		Webhook.send("Server Shutdown", "Server was shutdown by: " .. player:getName(),
			WEBHOOK_COLOR_WARNING, announcementChannels["serverAnnouncements"])
	else
		Game.setGameState(GAME_STATE_CLOSED)
		player:sendTextMessage(MESSAGE_ADMINISTRADOR, "Server is now closed.")
		Webhook.send("Server Closed", "Server was closed by: " .. player:getName(),
			WEBHOOK_COLOR_WARNING, announcementChannels["serverAnnouncements"])
	end
	return false
end

closeServer:separator(" ")
closeServer:register()
