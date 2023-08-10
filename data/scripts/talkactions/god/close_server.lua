local closeServer = TalkAction("/closeserver")

function closeServer.onSay(player, words, param)
<<<<<<< HEAD:data-otservbr-global/scripts/talkactions/god/close_server.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	-- create log
	logCommand(player, words, param)

||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/close_server.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

=======
>>>>>>> upstream/main:data/scripts/talkactions/god/close_server.lua
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
closeServer:groupType("god")
closeServer:register()
