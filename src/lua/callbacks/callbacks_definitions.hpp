/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2022 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#ifndef SRC_LUA_CALLBACKS_CALLBACKS_DEFINITIONS_HPP_
#define SRC_LUA_CALLBACKS_CALLBACKS_DEFINITIONS_HPP_

enum class EventCallback_t : int16_t {
	None,
	// Creature
	CreatureOnChangeOutfit,
	CreatureOnAreaCombat,
	CreatureOnTargetCombat,
	CreatureOnHear,
	CreatureOnDrainHealth,
	// Party
	PartyOnJoin,
	PartyOnLeave,
	PartyOnDisband,
	PartyOnShareExperience,
	// Player
	PlayerOnBrowseField,
	PlayerOnLook,
	PlayerOnLookInBattleList,
	PlayerOnLookInTrade,
	PlayerOnLookInShop,
	PlayerOnMoveItem,
	PlayerOnItemMoved,
	PlayerOnChangeZone,
	PlayerOnChangeHazard,
	PlayerOnMoveCreature,
	PlayerOnReportRuleViolation,
	PlayerOnReportBug,
	PlayerOnTurn,
	PlayerOnTradeRequest,
	PlayerOnTradeAccept,
	PlayerOnGainExperience,
	PlayerOnLoseExperience,
	PlayerOnGainSkillTries,
	PlayerOnRequestQuestLog,
	PlayerOnRequestQuestLine,
	PlayerOnStorageUpdate,
	PlayerOnRemoveCount,
	PlayerOnCombat,
	PlayerOnInventoryUpdate,
	// Monster
	MonsterOnDropLoot,
	MonsterPostDropLoot,
	MonsterOnSpawn,
	// Npc
	NpcOnSpawn,
};

#endif // SRC_LUA_CALLBACKS_CALLBACKS_DEFINITIONS_HPP_
