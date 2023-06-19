local table = {
	-- [level] = type = "item", id = {ITEM_ID, QUANTITY}, msg = "MESSAGE"},
	-- [level] = type = "bank", id = {QUANTITY, 0}, msg = "MESSAGE"},
	-- [level] = type = "addon", id = {ID_ADDON_FEMALE, ID_ADDON_MALE}, msg = "MESSAGE"},
	-- [level] = type = "mount", id = {ID_MOUNT, 0}, msg = "MESSAGE"},

	[50] = {type = "bank", id = {20000, 0}, msg = "You received 20,000 gold for reaching level 50."},
	[100] = {type = "bank", id = {50000, 0}, msg = "You received 50,000 gold for reaching level 100."},
	[150] = {type = "bank", id = {100000, 0}, msg = "You received 100,000 gold for reaching level 150."},
	[200] = {type = "bank", id = {200000, 0}, msg = "You received 100,000 gold for reaching level 200."},
}

local storage = 15000

local levelReward = CreatureEvent("Level Reward")
function levelReward.onAdvance(player, skill, oldLevel, newLevel)
	if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
		return true
	end

	if newLevel >= 20 and player.getStorageValue(STORAGEVALUE_PROMOTION) ~= 1 then
		if player:getVocation():getPromotion() ~= nil then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations on reaching level 20. You have been automatically promoted to " .. player:getVocation():getPromotion():getName() .. ".")
			player:setVocation(player:getVocation():getPromotion())
			player:setStorageValue(STORAGEVALUE_PROMOTION, 1)
			player:getPosition():sendMagicEffect(CONST_ME_HOLYDAMAGE)
		end
	end

	for level, _ in pairs(table) do
		if newLevel >= level and player:getStorageValue(storage) < level then
			if table[level].type == "item" then
				player:addItem(table[level].id[1], table[level].id[2])
			elseif table[level].type == "bank" then
				player:setBankBalance(player:getBankBalance() + table[level].id[1])
			elseif table[level].type == "addon" then
				player:addOutfitAddon(table[level].id[1], 3)
				player:addOutfitAddon(table[level].id[2], 3)
			elseif table[level].type == "mount" then
				player:addMount(table[level].id[1])
			else
				return false
			end

			if table[level].msg then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, table[level].msg)
			end
			player:setStorageValue(storage, level)
		end
	end

	player:save()

	return true
end

levelReward:register()
