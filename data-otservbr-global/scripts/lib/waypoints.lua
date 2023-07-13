Waypoints = {}

local waypoints = {
	-- { name="Brain Head", position = Position(31973, 32325, 10) },
	{ name="Asura Palace", position = Position(32949, 32692, 7) },
	{ name="Black Vixen", position = Position(33442, 32052, 9), bundle = "Werecreatures mini-bosses" },
	{ name="Bloodback", position = Position(33167, 31978, 8), bundle = "Werecreatures mini-bosses" },
	{ name="Count Vlarkorth", position = Position(33456, 31408, 13) },
	{ name="Custodian", position = Position(33378, 32825, 8), bundle = "Scarlett Etzel" },
	{ name="Darkfang", position = Position(33055, 31911, 9), bundle = "Werecreatures mini-bosses" },
	{ name="Dragonking Zyrtarch", position = Position(33391, 31183, 10), bundle = "Forgotten Knowledge" },
	{ name="Dread Maiden", position = Position(33744, 31506, 14), storage = Storage.Quest.U12_30.FeasterOfSouls.DreadMaidenKilled },
	{ name="Drume", position = Position(32458, 32507, 6) },
	{ name="Duke Krule", position = Position(33456, 31497, 13) },
	{ name="Earl Osam", position = Position(33517, 31440, 13) },
	{ name="Faceless Bane", position = Position(33618, 32522, 15) },
	{ name="Fear Feaster", position = Position(33739, 31471, 14), storage = Storage.Quest.U12_30.FeasterOfSouls.FearFeasterKilled },
	{ name="Frozen Horror", position = Position(32302, 31093, 14), bundle = "Forgotten Knowledge" },
	{ name="Gaffir", position = Position(33393, 32674, 4), bundle = "Scarlett Etzel" },
	{ name="Goshnar Cruelty", position = Position(33859, 31854, 6), storage = Storage.Quest.U12_40.SoulWar.GoshnarCrueltyKilled },
	{ name="Goshnar Greed", position = Position(33781, 31665, 14), storage = Storage.Quest.U12_40.SoulWar.GoshnarGreedKilled },
	{ name="Goshnar Hatred", position = Position(33778, 31601, 14), storage = Storage.Quest.U12_40.SoulWar.GoshnarHatredKilled },
	{ name="Goshnar Malice", position = Position(33684, 31599, 14), storage = Storage.Quest.U12_40.SoulWar.GoshnarMaliceKilled },
	{ name="Goshnar Megalomania", position = Position(33681, 31634, 14), storage = Storage.Quest.U12_40.SoulWar.GoshnarMegalomaniaKilled },
	{ name="Goshnar Spite", position = Position(33779, 31634, 14), storage = Storage.Quest.U12_40.SoulWar.GoshnarSpiteKilled },
	{ name="Guard Captain Quaid", position = Position(33397, 32658, 3), bundle = "Scarlett Etzel" },
	{ name="Ingol Boat", position = Position(33710, 32602, 6), bundle = "Ingol" },
	{ name="Ingol Deep", position = Position(33798, 32573, 8), bundle = "Ingol" },
	{ name="Irgix the Flimsy", position = Position(33492, 31400, 8), bundle = "Feaster of Souls mini-bossses" },
	{ name="King Zelos", position = Position(33489, 31546, 13) },
	{ name="Lady Tenebris", position = Position(32902, 31628, 14), bundle = "Forgotten Knowledge" },
	{ name="Last Lore Keeper", position = Position(32019, 32849, 14), bundle = "Forgotten Knowledge" },
	{ name="Lion Sanctum", position = Position(33123, 32236, 12) },
	{ name="Lloyd", position = Position(32759, 32873, 14), bundle = "Forgotten Knowledge" },
	{ name="Lord Azaram", position = Position(33423, 31497, 13) },
	{ name="Magma Bubble", position = Position(33669, 32931, 15), storage = Storage.Quest.U12_90.PrimalOrdeal.Bosses.MagmaBubbleKilled },
	{ name="Nightmare Beast / Dream Courts", position = Position(32208, 32094, 13), storage = Storage.Quest.U12_00.TheDreamCourts.NightmareBeastKilled },
	{ name="Pale Worm", position = Position(33776, 31504, 14), storage = Storage.Quest.U12_30.FeasterOfSouls.PaleWormKilled },
	{ name="Ratmiral Blackwhiskers", position = Position(33894, 31391, 15) },
	{ name="Scarlett Etzel", position = Position(33395, 32662, 6), bundle = "Scarlett Etzel" },
	{ name="Shadowpelt", position = Position(33403, 32097, 9), bundle = "Werecreatures mini-bosses" },
	{ name="Sharpclaw", position = Position(33128, 31972, 9), bundle = "Werecreatures mini-bosses" },
	{ name="Sir Baeloc-Nictros", position = Position(33426, 31408, 13) },
	{ name="Soul Hub", position = Position(33621, 31427, 10) },
	{ name="Summer Courts", position = Position(33672, 32229, 7), bundle = "Elven Courts" },
	{ name="The Primal Menace", position = Position(33553, 32752, 14), storage = Storage.Quest.U12_90.PrimalOrdeal.Bosses.ThePrimalMenaceKilled },
	{ name="Thorn Knight", position = Position(32657, 32882, 14), bundle = "Forgotten Knowledge" },
	{ name="Time Guardian", position = Position(33010, 31665, 14), bundle = "Forgotten Knowledge" },
	{ name="Timira", position = Position(33804, 32702, 8) },
	{ name="Unaz the Mean", position = Position(33566, 31477, 8), bundle = "Feaster of Souls mini-bossses" },
	{ name="Unwelcome", position = Position(33741, 31537, 14), storage = Storage.Quest.U12_30.FeasterOfSouls.UnwelcomeKilled },
	{ name="Urmahlullu", position = Position(33920, 31623, 8) },
	{ name="Vok the Freakish", position = Position(33509, 31452, 9), bundle = "Feaster of Souls mini-bossses" },
	{ name="Winter Courts", position = Position(32354, 31249, 3), bundle = "Elven Courts" },
}

local maxBit = 32

function Waypoints.getByName(name)
	for i, waypoint in ipairs(waypoints) do
		if waypoint.name:lower() == name:lower() then
			return {id = i, waypoint = waypoint}
		end
	end
	return nil
end

function Player:addWaypointById(id)
	local zid = tonumber(id) - 1
	local storageBucket = Storage.Waypoints.Owned.From + math.floor(zid / maxBit)
	if storageBucket > Storage.Waypoints.Owned.To then
		Spdlog.error("Player:addWaypointById: storageBucket > Storage.Waypoints.Owned.To")
		return false
	end
	local newValue = bit.bor(self:getUpdatedAccountStorage(storageBucket), bit.lshift(1, zid % maxBit))
	self:setStorageValue(storageBucket, newValue)
	return true
end

function Player:addWaypoint(name)
	local w = Waypoints.getByName(name)
	if not w then
		return false
	end
	return self:addWaypointById(w.id)
end

function Player:hasWaypointById(id)
	local zid = tonumber(id) - 1
	local storageBucket = Storage.Waypoints.Owned.From + math.floor(zid / maxBit)
	if storageBucket > Storage.Waypoints.Owned.To then
		Spdlog.error("Player:addWaypointById: storageBucket > Storage.Waypoints.Owned.To")
		return false
	end
	local storageValue = self:getUpdatedAccountStorage(storageBucket)
	local desiredValue = bit.lshift(1, zid % maxBit)
	return bit.band(storageValue, desiredValue) == desiredValue
end

function Player:hasWaypoint(name)
	local w = Waypoints.getByName(name)
	if not w then
		return false
	end
	return self:hasWaypointById(w.id)
end

function Player:getWaypoints()
	local ownedWaypoints = {}
	for id, waypoint in ipairs(waypoints) do
		if self:hasWaypointById(id) then
			table.insert(ownedWaypoints, waypoint)
		end
	end
	return ownedWaypoints
end

function Player:addWaypointModal(onAdd)
	local window = ModalWindow {
		title =	 "Activate a waypoint",
		message = "Select a waypoint to activate.\n\nNote: some waypionts only appear here after you kill the boss",
	}
	local bundles = {}
	for id, waypoint in ipairs(waypoints) do
		if not self:hasWaypointById(id) then
			local choiceName = waypoint.name
			if waypoint.bundle then
				choiceName = waypoint.bundle .. " (bundle)"
				local hadBundle = bundles[waypoint.bundle]
				bundles[waypoint.bundle] = bundles[waypoint.bundle] or {}
				table.insert(bundles[waypoint.bundle], id)
				if hadBundle then goto continue end
			end

			if waypoint.storage then
				if self:getStorageValue(waypoint.storage) < 1 then
					goto continue
				end
			end

			window:addChoice(choiceName, function(player, button)
				if button.name ~= "Select" then
					return true
				end

				if waypoint.bundle then
					for _, idFromBundle in ipairs(bundles[waypoint.bundle]) do
						if self:addWaypointById(idFromBundle) then
							self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have activated the " .. waypoints[idFromBundle].name .. " waypoint.")
						else
							self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already have the " .. waypoints[idFromBundle].name .. " waypoint activated.")
						end
					end
					onAdd()
				else
					if self:addWaypointById(id) then
						self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have activated the " .. waypoint.name .. " waypoint.")
						onAdd()
					else
						self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already have the " .. waypoint.name .. " waypoint activated.")
					end
				end
			end)
		end
		::continue::
	end
	window:addButton("Select")
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(self)
end

function Player:gotoWaypoint(name, force)
	local w = Waypoints.getByName(name)
	if not w then
		return false
	end
	if not force and not self:hasWaypointById(w.id) then
		return false
	end

	local info = w.waypoint
	self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You were teleported to " .. info.name)
	self:teleportTo(info.position)
	self:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
end
