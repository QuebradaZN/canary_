
local PlayerFlags_t = {
	["CannotUseCombat"] = CannotUseCombat,
	["CannotAttackPlayer"] = CannotAttackPlayer,
	["CannotAttackMonster"] = CannotAttackMonster,
	["CannotBeAttacked"] = CannotBeAttacked,
	["CanConvinceAll"] = CanConvinceAll,
	["CanSummonAll"] = CanSummonAll,
	["CanIllusionAll"] = CanIllusionAll,
	["CanSenseInvisibility"] = CanSenseInvisibility,
	["IgnoredByMonsters"] = IgnoredByMonsters,
	["NotGainInFight"] = NotGainInFight,
	["HasInfiniteMana"] = HasInfiniteMana,
	["HasInfiniteSoul"] = HasInfiniteSoul,
	["HasNoExhaustion"] = HasNoExhaustion,
	["CannotUseSpells"] = CannotUseSpells,
	["CannotPickupItem"] = CannotPickupItem,
	["CanAlwaysLogin"] = CanAlwaysLogin,
	["CanBroadcast"] = CanBroadcast,
	["CanEditHouses"] = CanEditHouses,
	["CannotBeBanned"] = CannotBeBanned,
	["CannotBePushed"] = CannotBePushed,
	["HasInfiniteCapacity"] = HasInfiniteCapacity,
	["CanPushAllCreatures"] = CanPushAllCreatures,
	["CanTalkRedPrivate"] = CanTalkRedPrivate,
	["CanTalkRedChannel"] = CanTalkRedChannel,
	["TalkOrangeHelpChannel"] = TalkOrangeHelpChannel,
	["NotGainExperience"] = NotGainExperience,
	["NotGainMana"] = NotGainMana,
	["NotGainHealth"] = NotGainHealth,
	["NotGainSkill"] = NotGainSkill,
	["SetMaxSpeed"] = SetMaxSpeed,
	["SpecialVIP"] = SpecialVIP,
	["NotGenerateLoot"] = NotGenerateLoot,
	["CanTalkRedChannelAnonymous"] = CanTalkRedChannelAnonymous,
	["IgnoreProtectionZone"] = IgnoreProtectionZone,
	["IgnoreSpellCheck"] = IgnoreSpellCheck,
	["IgnoreWeaponCheck"] = IgnoreWeaponCheck,
	["CannotBeMuted"] = CannotBeMuted,
	["IsAlwaysPremium"] = IsAlwaysPremium,
	["CanMapClickTeleport"] = CanMapClickTeleport,
	["IgnoredByNpcs"] = IgnoredByNpcs,
}

local function sendValidKeys(player)
	local flagsList = {}
	for flagName, _ in pairs(PlayerFlags_t) do
		table.insert(flagsList, flagName)
	end

	local text = "Invalid flag. Valid flags are: ".. table.concat(flagsList, "\n")
	player:showTextDialog(2019, text)
end

local function getFlagNumberOrName(flagType)
	for flagName, flagEnum in pairs(PlayerFlags_t) do
		if tonumber(flagEnum) == tonumber(flagType) then
			return flagEnum
		end
		if type(flagType) == "string" and string.lower(flagType) == string.lower(flagName) then
			return flagEnum
		end
	end
	return nil
end

local function getFlagNameByType(flagType)
	for flagName, flagEnum in pairs(PlayerFlags_t) do
		if tonumber(flagEnum) == tonumber(flagType) then
			return flagName
		end
	end
	return nil
end

function Player.talkactionHasFlag(self, param, flagType)
	if not HasValidTalkActionParams(self, param, "Usage: /hasflag <playerName>, <flagnumber or name>") then
		return false
	end

	local split = param:split(",")
	local playerName = split[1]:trimSpace()
	local flag = split[2]:trimSpace()
	local flagValue = getFlagNumberOrName(flag)
	if not flagValue then
		sendValidKeys(self)
		return false
	end

	local targetPlayer = Player(playerName)
	if not targetPlayer then
		self:sendCancelMessage("Player " .. playerName .. " not found.")
		return false
	end

	if not targetPlayer:hasGroupFlag(flagValue) then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Player " .. playerName .. " not have flag type: " .. getFlagNameByType(flagValue) .. ".")
	else
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Player " .. playerName .. " have flag type: " .. getFlagNameByType(flagValue) .. ".")
	end

	return true
end

function Player.talkactionSetFlag(self, param, flagType)
	if not HasValidTalkActionParams(self, param, "Usage: /setflag <playerName>, <flagnumber or name>") then
		return false
	end

	local split = param:split(",")
	local playerName = split[1]:trimSpace()
	local flag = split[2]:trimSpace()
	local flagValue = getFlagNumberOrName(flag)
	if not flagValue then
		sendValidKeys(self)
		return false
	end

	local targetPlayer = Player(playerName)
	if not targetPlayer then
		self:sendCancelMessage("Player " .. playerName .. " not found.")
		return false
	end

	if targetPlayer:hasFlag(flagValue) then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE,"Player " .. playerName .. " already has flag " .. getFlagNameByType(flagValue) .. ".")
		return false
	end

	targetPlayer:setGroupFlag(flagValue)
	self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Flag " .. getFlagNameByType(flagValue)  .. " set for player " .. playerName .. ".")
	Spdlog.info("[Player.talkactionSetFlag] Added flag " .. getFlagNameByType(flagValue) .. " to ".. targetPlayer:getName().. " character by " .. self:getName() .. ".")
	return true
end

function Player.talkactionRemoveFlag(self, param, flagType)
	if not HasValidTalkActionParams(self, param, "Usage: /removeflag <playerName>, <flagnumber or name>") then
		return false
	end

	local split = param:split(",")
	local playerName = split[1]:trimSpace()
	local flag = split[2]:trimSpace()
	local flagValue = getFlagNumberOrName(flag)
	if not flagValue then
		sendValidKeys(self)
		return false
	end

	local targetPlayer = Player(playerName)
	if not targetPlayer then
		self:sendCancelMessage("Player " .. playerName .. " not found.")
		return false
	end

	if not targetPlayer:hasFlag(flagValue) then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Player " .. playerName .. " not have flag " .. getFlagNameByType(flagValue) .. ".")
		return false
	end

	targetPlayer:removeGroupFlag(flagValue)
	self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Flag " .. getFlagNameByType(flagValue) .. " removed from player " .. playerName .. ".")
	Spdlog.info("[Player.talkactionRemoveFlag] Removed flag " .. getFlagNameByType(flagValue) .. " from ".. targetPlayer:getName().. " character by " .. self:getName() .. ".")
	return true
end

local flag = TalkAction("/hasflag")

<<<<<<< HEAD:data/scripts/talkactions.lua
		["chat"] = RELOAD_TYPE_CHAT,
		["channel"] = RELOAD_TYPE_CHAT,
		["chatchannels"] = RELOAD_TYPE_CHAT,

		["config"] = RELOAD_TYPE_CONFIG,
		["configuration"] = RELOAD_TYPE_CONFIG,

		["events"] = RELOAD_TYPE_EVENTS,

		["items"] = RELOAD_TYPE_ITEMS,

		["module"] = RELOAD_TYPE_MODULES,
		["modules"] = RELOAD_TYPE_MODULES,

		["monster"] = RELOAD_TYPE_MONSTERS,
		["monsters"] = RELOAD_TYPE_MONSTERS,

		["mount"] = RELOAD_TYPE_MOUNTS,
		["mounts"] = RELOAD_TYPE_MOUNTS,

		["npc"] = RELOAD_TYPE_NPCS,
		["npcs"] = RELOAD_TYPE_NPCS,

		["raid"] = RELOAD_TYPE_RAIDS,
		["raids"] = RELOAD_TYPE_RAIDS,

		["scripts"] = RELOAD_TYPE_SCRIPTS,

		["rate"] = RELOAD_TYPE_CORE,
		["rates"] = RELOAD_TYPE_CORE,
		["stage"] = RELOAD_TYPE_CORE,
		["stages"] = RELOAD_TYPE_CORE,
		["global"] = RELOAD_TYPE_CORE,
		["core"] = RELOAD_TYPE_CORE,
		["lib"] = RELOAD_TYPE_CORE,
		["libs"] = RELOAD_TYPE_CORE,

		["imbuements"] = RELOAD_TYPE_IMBUEMENTS,

		["talkaction"] = RELOAD_TYPE_TALKACTION,
		["talkactions"] = RELOAD_TYPE_TALKACTION,
		["talk"] = RELOAD_TYPE_TALKACTION,

		["group"] = RELOAD_TYPE_GROUPS,
		["groups"] = RELOAD_TYPE_GROUPS
	}

	if notAccountTypeGod(self) then
		return true
	end

	if not configManager.getBoolean(configKeys.ALLOW_RELOAD) then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE,"Reload command is disabled.")
		return true
	end

	if param == "" then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE,"Command param required.")
		return false
	end

	logCommand(self, "/reload", param)

	local reloadType = reloadTypes[param:lower()]
	if reloadType then
		-- Force save server before reload
		saveServer()
		SaveHirelings()
		Spdlog.info("Saved Hirelings")
		self:sendTextMessage(MESSAGE_ADMINISTRADOR, "Server is saved.. Now will reload configs!")

		Game.reload(reloadType)
		self:sendTextMessage(MESSAGE_LOOK, string.format("Reloaded %s.", param:lower()))
		Spdlog.info("Reloaded " .. param:lower() .. "")
		return true
	elseif not reloadType then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE,"Reload type not found.")
		Spdlog.warn("[reload.onSay] - Reload type '".. param.. "' not found")
		return false
	end
	return false
||||||| 83d2da85a:data/scripts/talkactions.lua
		["chat"] = RELOAD_TYPE_CHAT,
		["channel"] = RELOAD_TYPE_CHAT,
		["chatchannels"] = RELOAD_TYPE_CHAT,

		["config"] = RELOAD_TYPE_CONFIG,
		["configuration"] = RELOAD_TYPE_CONFIG,

		["events"] = RELOAD_TYPE_EVENTS,

		["items"] = RELOAD_TYPE_ITEMS,

		["module"] = RELOAD_TYPE_MODULES,
		["modules"] = RELOAD_TYPE_MODULES,

		["monster"] = RELOAD_TYPE_MONSTERS,
		["monsters"] = RELOAD_TYPE_MONSTERS,

		["mount"] = RELOAD_TYPE_MOUNTS,
		["mounts"] = RELOAD_TYPE_MOUNTS,

		["npc"] = RELOAD_TYPE_NPCS,
		["npcs"] = RELOAD_TYPE_NPCS,

		["raid"] = RELOAD_TYPE_RAIDS,
		["raids"] = RELOAD_TYPE_RAIDS,

		["scripts"] = RELOAD_TYPE_SCRIPTS,

		["rate"] = RELOAD_TYPE_CORE,
		["rates"] = RELOAD_TYPE_CORE,
		["stage"] = RELOAD_TYPE_CORE,
		["stages"] = RELOAD_TYPE_CORE,
		["global"] = RELOAD_TYPE_CORE,
		["core"] = RELOAD_TYPE_CORE,
		["lib"] = RELOAD_TYPE_CORE,
		["libs"] = RELOAD_TYPE_CORE,

		["imbuements"] = RELOAD_TYPE_IMBUEMENTS,

		["talkaction"] = RELOAD_TYPE_TALKACTION,
		["talkactions"] = RELOAD_TYPE_TALKACTION,
		["talk"] = RELOAD_TYPE_TALKACTION,

		["group"] = RELOAD_TYPE_GROUPS,
		["groups"] = RELOAD_TYPE_GROUPS
	}

	if notAccountTypeGod(self) then
		return true
	end

	if not configManager.getBoolean(configKeys.ALLOW_RELOAD) then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE,"Reload command is disabled.")
		return true
	end

	if param == "" then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE,"Command param required.")
		return false
	end

	logCommand(self, "/reload", param)

	local reloadType = reloadTypes[param:lower()]
	if reloadType then
		Game.reload(reloadType)
		self:sendTextMessage(MESSAGE_LOOK, string.format("Reloaded %s.", param:lower()))
		Spdlog.info("Reloaded " .. param:lower() .. "")
		return true
	elseif not reloadType then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE,"Reload type not found.")
		Spdlog.warn("[reload.onSay] - Reload type '".. param.. "' not found")
		return false
	end
	return false
=======
function flag.onSay(player, words, param)
	return player:talkactionHasFlag(param)
>>>>>>> upstream/main:data/scripts/talkactions/god/flags.lua
end

flag:separator(" ")
flag:groupType("god")
flag:register()

flag = TalkAction("/setflag")

function flag.onSay(player, words, param)
	return player:talkactionSetFlag(param)
end

flag:separator(" ")
flag:groupType("god")
flag:register()

flag = TalkAction("/removeflag")

function flag.onSay(player, words, param)
	return player:talkactionRemoveFlag(param)
end

flag:separator(" ")
flag:groupType("god")
flag:register()
