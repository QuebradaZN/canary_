local createSummon = TalkAction("/s")
function createSummon.onSay(player, words, param)
<<<<<<< HEAD:data-otservbr-global/scripts/talkactions/god/create_summon.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end
	local monsterTypes = Game.getMonsterTypes()
	for _, mType in pairs(monsterTypes) do
		db.query("INSERT IGNORE INTO `monsters` (`name`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `lookaddons`, `lookmount`, `looktypeex`, `raceid`) VALUES (" .. db.escapeString(mType:getName()) .. ", " .. mType:outfit().lookBody .. ", " .. mType:outfit().lookFeet .. ", " .. mType:outfit().lookHead .. ", " .. mType:outfit().lookLegs .. ", " .. mType:outfit().lookType .. ", " .. mType:outfit().lookAddons .. ", " .. mType:outfit().lookMount .. ", " .. mType:outfit().lookTypeEx .. ", " .. mType:raceId() .. ")")
	end

	-- create log
	logCommand(player, words, param)

||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/create_summon.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

=======
>>>>>>> upstream/main:data/scripts/talkactions/god/create_summon.lua
	if param == "" then
		player:sendCancelMessage("Command param required.")
		return false
	end

	local position = player:getPosition()
	local summon = Game.createMonster(param, position, true, false, player)
	if not summon then
		player:sendCancelMessage(RETURNVALUE_NOTENOUGHROOM)
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if summon:getOutfit().lookType == 0 then
		summon:setOutfit({ lookType = player:getFamiliarLooktype() })
	end
	position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	summon:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return false
end

createSummon:separator(" ")
createSummon:groupType("god")
createSummon:register()
