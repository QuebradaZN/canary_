local teleportToWaypoint = TalkAction("/w")

function teleportToWaypoint.onSay(player, words, param)
	Spdlog.info("teleportToWaypoint.onSay: param = " .. param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	if param == "" then
		player:sendCancelMessage("Command param required.")
		return false
	end


	if not player:gotoWaypoint(param, true) then
		player:sendCancelMessage("Waypoint '" .. param .. "' not found.")
	end
	return false
end

teleportToWaypoint:separator(" ")
teleportToWaypoint:groupType("god")
teleportToWaypoint:register()
