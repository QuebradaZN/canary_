local talk = TalkAction("/hireling")

function talk.onSay(player, words, param)

<<<<<<<< HEAD:data/scripts/talkactions/god/create_hirelinglamp.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	-- create log
	logCommand(player, words, param)

|||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/create hirelinglamp.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

========
>>>>>>>> upstream/main:data/scripts/talkactions/god/create hirelinglamp.lua
	local split = param:split(",")
	local name = split[1] ~= "" and split[1] or "Hireling " .. player:getName()
	local sex = split[2] and tonumber(split[2]) or 1

	local result = player:addNewHireling(name, sex)
	if result then
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
	return false
end

talk:separator(" ")
talk:groupType("god")
talk:register()
