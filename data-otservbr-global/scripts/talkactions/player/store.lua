local storeCommand = TalkAction("!store")

function storeCommand.onSay(player, words, param)
	return player:openStore("home")
end

storeCommand:register()
