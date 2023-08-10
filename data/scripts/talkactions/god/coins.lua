local tibiaCoins = TalkAction("/coins")

function tibiaCoins.onSay(player, words, param)
    local usage = "/coins PLAYER NAME, TYPE,COIN AMOUNT"
    if param == "" then
        player:sendCancelMessage("Command param required. Usage: ".. usage)
        return false
    end

    local split = param:split(",")
    if not split[3] then
        player:sendCancelMessage("Insufficient parameters. Usage: ".. usage)
        return false
    end

    local target = Player(split[1])
    if not target then
        player:sendCancelMessage("A player with that name is not online.")
        return false
    end
    --trim left
    local type = split[2]:gsub("^%s*(.-)$", "%1")
    local amount = split[3]:gsub("^%s*(.-)$", "%1")

		if type == "online" then
			player:sendCancelMessage("Added " .. amount .. " online points to the character '" .. target:getName() .. "'.")
			target:sendCancelMessage("Received " .. amount .. " online points!")
			target:addTibiaCoins(tonumber(amount))
		elseif type == "elysiera" then
			player:sendCancelMessage("Added " .. amount .. " elysiera coins to the character '" .. target:getName() .. "'.")
			target:sendCancelMessage("Received " .. amount .. " elysiera coins!")
			target:addTransferableCoins(tonumber(amount))
		end
end

tibiaCoins:separator(" ")
tibiaCoins:groupType("god")
tibiaCoins:register()
