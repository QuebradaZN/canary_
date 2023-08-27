function teleportPlayer(player, info)
	local inPz = player:getTile():hasFlag(TILESTATE_PROTECTIONZONE)
	local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)
	if not inPz and inFight then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't use this when you're in a fight.")
		return true
	end

	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You were teleported to " .. info.name)
	player:teleportTo(info.position)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ACTION_PORTAL_CAST, player:isInGhostMode() and nil or player)
end

local teleportCube = Action()

function townsModal(player)
	local towns = {}

	for i, town in ipairs(Game.getTowns()) do
		if table.contains(STARTER_TOWNS, town:getId()) then
			goto continue
		end
		local name = town:getName()

		if name == "Island of Destiny" or name == "Cobra Bastion" or name == "Bounac" then
			goto continue
		end

		table.insert(towns, {
			name = name,
			position = town:getTemplePosition(),
		})
		::continue::
	end
	local extraTowns = {
		{
			name = "Cormaya",
			position = Position(33302, 31969, 7),
		},
		{
			name = "Fibula",
			position = Position(32177, 32437, 7),
		}
	}
	for i, info in pairs(extraTowns) do
		table.insert(towns, info)
	end
	table.sort(towns, function(a, b) return a.name < b.name end)

	local window = ModalWindow {
		title = "Teleport Cube",
		message = "Towns"
	}
	for i, info in pairs(towns) do
		window:addChoice(string.format("%s", info.name), function(player, button, choice)
			if button.name ~= "Select" then
				return true
			end
			teleportPlayer(player, info)
			return true
		end)
	end
	window:addButton("Select")
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

function housesModal(player)
	local window = ModalWindow {
		title = "Teleport Cube",
		message = "Houses"
	}
	local houses = {}
	local houseCount = 0
	local myHouse = player:getHouse()
	if myHouse then
		table.insert(houses, {
			name = myHouse:getName() .. " (My House)",
			position = myHouse:getExitPosition(),
		})
		houseCount = houseCount + 1
	end

	for i, house in ipairs(Game.getHouses()) do
		local name = house:getName()
		if house:getOwnerGuid() == player:getGuid() then
			goto continue
		end

		if house:canEditAccessList(GUEST_LIST, player) then
			table.insert(houses, {
				name = name,
				position = house:getExitPosition(),
			})
			houseCount = houseCount + 1
		end

		if houseCount == 128 then
			break
		end
		::continue::
	end

	for i, info in pairs(houses) do
		window:addChoice(string.format("%s", info.name), function(player, button, choice)
			if button.name ~= "Select" then
				return true
			end
			teleportPlayer(player, info)
			return true
		end)
	end
	window:addButton("Select")
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

function teleportCube.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:getItemById(item:getId()) and not player:findItemInInbox(item:getId()) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must have the Teleport Cube in your backpack.")
		return true
	end
	local inPz = player:getTile():hasFlag(TILESTATE_PROTECTIONZONE)
	local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)
	if not inPz and inFight then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't use this when you're in a fight.")
		return true
	end

	player:getPosition():sendMagicEffect(CONST_ME_TUTORIALSQUARE)

	local window = ModalWindow {
		title = "Teleport Cube",
		message = "Choose an option"
	}

	window:addChoice("Towns", function(player, button, choice)
		if button.name ~= "Select" then
			return true
		end
		townsModal(player)
		return true
	end)
	window:addChoice("Houses", function(player, button, choice)
		if button.name ~= "Select" then
			return true
		end
		housesModal(player)
		return true
	end)
	window:addChoice("Adventurer's Guild", function(player, button, choice)
		if button.name ~= "Select" then
			return true
		end
		teleportPlayer(player, {
			name = "Adventurer's Guild",
			position = { x = 32210, y = 32300, z = 6 },
		})
		return true
	end)

	window:addButton("Select")
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
	return true
end

teleportCube:id(31633)
teleportCube:register()
