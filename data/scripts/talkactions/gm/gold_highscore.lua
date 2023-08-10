local gold_rank = TalkAction("/goldrank")

function gold_rank.onSay(player, words, param)
<<<<<<<< HEAD:data/scripts/talkactions/gm/gold_highscore.lua

	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
|||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/gold_highscore.lua

	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

========
>>>>>>>> upstream/main:data/scripts/talkactions/god/gold_highscore.lua
	logCommand(player, words, param)

	local resultId = db.storeQuery("SELECT `balance`, `name` FROM `players` WHERE group_id < 3 ORDER BY balance DESC LIMIT 10")
	if resultId ~= false then
		local str = ""
		local x = 0
		repeat
			x = x + 1
			str = str .. "\n" .. x .. "- " .. Result.getString(resultId, "name") .. " (" .. Result.getNumber(resultId, "balance") .. ")."
		until not Result.next(resultId)
		Result.free(resultId)
		if str == "" then
			str = "No highscore to show."
		end
		player:popupFYI("Current gold highscore for this server:\n" .. str)
	else
		player:sendCancelMessage("No highscore to show.")
	end
	return false
end

gold_rank:separator(" ")
gold_rank:groupType("gamemaster")
gold_rank:register()
