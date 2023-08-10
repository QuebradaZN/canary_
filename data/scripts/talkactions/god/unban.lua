local unban = TalkAction("/unban")

function unban.onSay(player, words, param)
<<<<<<<< HEAD:data/scripts/talkactions/gm/unban.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
	logCommand(player, words, param)

|||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/unban.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

========
>>>>>>>> upstream/main:data/scripts/talkactions/god/unban.lua
	if param == "" then
		player:sendCancelMessage("Command param required.")
		return false
	end

	local resultId = db.storeQuery("SELECT `account_id`, `lastip` FROM `players` WHERE `name` = " .. db.escapeString(param))
	if resultId == false then
		return false
	end

	db.asyncQuery("DELETE FROM `account_bans` WHERE `account_id` = " .. Result.getNumber(resultId, "account_id"))
	db.asyncQuery("DELETE FROM `ip_bans` WHERE `ip` = " .. Result.getNumber(resultId, "lastip"))
	Result.free(resultId)
	local text = param .. " has been unbanned."
	player:sendTextMessage(MESSAGE_ADMINISTRADOR, text)
	Webhook.send("Player Unbanned", text .. " (by: " .. player:getName() .. ")",
		WEBHOOK_COLOR_WARNING, announcementChannels["serverAnnouncements"])
	return false
end

unban:separator(" ")
unban:groupType("gamemaster")
unban:register()
