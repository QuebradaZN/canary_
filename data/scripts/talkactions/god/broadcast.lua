local broadcast = TalkAction("/b")

function broadcast.onSay(player, words, param)
<<<<<<<< HEAD:data/scripts/talkactions/gm/broadcast.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
	logCommand(player, words, param)

|||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/broadcast.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

========
>>>>>>>> upstream/main:data/scripts/talkactions/god/broadcast.lua
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
broadcast:groupType("god")
broadcast:register()
