local getlook = TalkAction("/getlook")

function getlook.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
	logCommand(player, words, param)

	local lookt = Creature(player):getOutfit()
	player:sendTextMessage(MESSAGE_HOTKEY_PRESSED, "<look type=\"" .. lookt.lookType .. "\" head=\"" .. lookt.lookHead .. "\" body=\"" .. lookt.lookBody .. "\" legs=\"" .. lookt.lookLegs .. "\" feet=\"" .. lookt.lookFeet .. "\" addons=\"" .. lookt.lookAddons .. "\" mount=\"" .. lookt.lookMount .. "\" />")
	return true
end

getlook:separator(" ")
getlook:register()
