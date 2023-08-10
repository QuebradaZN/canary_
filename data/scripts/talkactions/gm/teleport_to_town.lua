local teleportToTown = TalkAction("/town")

function teleportToTown.onSay(player, words, param)
<<<<<<<< HEAD:data/scripts/talkactions/gm/teleport_to_town.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
	logCommand(player, words, param)

|||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/teleport_to_town.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

========
>>>>>>>> upstream/main:data/scripts/talkactions/god/teleport_to_town.lua
	if param == "" then
		player:sendCancelMessage("Command param required.")
		return false
	end

	local town = Town(param) or Town(tonumber(param))
	if town then
		player:teleportTo(town:getTemplePosition())
	else
		player:sendCancelMessage("Town not found.")
	end
	return false
end

teleportToTown:separator(" ")
teleportToTown:groupType("gamemaster")
teleportToTown:register()
