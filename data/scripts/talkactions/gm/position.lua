local position = TalkAction("/pos", "!pos")

function position.onSay(player, words, param)
<<<<<<<< HEAD:data/scripts/talkactions/gm/position.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
	logCommand(player, words, param)

|||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/position.lua

	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

========
>>>>>>>> upstream/main:data/scripts/talkactions/god/position.lua
	local param = string.gsub(param, "%s+", "")
	local position = player:getPosition()
	local tile = load("return " .. param)()
	local split = param:split(",")
	if type(tile) == "table" and tile.x and tile.y and tile.z then
		player:teleportTo(Position(tile.x, tile.y, tile.z))
	elseif split and param ~= "" then
		player:teleportTo(Position(split[1], split[2], split[3]))
	elseif param == "" then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your current position is: \z
		" .. position.x .. ", " .. position.y .. ", " .. position.z .. ".")
	end
	return false
end

position:separator(" ")
position:groupType("gamemaster")
position:register()
