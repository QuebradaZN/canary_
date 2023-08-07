local hasFlag = TalkAction("/hasflag")

function hasFlag.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	-- create log
	logCommand(player, words, param)

	return player:talkactionHasFlag(param)
end

hasFlag:separator(" ")
hasFlag:register()

local setFlag = TalkAction("/setflag")

function setFlag.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	-- create log
	logCommand(player, words, param)

	return player:talkactionSetFlag(param)
end

setFlag:separator(" ")
setFlag:register()

local removeFlag = TalkAction("/removeflag")

function removeFlag.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	-- create log
	logCommand(player, words, param)

	return player:talkactionRemoveFlag(param)
end

removeFlag:separator(" ")
removeFlag:register()
