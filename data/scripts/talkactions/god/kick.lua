local kick = TalkAction("/kick")

function kick.onSay(player, words, param)
<<<<<<<< HEAD:data/scripts/talkactions/gm/kick.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
	logCommand(player, words, param)

|||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/kick.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

========
>>>>>>>> upstream/main:data/scripts/talkactions/god/kick.lua
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
kick:groupType("gamemaster")
kick:register()
