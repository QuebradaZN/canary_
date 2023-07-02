local playerLogin = CreatureEvent("VouchersLogin")

local config = {
	{
		type = 'skills',
		activeItem = 24963,
		inactiveItem = 21217,
		expiredItem = 12209,

		weekday = 4, -- Thursday

		fullDuration = 12 * 60 * 60 * 1000, -- 12 hours
		storage = Storage.Voucher.Skill.Received
	},
	{
		type = 'experience',
		activeItem = 23518,
		inactiveItem = 4061,
		expiredItem = 12210,

		weekday = 5, -- Friday

		fullDuration = 4 * 60 * 60 * 1000, -- 4 hours
		storage = Storage.Voucher.Experience.Received
	},
}

local cooldown = 2 * 60

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

local function findItemInInbox(player, itemId)
	local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)
	local items = inbox:getItems()
	for _, item in pairs(items) do
		if item:getId() == itemId then
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
		local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)
		local items = inbox:getItems()
		for _, inboxItem in pairs(items) do
			if inboxItem:getId() == conf.inactiveItem then
				item = inboxItem
				break
			end
		end
	end

	if not item then
		return false
	end

	item:transform(conf.activeItem, 1)
	player:setStorageValue(Storage.Voucher.LastActivation, os.time())
	item:decay()

	if conf.type == 'experience' then
		player:setBaseXpGain(player:getBaseXpGain() * 2)
	end
	return true
end

local function canReceiveVoucher(player, conf)
	if dayOfTheWeek() ~= conf.weekday then
		return false
	end
	if (os.time() - player:getStorageValue(conf.storage)) < 24 * 60 * 60 then
		return false
	end
	return true
end

local function refreshVouchers(playerId)
	local player = Player(playerId)
	local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)
	player:setStorageValue(Storage.Voucher.LastActivation, 0)
	for _, conf in pairs(config) do
		deactivateVoucher(player, conf)

		local item = findItemInInbox(player, conf.inactiveItem) or findItemInInbox(player, conf.expiredItem)
		if not item then
			item = Game.createItem(conf.inactiveItem)
			item:setDuration(conf.fullDuration)
			item:stopDecay()
			inbox:addItemEx(item, 1, INDEX_WHEREEVER, FLAG_NOLIMIT)
		end

		if canReceiveVoucher(player, conf) then
			item:transform(conf.inactiveItem, 1)
			item:setDuration(conf.fullDuration)
			item:stopDecay()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your " .. item:getName() .. " was recharged.")
			player:setStorageValue(conf.storage, os.time())
		end
	end
end

function playerLogin.onLogin(player)
	addEvent(refreshVouchers, 100, player:getId())
	return true
end

playerLogin:register()

local activate = Action()

function activate.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	for _, conf in pairs(config) do
		if item:getId() == conf.inactiveItem then
			if player:getStorageValue(Storage.Voucher.LastActivation) + cooldown > os.time() then
				local timeLeft = player:getStorageValue(Storage.Voucher.LastActivation) + cooldown - os.time()
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "You must wait " .. durationString(timeLeft) .. " before activating another voucher.")
				return true
			end

			activateVoucher(player, conf, item)
		elseif item:getId() == conf.activeItem then
			deactivateVoucher(player, conf, item)
		end
	end
	return true
end

for _, conf in pairs(config) do
	activate:id(conf.inactiveItem, conf.activeItem)
end
activate:register()

