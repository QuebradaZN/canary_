local adventurersGuildText = [[
Brave adventurer,

the Adventurers' Guild bids you welcome as a new hero of the land.

Take this adventurer's stone and use it in any city temple to instantly travel to our guild hall. If you should ever lose your adventurer's stone, you can replace it by talking to a priest in the temple.
I hope you will be visiting us soon.

Kind regards,
Rotem, Head of the Adventurers' Guild
]]

local reward = {
	container = 2854,
	commonItems = {
		{ id = 16277, amount = 1 }, -- Adventurer's stone
		{ id = 3725, amount = 100 }, -- Brown Mushrooms
	},
	vocationItems = {
		-- Sorcerer
		[14025] = {
			{ id = 7992, amount = 1 }, -- Mage Hat
			{ id = 7991, amount = 1 }, -- Magician's Robe
			{ id = 24404, amount = 1 }, -- Tatty dragon scale legs
			{ id = 8072, amount = 1 }, -- Spellbook of enlightenment
			{ id = 3074, amount = 1 }, -- Wand of vortex
			{ id = 3552, amount = 1 }, -- Leather boots
			{ id = 3572, amount = 1 }, -- Scarf
		},
		-- Druid
		[14026] = {
			{ id = 7992, amount = 1 }, -- Mage Hat
			{ id = 7991, amount = 1 }, -- Magician's Robe
			{ id = 9014, amount = 1 }, -- Leaf legs
			{ id = 3066, amount = 1 }, -- Snakebite Rod
			{ id = 8072, amount = 1 }, -- Spellbook of enlightenment
			{ id = 3552, amount = 1 }, -- Leather boots
			{ id = 3572, amount = 1 }, -- Scarf
		},
		-- Paladin
		[14027] = {
			{ id = 3351, amount = 1 }, -- Steel Helmet
			{ id = 3571, amount = 1 }, -- Ranger's cloak
			{ id = 8095, amount = 1 }, -- Ranger legs
			{ id = 7438, amount = 1 }, -- Elvish Bow
			{ id = 3277, amount = 1 }, -- Spear
			{ id = 35562, amount = 1 }, -- Quiver
			{ id = 3447, amount = 1 }, -- Arrows
			{ id = 3349, amount = 1 }, -- Crossbow
			{ id = 3446, amount = 1 }, -- Bolt
			{ id = 3428, amount = 1 }, -- Dwarven shield
			{ id = 3552, amount = 1 }, -- Leather boots
			{ id = 3572, amount = 1 }, -- Scarf
		},
		-- Knight
		[14028] = {
			{ id = 7461, amount = 1 }, -- Krimhorn helmet
			{ id = 3357, amount = 1 }, -- Plate armor
			{ id = 3557, amount = 1 }, -- Plate legs
			{ id = 3552, amount = 1 }, -- Leather boots
			{ id = 7408, amount = 1 }, -- Wyvern fang
			{ id = 3428, amount = 1 }, -- Dwarven Shield
			{ id = 3572, amount = 1 }, -- Scarf
		}
	}
}

local vocationReward = Action()

function vocationReward.onUse(player, item, fromPosition, itemEx, toPosition)
	local vocationItems = reward.vocationItems[item.uid]
	-- Check there is items for item.uid
	if not vocationItems then
		return true
	end
	-- Check quest storage
	if player:getStorageValue(Storage.Quest.U10_55.Dawnport.VocationReward) == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The " .. item:getName() .. " is empty.")
		return true
	end
	-- Calculate reward weight
	local rewardsWeight = ItemType(reward.container):getWeight()
	for i = 1, #vocationItems do
		rewardsWeight = rewardsWeight + (ItemType(vocationItems[i].id):getWeight() * vocationItems[i].amount)
	end
	for i = 1, #reward.commonItems do
		rewardsWeight = rewardsWeight + (ItemType(reward.commonItems[i].id):getWeight() * reward.commonItems[i].amount)
	end
	-- Check if enough weight capacity
	if player:getFreeCapacity() < rewardsWeight then
		player:sendTextMessage(
			MESSAGE_EVENT_ADVANCE,
			"You have found a " .. getItemName(reward.container) ..
			". Weighing " .. (rewardsWeight / 100) .. " oz it is too heavy."
		)
		return true
	end
	-- Check if enough free slots
	if player:getFreeBackpackSlots() < 1 then
		player:sendTextMessage(
			MESSAGE_EVENT_ADVANCE,
			"You have found a " .. getItemName(reward.container) .. ". There is no room."
		)
		return true
	end
	-- Create reward container
	local container = Game.createItem(reward.container)
	-- Iterate in inverse order due on addItem/addItemEx by default its added at first index
	-- Add common items
	for i = #reward.commonItems, 1, -1 do
		if reward.commonItems[i].text then
			-- Create item to customize
			local document = Game.createItem(reward.commonItems[i].id)
			document:setAttribute(ITEM_ATTRIBUTE_TEXT, reward.commonItems[i].text)
			container:addItemEx(document)
		else
			container:addItem(reward.commonItems[i].id, reward.commonItems[i].amount)
		end
	end
	-- Add vocation items
	for i = #vocationItems, 1, -1 do
		container:addItem(vocationItems[i].id, vocationItems[i].amount)
	end
	-- Ensure reward was added properly to player
	if player:addItemEx(container, false, CONST_SLOT_WHEREEVER) == RETURNVALUE_NOERROR then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a " .. container:getName() .. ".")
		player:setStorageValue(Storage.Quest.U10_55.Dawnport.VocationReward, 1)
	end
	return true
end

for index, value in pairs(reward.vocationItems) do
	vocationReward:uid(index)
end

vocationReward:register()
