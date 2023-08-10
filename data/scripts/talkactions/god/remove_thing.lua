local removeThing = TalkAction("/r")

function removeThing.onSay(player, words, param)
<<<<<<< HEAD:data-otservbr-global/scripts/talkactions/god/remove_thing.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
	logCommand(player, words, param)

||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/remove_thing.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

=======
>>>>>>> upstream/main:data/scripts/talkactions/god/remove_thing.lua
	local position = player:getPosition()
	position:getNextPosition(player:getDirection())

	local tile = Tile(position)
	if not tile then
		player:sendCancelMessage("Object not found.")
		return false
	end

	local thing = tile:getTopVisibleThing(player)
	if not thing then
		player:sendCancelMessage("Thing not found.")
		return false
	end

	if thing:isCreature() then
		thing:remove()
	elseif thing:isItem() then
		if thing == tile:getGround() then
			player:sendCancelMessage("You may not remove a ground tile.")
			return false
		end
		thing:remove(tonumber(param) or -1)
	end

	position:sendMagicEffect(CONST_ME_MAGIC_RED)
	return false
end

removeThing:separator(" ")
removeThing:groupType("gamemaster")
removeThing:register()
