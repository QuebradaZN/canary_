local addWaypoint = TalkAction("/addwaypoint")

function addWaypoint.onSay(player, words, param)
    local usage = "/addwaypoint PLAYER NAME, WAYPOINT NAME"
    if param == "" then
        player:sendCancelMessage("Command param required. Usage: ".. usage)
        return false
    end

    local split = param:split(",")
    if not split[2] then
        player:sendCancelMessage("Insufficient parameters. Usage: ".. usage)
        return false
    end

    local target = Player(split[1]:trimSpace())
    if not target then
        player:sendCancelMessage("A player with that name is not online.")
        return false
    end
    local waypoint = split[2]:trimSpace()

		if player:hasWaypoint(waypoint) then
			player:sendCancelMessage("The " .. waypoint .. " waypoint already exists for the character '" .. player:getName() .. "'.")
			return false
		end

		if target:addWaypoint(waypoint) then
			player:sendCancelMessage("Added the " .. waypoint .. " waypoint the character '" .. target:getName() .. "'.")
			target:sendCancelMessage("Received the " .. waypoint .. "!")
		else
			player:sendCancelMessage("The waypoint " .. waypoint .. " does not exist.")
		end
		return false
end

addWaypoint:separator(" ")
addWaypoint:groupType("god")
addWaypoint:register()
