local commands = TalkAction("!commands")

function commands.onSay(player, words, param)
	if player then
		local text = 'Available commands: \n\n'
		text = text .. '!autoloot on/off \n'
		text = text .. '!bless \n'
		text = text .. '!buyhouse \n'
		text = text .. '!emote on/off \n'
		text = text .. '!leavehouse \n'
		text = text .. '!online \n'
		text = text .. '!sellhouse \n'
		text = text .. '!balance \n'
		text = text .. '!transfer player,amount \n'
		text = text .. '!deposit amount|all \n'
		text = text .. '!withdraw amount \n'
		text = text .. '!serverinfo \n\n'
		player:popupFYI(text)
	end
	return false
end

commands:register()
