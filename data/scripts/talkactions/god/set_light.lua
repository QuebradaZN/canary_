--local luz = {240, 218, 1, 6, 7, 36, 215}
--[[
green: 30
blue: 1065 or 809 or 17
red: 1020
purple: 375 or 845 or 667 or 155 or 917

]]

local set_light = TalkAction("/setlight")

function set_light.onSay(player, words, param)
<<<<<<< HEAD:data-otservbr-global/scripts/talkactions/god/set_light.lua
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/set_light.lua
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

=======
>>>>>>> upstream/main:data/scripts/talkactions/god/set_light.lua
	logCommand(player, words, param)

	local split = param:split(",")

	local color = split[1]
	if color == nil then
		player:sendCancelMessage("You need to specify the light color.")
		return false
	end
	local intensity = tonumber(split[2]) or 4--32

	if tonumber(color) and tonumber(color) <= 1500 and intensity >= 0 and intensity < 33 then
		--player:setLight(tonumber(color) >= 0 and luz[tonumber(color)] or 0, intensity)
		player:setLight(tonumber(color) >= 0 and tonumber(color) or 0, intensity)
	else
		player:sendCancelMessage("Use like this: /setlight color (0-" .. 1500 .. "), (1-32). The first param is color and the second is intensity.")
	end

	return false
end

set_light:separator(" ")
<<<<<<< HEAD:data-otservbr-global/scripts/talkactions/god/set_light.lua
set_light:register()
||||||| 83d2da85a:data-otservbr-global/scripts/talkactions/god/set_light.lua
set_light:register()
=======
set_light:groupType("gamemaster")
set_light:register()
>>>>>>> upstream/main:data/scripts/talkactions/god/set_light.lua
