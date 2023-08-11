local playerLogin = CreatureEvent("VouchersLogin")

local config = {
	{
		type = 'skills',
		activeItem = 24963,
		inactiveItem = 21217,
		inactiveItemName = 'inactive skill voucher',
		activeItemName = 'active skill voucher',
		deprecatedExpiredItem = 12209,

		weekday = 4, -- Thursday

		fullDuration = 12 * 60 * 60 * 1000, -- 12 hours
		storage = "voucher.skill.received",
	},
	{
		type = 'experience',
		activeItem = 25774,
		inactiveItem = 4061,
		inactiveItemName = 'inactive experience voucher',
		activeItemName = 'active experience voucher',
		deprecatedExpiredItem = 12210,

		weekday = 5, -- Friday

		fullDuration = 4 * 60 * 60 * 1000, -- 4 hours
		storage = "voucher.experience.received",
	},
	{
		type = 'skills',
		activeItem = 24963,
		inactiveItem = 21217,
		inactiveItemName = 'inactive compensatory skill voucher',
		activeItemName = 'active compensatory skill voucher',
		deprecatedExpiredItem = 12209,

		compensatory = true,
		compensationDate = 20230812,

		fullDuration = 12 * 60 * 60 * 1000, -- 12 hours
		storage = "voucher.compensatory.20230812.received",
	},
}

local cooldown = 2 * 60

local function getCurrentDateForCompensation()
	return tonumber(os.date("%Y%m%d", os.time()))
end

-- API
function Player.activeVoucher(self, type)
	local inbox = self:getSlotItem(CONST_SLOT_STORE_INBOX)
	local items = inbox:getItems()
	for _, item in pairs(items) do
		for _, conf in pairs(config) do
			if type and conf.type ~= type then
				goto continue
			end

			if item:getId() == conf.activeItem then
				return { item = item, conf = conf }
			end

			::continue::
		end
	end
	return nil
end

local function findItemInInbox(player, itemId, name)
	local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)
	local items = inbox:getItems()
	for _, item in pairs(items) do
		if item:getId() == itemId and (not name or item:getName() == name) then
			return item
		end
	end
	return nil
end

local function dayOfTheWeek()
	local time = os.time()
	local day = os.date("%w", time)
	return tonumber(day)
end

local function deactivateVoucher(player, conf, item)
	if not item then
		local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)
		local items = inbox:getItems()
		for _, inboxItem in pairs(items) do
			if inboxItem:getId() == conf.activeItem then
				item = inboxItem
				break
			end
		end
	end

	if not item then
		return false
	end

	item:transform(conf.inactiveItem, 1)
	item:setName(conf.inactiveItemName)
	item:stopDecay()
	if conf.type == 'experience' then
		player:setBaseXpGain(100)
	end
	return false
end

local function activateVoucher(player, conf, item)
	if player:activeVoucher() then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "You already have an active voucher.")
		return false
	end
	if not item then
		item = findItemInInbox(player, conf.inactiveItem, conf.inactiveItemName)
	end
	if not item then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Could not activate your voucher, please try again.")
		return false
	end
	local name = item:getName()
	if name ~= conf.inactiveItemName then
		return false
	end
	item:transform(conf.activeItem, 1)
	item:setName(conf.activeItemName)
	player:setStorageValueByName("voucher.lastActivation", os.time())
	player:sendTextMessage(MESSAGE_STATUS_SMALL, "Your " .. conf.type .. " voucher has been activated.")
	item:decay()

	if conf.type == 'experience' then
		player:setBaseXpGain(player:getBaseXpGain() * 2)
	end
	return true
end

local function canReceiveVoucher(player, conf)
	local currentDate = getCurrentDateForCompensation()
	if conf.compensatory and currentDate >= conf.compensationDate and currentDate <= conf.compensationDate + 2 then
		Spdlog.info("Compensatory voucher for player " .. player:getName() .. " on date " .. currentDate .. ". storage value: " .. player:getStorageValueByName(conf.storage))
		return player:getStorageValueByName(conf.storage) < 1
	end
	if (os.time() - player:getStorageValueByName(conf.storage)) > 7 * 24 * 60 * 60 then
		return true
	end
	if not conf.weekday or dayOfTheWeek() ~= conf.weekday then
		return false
	end
	if (os.time() - player:getStorageValueByName(conf.storage)) < 24 * 60 * 60 then
		return false
	end
	return true
end

local function refreshVouchers(player)
	local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)
	player:setStorageValueByName("voucher.lastActivation", 0)
	for _, conf in pairs(config) do
		deactivateVoucher(player, conf)
		local deprecatedExpiredItem = findItemInInbox(player, conf.deprecatedExpiredItem)
		if deprecatedExpiredItem then
			deprecatedExpiredItem:remove()
		end

		local item = findItemInInbox(player, conf.inactiveItem, conf.inactiveItemName)
		if canReceiveVoucher(player, conf) then
			if not item then
				item = Game.createItem(conf.inactiveItem)
				item:setDurationAttr(conf.fullDuration)
				item:stopDecay()
				inbox:addItemEx(item, INDEX_WHEREEVER, FLAG_NOLIMIT)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your received a brand-new " .. item:getName() .. " that will last for " .. getTimeInWords(conf.fullDuration / 1000) .. ".")
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your " .. item:getName() .. " has been refreshd to " .. getTimeInWords(conf.fullDuration / 1000) .. ".")
			end

			item:transform(conf.inactiveItem, 1)
			item:setName(conf.inactiveItemName)
			item:setDurationAttr(conf.fullDuration)
			item:stopDecay()
			player:setStorageValueByName(conf.storage, os.time())
		end
	end
end

function playerLogin.onLogin(player)
	addPlayerEvent(refreshVouchers, 100, player:getId())
	return true
end

playerLogin:register()

local activate = Action()

function activate.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	for _, conf in pairs(config) do
		if item:getId() == conf.inactiveItem and item:getName() == conf.inactiveItemName then
			local lastActivation = player:getStorageValueByName("voucher.lastActivation")
			Spdlog.info("Last activation: " .. lastActivation)
			if lastActivation and lastActivation > 0 and (lastActivation + cooldown) > os.time() then
				local timeLeft = lastActivation + cooldown - os.time()
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "You must wait " .. getTimeInWords(timeLeft) .. " before activating another voucher.")
				return true
			end

			addPlayerEvent(activateVoucher, 100, player:getId(), conf)
		elseif item:getId() == conf.activeItem then
			addPlayerEvent(deactivateVoucher, 100, player:getId(), conf)
		end
	end
	return true
end

local ids = {}
for _, conf in pairs(config) do
	ids[conf.inactiveItem] = true
	ids[conf.activeItem] = true
end
for id, _ in pairs(ids) do
	activate:id(id)
end
activate:register()

