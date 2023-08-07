local storageGet = TalkAction("/getstorage")

function storageGet.onSay(cid, words, param)
	local player = Player(cid)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	-- create log
	logCommand(player, words, param)

	local split = param:split(",")
	if split[2] == nil then
		player:sendCancelMessage("Insufficient parameters.")
		return false
	end

	local target = Player(split[1])
	if target == nil then
		player:sendCancelMessage("A player with that name is not online.")
		return false
	end

	-- Trim left
	split[2] = split[2]:gsub("^%s*(.-)$", "%1")

	local ch = split[2]
	sto = getPlayerStorageValue(getPlayerByName(split[1]), tonumber(ch))
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "The storage with id: " .. tonumber(ch) .. " from player " .. split[1] .. " is: " .. sto .. ".")
	return false
end

storageGet:separator(" ")
storageGet:register()
