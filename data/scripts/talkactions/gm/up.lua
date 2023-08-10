local up = TalkAction("/up")

function up.onSay(player, words, param)
<<<<<<<< HEAD:data/scripts/talkactions/gm/up.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
	logCommand(player, words, param)

|||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/up.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

========
>>>>>>>> upstream/main:data/scripts/talkactions/god/up.lua
	local position = player:getPosition()
	position.z = position.z - 1
	player:teleportTo(position)
	return false
end

up:separator(" ")
up:groupType("gamemaster")
up:register()
