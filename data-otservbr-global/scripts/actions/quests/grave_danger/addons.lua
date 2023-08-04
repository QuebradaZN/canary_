local config = {
	[31738] = {
		{female = 1244, male = 1243}
	},
	[31737] = {
		{female = 1244, male = 1243}
	},
}

local dreamerDocuments = Action()
function dreamerDocuments.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local useItem = config[item.itemid]
	if not useItem then
		return true
	end

	local choice = useItem[1]
	if player:getStorageValue(Storage.OutfitQuest.BrotherhoodOutfit) > player:getStorageValue(Storage.OutfitQuest.NightmareOutfit) then
		choice = useItem[2]
	end

	if choice.addon then
		if player:hasOutfit(player:getSex() == PLAYERSEX_FEMALE and choice.female or choice.male) then
			if not player:hasOutfit(player:getSex() == PLAYERSEX_FEMALE and choice.female or choice.male, choice.addon) then
				if player:getStorageValue(Storage.OutfitQuest.NightmareOutfit) >= useItem.storageValue or player:getStorageValue(Storage.OutfitQuest.BrotherhoodOutfit) >= useItem.storageValue then
					player:addOutfitAddon(choice.female, choice.addon)
					player:addOutfitAddon(choice.male, choice.addon)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have received the ' .. choice.msg .. ' addon!')
					player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
					item:remove(1)
				else
					return false
				end
			else
				player:sendCancelMessage('You have already obtained this addon!')
			end
		else
			return false
		end
	else
		if not player:hasOutfit(player:getSex() == PLAYERSEX_FEMALE and choice.female or choice.male) then
			if player:getStorageValue(Storage.OutfitQuest.NightmareOutfit) >= 1 or player:getStorageValue(Storage.OutfitQuest.BrotherhoodOutfit) >= 1 then
				player:addOutfit(choice.female)
				player:addOutfit(choice.male)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have received the ' .. choice.msg .. ' outfit!')
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				item:remove(1)
			else
				return false
			end
		else
			player:sendCancelMessage('You have already obtained this outfit!')
		end
	end
	return true
end

dreamerDocuments:id(768,769,770)
dreamerDocuments:register()
