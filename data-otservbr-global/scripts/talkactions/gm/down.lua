local down = TalkAction("/down")

function down.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
	logCommand(player, words, param)

	local position = player:getPosition()
	position.z = position.z + 1
	player:teleportTo(position)
	return false
end

down:separator(" ")
down:register()
