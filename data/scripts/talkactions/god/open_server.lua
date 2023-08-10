local openServer = TalkAction("/openserver")

function openServer.onSay(player, words, param)
<<<<<<< HEAD:data-otservbr-global/scripts/talkactions/god/open_server.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	-- create log
	logCommand(player, words, param)

||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/open_server.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

=======
>>>>>>> upstream/main:data/scripts/talkactions/god/open_server.lua
	Game.setGameState(GAME_STATE_NORMAL)
	player:sendTextMessage(MESSAGE_ADMINISTRADOR, "Server is now open.")
	Webhook.send("Server Open", "Server was opened by: " .. player:getName(),
		WEBHOOK_COLOR_WARNING, announcementChannels["serverAnnouncements"])
	return false
end

openServer:separator(" ")
openServer:groupType("god")
openServer:register()
