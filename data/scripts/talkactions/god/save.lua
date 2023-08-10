local savingEvent = 0
function saveLoop(delay)
	saveServer()
	SaveHirelings()
	Spdlog.info("Saved Hirelings")
	if delay > 0 then
		savingEvent = addEvent(saveLoop, delay, delay)
	end
end

local save = TalkAction("/save")

function save.onSay(player, words, param)
<<<<<<< HEAD:data-otservbr-global/scripts/talkactions/god/save.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	-- create log
	logCommand(player, words, param)

	if isNumber(param) then
		stopEvent(savingEvent)
		saveLoop(tonumber(param) * 60 * 1000)
	else
		saveServer()
		SaveHirelings()
		Spdlog.info("Saved Hirelings")
		player:sendTextMessage(MESSAGE_ADMINISTRADOR, "Server is saved ...")
||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/save.lua
	if player:getGroup():getAccess() then
		if isNumber(param) then
			stopEvent(savingEvent)
			saveLoop(tonumber(param) * 60 * 1000)
		else
			saveServer()
			SaveHirelings()
			Spdlog.info("Saved Hirelings")
			player:sendTextMessage(MESSAGE_ADMINISTRADOR, "Server is saved ...")
		end
=======
	if isNumber(param) then
		stopEvent(savingEvent)
		saveLoop(tonumber(param) * 60 * 1000)
	else
		saveServer()
		SaveHirelings()
		Spdlog.info("Saved Hirelings")
		player:sendTextMessage(MESSAGE_ADMINISTRADOR, "Server is saved ...")
>>>>>>> upstream/main:data/scripts/talkactions/god/save.lua
	end
end

save:separator(" ")
save:groupType("god")
save:register()
