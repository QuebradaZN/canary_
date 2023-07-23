Waypoints = {}

-- { name="Brain Head", position = Position(31973, 32325, 10) },
-- DO NOT CHANGE WAYPOINT IDS, THEY ARE USED IN PLAYER STORAGE
local waypoints = {
	-- Bosses
	{
		id = 0,
		name = "Werecreatures mini-bosses",
		bundle = true,
		waypoints = {
			{ name = "Black Vixen", position = Position(33442, 32052, 9) },
			{ name = "Bloodback",   position = Position(33167, 31978, 8) },
			{ name = "Darkfang",    position = Position(33055, 31911, 9) },
			{ name = "Shadowpelt",  position = Position(33403, 32097, 9) },
			{ name = "Sharpclaw",   position = Position(33128, 31972, 9) },
		}
	},

	-- Grave Danger
	{
		id = 1,
		name = "King Zelos & mini-bosses",
		bundle = true,
		requirements = { bosstiary = { name = "King Zelos", stars = 1 } },
		waypoints = {
			{ name = "King Zelos",      position = Position(33489, 31546, 13) },
			{ name = "Count Vlarkorth", position = Position(33456, 31408, 13), },
			{ name = "Duke Krule",      position = Position(33456, 31497, 13), },
			{ name = "Earl Osam",       position = Position(33517, 31440, 13), },
			{ name = "Lord Azaram",     position = Position(33423, 31497, 13), },
			{ name = "Sir Baeloc",      position = Position(33426, 31408, 13), },
		}
	},
	{
		id = 2,
		name = "Scarlett Etzel",
		bundle = true,
		requirements = { bosstiary = { stars = 1 } },
		waypoints = {
			{ name = "Gaffir",              position = Position(33393, 32674, 4) },
			{ name = "Guard Captain Quaid", position = Position(33397, 32658, 3) },
			{ name = "Custodian",           position = Position(33378, 32825, 8) },
			{ name = "Scarlett Etzel",      position = Position(33395, 32662, 6) },
		}
	},

	-- Feaster Of Souls
	{
		id = 3,
		name = "Fear Feaster",
		position = Position(33739, 31471, 14),
		requirements = { bosstiary = { name = "The Fear Feaster", kills = 1 } }
	},
	{
		id = 4,
		name = "Pale Worm",
		position = Position(33776, 31504, 14),
		requirements = { bosstiary = { name = "The Pale Worm", kills = 1 } }
	},
	{
		id = 5,
		name = "Unwelcome",
		position = Position(33741, 31537, 14),
		requirements = { bosstiary = { name = "The Unwelcome", kills = 1 } }
	},
	{
		id = 6,
		name = "Dread Maiden",
		position = Position(33744, 31506, 14),
		requirements = { bosstiary = { name = "The Dread Maiden", kills = 1 } }
	},
	{
		id = 7,
		name = "Feaster of Souls mini-bosses",
		bundle = true,
		waypoints = {
			{ name = "Unaz the Mean",    position = Position(33566, 31477, 8) },
			{ name = "Vok the Freakish", position = Position(33509, 31452, 9) },
			{ name = "Irgix the Flimsy", position = Position(33492, 31400, 8) },
		}
	},

	-- Secret Library
	{
		id = 8,
		name = "Grand Master Oberon",
		position = Position(33363, 31342, 9),
		requirements = { bosstiary = { stars = 1 } }
	},

	-- Soul Wars
	{
		id = 9,
		name = "Goshnar's Cruelty",
		position = Position(33859, 31854, 6),
		requirements = { bosstiary = { kills = 1 } }
	},
	{
		id = 10,
		name = "Goshnar's Greed",
		position = Position(33781, 31665, 14),
		requirements = { bosstiary = { kills = 1 } }
	},
	{
		id = 11,
		name = "Goshnar's Hatred",
		position = Position(33778, 31601, 14),
		requirements = { bosstiary = { kills = 1 } }
	},
	{
		id = 12,
		name = "Goshnar's Malice",
		position = Position(33684, 31599, 14),
		requirements = { bosstiary = { kills = 1 } }
	},
	{
		id = 13,
		name = "Goshnar's Spite",
		position = Position(33779, 31634, 14),
		requirements = { bosstiary = { kills = 1 } }
	},
	{
		id = 14,
		name = "Goshnar's Megalomania",
		position = Position(33681, 31634, 14),
		requirements = { bosstiary = { kills = 1 } }
	},

	-- The Prime Ordeal
	{
		id = 15,
		name = "Magma Bubble",
		position = Position(33669, 32931, 15),
		requirements = { bosstiary = { stars = 1 } }
	},
	{
		id = 16,
		name = "The Primal Menace",
		position = Position(33553, 32752, 14),
		requirements = { storage = Storage.Quest.U12_90.PrimalOrdeal.Bosses.ThePrimalMenaceKilled }
	},

	-- TODO: fix these bosses
	-- {
	-- 	id = 17,
	-- 	name = "Forgotten Knowledge",
	-- 	bundle = true,
	-- 	waypoints = {
	-- 		{ name = "Thorn Knight",        position = Position(32657, 32882, 14) },
	-- 		{ name = "Time Guardian",       position = Position(33010, 31665, 14) },
	-- 		{ name = "Dragonking Zyrtarch", position = Position(33391, 31183, 10) },
	-- 		{ name = "Last Lore Keeper",    position = Position(32019, 32849, 14) },
	-- 		{ name = "Lloyd",               position = Position(32759, 32873, 14) },
	-- 		{ name = "Frozen Horror",       position = Position(32302, 31093, 14) },
	-- 		{ name = "Lady Tenebris",       position = Position(32902, 31628, 14) },
	-- 	}
	-- },

	{
		id = 18,
		name = "Nightmare Beast / Dream Courts",
		position = Position(32208, 32094, 13),
		requirements = { bosstiary = { name = "The Nightmare Beast", kills = 1 } }
	},

	{
		id = 19,
		name = "Timira",
		position = Position(33804, 32702, 8),
		requirements = { bosstiary = { name = "Timira the Many-Headed", stars = 1 } }
	},
	{
		id = 20,
		name = "Urmahlullu",
		position = Position(33920, 31623, 8),
		requirements = { bosstiary = { name = "Urmahlullu the Weakened", stars = 1 } }
	},
	{
		id = 21,
		name = "Ratmiral Blackwhiskers",
		position = Position(33894, 31391, 15),
		requirements = { bosstiary = { stars = 1 } }
	},
	{
		id = 22,
		name = "Drume",
		position = Position(32458, 32507, 6),
		requirements = { bosstiary = { stars = 1 } }
	},
	{
		id = 23,
		name = "Faceless Bane",
		position = Position(33618, 32522, 15),
		requirements = { bosstiary = { stars = 1 } }
	},

	-- General Waypoints
	{ id = 24, name = "Asura Palace", position = Position(32949, 32692, 7) },
	{
		id = 25,
		name = "Ingol",
		bundle = true,
		waypoints = {
			{ name = "Ingol Boat", position = Position(33710, 32602, 6) },
			{ name = "Ingol Deep", position = Position(33798, 32573, 8) },
		}
	},
	{ id = 26, name = "Soul Hub",     position = Position(33621, 31427, 10) },
	{ id = 27, name = "Lion Sanctum", position = Position(33123, 32236, 12) },
	{
		id = 28,
		name = "Elven Courts",
		bundle = true,
		waypoints = {
			{ name = "Winter Courts", position = Position(32354, 31249, 3) },
			{ name = "Summer Courts", position = Position(33672, 32229, 7) },
		}
	},

	-- Deepling bosses
	{
		id = 29,
		name = "Deepling Bosses",
		requirements = { bosstiary = { name = "Jaul", kills = 1 } },
		waypoints = {
			{ name = "Jaul", position = Position(33558, 31284, 11) },
			{ name = "Tanjis", position = Position(33646, 31263, 11) },
			{ name = "Obujos", position = Position(33438, 31250, 11) },
		},
	}
}

table.sort(waypoints, function(a, b) return a.name < b.name end)

function Waypoints.getByName(name)
	for _, waypoint in ipairs(waypoints) do
		if waypoint.name:lower() == name:lower() then
			return waypoint
		end
		if waypoint.bundle then
			for _, subWaypoint in ipairs(waypoint.waypoints) do
				if subWaypoint.name:lower() == name:lower() then
					return subWaypoint
				end
			end
		end
	end
	return nil
end

function Player:addWaypointById(id)
	local storage = Storage.Waypoints.Owned.From + id
	if storage > Storage.Waypoints.Owned.To then
		Spdlog.error("Player:addWaypointById: storage > Storage.Waypoints.Owned.To")
		return false
	end
	self:setStorageValue(storage, 1)
	return true
end

function Player:addWaypoint(name)
	local waypoint = Waypoints.getByName(name)
	if not waypoint then
		return false
	end
	return self:addWaypointById(waypoint.id)
end

function Player:hasWaypointById(id)
	local storage = Storage.Waypoints.Owned.From + id
	if storage > Storage.Waypoints.Owned.To then
		Spdlog.error("Player:addWaypointById: storage > Storage.Waypoints.Owned.To")
		return false
	end
	local storageValue = self:getUpdatedAccountStorage(storage)
	return storageValue >= 1
end

function Player:hasWaypoint(name)
	local waypoint = Waypoints.getByName(name)
	if not waypoint then
		return false
	end
	return self:hasWaypointById(waypoint.id)
end

function Player:getWaypoints()
	local ownedWaypoints = {}
	for _, waypoint in ipairs(waypoints) do
		if self:hasWaypointById(waypoint.id) then
			if waypoint.bundle then
				for _, subWaypoint in ipairs(waypoint.waypoints) do
					table.insert(ownedWaypoints, subWaypoint)
				end
			else
				table.insert(ownedWaypoints, waypoint)
			end
		end
	end
	table.sort(ownedWaypoints, function(a, b) return a.name < b.name end)
	return ownedWaypoints
end

function Player:addWaypointModal(onAdd)
	local window = ModalWindow {
		title = "Activate a waypoint",
		message = "Select a waypoint to activate:",
	}
	local choices = {}
	for _, waypoint in ipairs(waypoints) do
		local id = waypoint.id
		if not self:hasWaypointById(id) then
			local choiceName = waypoint.name
			if waypoint.bundle then
				choiceName = waypoint.name .. " (bundle)"
			end

			local allowed = true
			local requirements = waypoint.requirements
			if requirements then
				if requirements.storage then
					allowed = allowed and self:getStorageValue(requirements.storage) >= 1
				elseif requirements.bosstiary then
					local name = requirements.bosstiary.name or waypoint.name
					if requirements.bosstiary.kills then
						local currentKills = self:getBosstiaryKills(name)
						if currentKills then
							allowed = allowed and currentKills >= requirements.bosstiary.kills
						else
							Spdlog.error("No bosstiary entry for " .. name)
							allowed = false
						end
					elseif requirements.bosstiary.stars then
						local currentStars = self:getBosstiaryLevel(name)
						if currentStars then
							allowed = allowed and currentStars >= requirements.bosstiary.stars
						else
							Spdlog.error("No bosstiary entry for " .. name)
							allowed = false
						end
					end
				end
			end

			if not allowed then
				choiceName = "[LOCKED] " .. choiceName
			end

			table.insert(choices, {
				name = choiceName,
				callback = function(player, button)
					if button.name ~= "Select" then
						return true
					end

					if not allowed then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have not earned the ability to unlock this waypoint yet.")
						if requirements.storage then
							player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must kill at least one " .. waypoint.name .. ".")
						elseif requirements.bosstiary then
							local name = requirements.bosstiary.name or waypoint.name
							local kills = requirements.bosstiary.kills == 1 and "one" or requirements.bosstiary.kills
							if requirements.bosstiary.kills then
								player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
									"You must kill at least " .. kills .. " " .. (requirements.bosstiary.name or name) .. ".")
							elseif requirements.bosstiary.stars then
								local stars = requirements.bosstiary.stars == 1 and "one" or requirements.bosstiary.stars
								local plural = requirements.bosstiary.stars == 1 and "" or "s"
								player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
									"You must earn at least " .. stars .. " star" .. plural .. " in the " .. (requirements.bosstiary.name or name) .. " bosstiary.")
							end
						end
						player:addWaypointModal(onAdd)
						return false
					end

					if self:addWaypointById(id) then
						self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have activated the " .. choiceName .. " waypoint.")
						onAdd()
					else
						self:sendTextMessage(MESSAGE_EVENT_ADVANCE,
							"You already have the " .. choiceName .. " waypoint activated.")
					end
				end,
			})
		end
	end
	table.sort(choices, function(a, b) return a.name < b.name end)
	for _, choice in ipairs(choices) do
		window:addChoice(choice.name, choice.callback)
	end
	window:addButton("Select")
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(self)
end

function Player:gotoWaypoint(name, force)
	local waypoint = Waypoints.getByName(name)
	if not waypoint then
		return false
	end
	if not force and not self:hasWaypointById(waypoint.id) then
		return false
	end

	self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You were teleported to " .. waypoint.name)
	self:teleportTo(waypoint.position)
	self:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
end
