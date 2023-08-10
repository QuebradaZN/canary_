local houseOwner = TalkAction("/owner")

function houseOwner.onSay(player, words, param)
<<<<<<< HEAD:data-otservbr-global/scripts/talkactions/god/house_owner.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	-- create log
	logCommand(player, words, param)

||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/house_owner.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

=======
>>>>>>> upstream/main:data/scripts/talkactions/god/house_owner.lua
	local tile = Tile(player:getPosition())
	local house = tile and tile:getHouse()
	if not house then
		player:sendCancelMessage("You are not inside a house.")
		return false
	end

	if param == "" or param == "none" then
		house:setOwnerGuid(0)
		return false
	end

	local targetPlayer = Player(param)
	if not targetPlayer then
		player:sendCancelMessage("Player not found.")
		return false
	end

	house:setOwnerGuid(targetPlayer:getGuid())
	return false
end

houseOwner:separator(" ")
houseOwner:groupType("gamemaster")
houseOwner:register()
