dofile(CORE_DIRECTORY .. "/modules/scripts/blessings/blessings.lua")

local blessStatus = TalkAction("/bless")

function blessStatus.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
	logCommand(player, words, param)

	Blessings.sendBlessStatus(player)
	return false
end

blessStatus:separator(" ")
blessStatus:register()
