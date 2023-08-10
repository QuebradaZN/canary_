local createNpc = TalkAction("/n")

function createNpc.onSay(player, words, param)
<<<<<<< HEAD:data-otservbr-global/scripts/talkactions/god/create_npc.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	-- create log
	logCommand(player, words, param)

||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/create_npc.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

=======
>>>>>>> upstream/main:data/scripts/talkactions/god/create_npc.lua
	if param == "" then
		player:sendCancelMessage("Command param required.")
		return false
	end

	local position = player:getPosition()
	local npc = Game.createNpc(param, position)
	if npc then
		npc:setMasterPos(position)
		position:sendMagicEffect(CONST_ME_MAGIC_RED)
	else
		player:sendCancelMessage("There is not enough room.")
		position:sendMagicEffect(CONST_ME_POFF)
	end
	return false
end

createNpc:separator(" ")
createNpc:groupType("god")
createNpc:register()
