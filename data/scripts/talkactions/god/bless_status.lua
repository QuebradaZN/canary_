dofile(CORE_DIRECTORY .. "/modules/scripts/blessings/blessings.lua")

local blessStatus = TalkAction("/bless")

function blessStatus.onSay(player, words, param)
<<<<<<<< HEAD:data/scripts/talkactions/gm/bless_status.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
	logCommand(player, words, param)

|||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/bless_status.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

========
>>>>>>>> upstream/main:data/scripts/talkactions/god/bless_status.lua
	Blessings.sendBlessStatus(player)
	return false
end

blessStatus:separator(" ")
blessStatus:groupType("god")
blessStatus:register()
