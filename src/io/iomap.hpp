/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2022 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#ifndef SRC_IO_IOMAP_H_
#define SRC_IO_IOMAP_H_

#include "declarations.hpp"

#include "config/configmanager.hpp"
#include "map/house/house.hpp"
#include "items/item.hpp"
#include "map/map.hpp"
#include "creatures/monsters/spawns/spawn_monster.hpp"
#include "creatures/npcs/spawns/spawn_npc.hpp"

#pragma pack(1)

struct OTBM_root_header {
	uint32_t version;
	uint16_t width;
	uint16_t height;
	uint32_t majorVersionItems;
	uint32_t minorVersionItems;
};

struct OTBM_Destination_coords {
	uint16_t x;
	uint16_t y;
	uint8_t z;
};

struct OTBM_Tile_coords {
	uint8_t x;
	uint8_t y;
};

#pragma pack()

class IOMapException : public std::exception {
public:
	IOMapException(const std::string &msg) :
		message(msg) { }

	const char* what() const noexcept override {
		return message.c_str();
	}

private:
	std::string message;
};

class IOMap {
public:
	static void loadMap(Map* map, const std::string &identifier, const Position &pos = Position(), bool unload = false);

	/**
	 * Load main map monsters
	 * \param map Is the map class
	 * \returns true if the monsters spawn map was loaded successfully
	 */
	static bool loadMonsters(Map* map) {
		if (map->monsterfile.empty()) {
			// OTBM file doesn't tell us about the monsterfile,
			// Lets guess it is mapname-monster.xml.
			map->monsterfile = g_configManager().getString(MAP_NAME);
			map->monsterfile += "-monster.xml";
		}

		return map->spawnsMonster.loadFromXML(map->monsterfile);
	}

	/**
	 * Load main map npcs
	 * \param map Is the map class
	 * \returns true if the npcs spawn map was loaded successfully
	 */
	static bool loadNpcs(Map* map) {
		if (map->npcfile.empty()) {
			// OTBM file doesn't tell us about the npcfile,
			// Lets guess it is mapname-npc.xml.
			map->npcfile = g_configManager().getString(MAP_NAME);
			map->npcfile += "-npc.xml";
		}

		return map->spawnsNpc.loadFromXml(map->npcfile);
	}

	/**
	 * Load main map houses
	 * \param map Is the map class
	 * \returns true if the main map houses was loaded successfully
	 */
	static bool loadHouses(Map* map) {
		if (map->housefile.empty()) {
			// OTBM file doesn't tell us about the housefile,
			// Lets guess it is mapname-house.xml.
			map->housefile = g_configManager().getString(MAP_NAME);
			map->housefile += "-house.xml";
		}

		return map->houses.loadHousesXML(map->housefile);
	}

	/**
	 * Load custom  map monsters
	 * \param map Is the map class
	 * \returns true if the monsters spawn map custom was loaded successfully
	 */
	static bool loadMonstersCustom(Map* map, const std::string &mapName, int customMapIndex) {
		if (map->monsterfile.empty()) {
			// OTBM file doesn't tell us about the monsterfile,
			// Lets guess it is mapname-monster.xml.
			map->monsterfile = mapName;
			map->monsterfile += "-monster.xml";
		}
		return map->spawnsMonsterCustomMaps[customMapIndex].loadFromXML(map->monsterfile);
	}

	/**
	 * Load custom map npcs
	 * \param map Is the map class
	 * \returns true if the npcs spawn map custom was loaded successfully
	 */
	static bool loadNpcsCustom(Map* map, const std::string &mapName, int customMapIndex) {
		if (map->npcfile.empty()) {
			// OTBM file doesn't tell us about the npcfile,
			// Lets guess it is mapname-npc.xml.
			map->npcfile = mapName;
			map->npcfile += "-npc.xml";
		}

		return map->spawnsNpcCustomMaps[customMapIndex].loadFromXml(map->npcfile);
	}

	/**
	 * Load custom map houses
	 * \param map Is the map class
	 * \returns true if the map custom houses was loaded successfully
	 */
	static bool loadHousesCustom(Map* map, const std::string &mapName, int customMapIndex) {
		if (map->housefile.empty()) {
			// OTBM file doesn't tell us about the housefile,
			// Lets guess it is mapname-house.xml.
			map->housefile = mapName;
			map->housefile += "-house.xml";
		}
		return map->housesCustomMaps[customMapIndex].loadHousesXML(map->housefile);
	}

private:
	static void parseMapDataAttributes(OTB::Loader &loader, const OTB::Node &mapNode, Map &map, const std::string &fileName);
	static void parseWaypoints(OTB::Loader &loader, const OTB::Node &waypointsNode, Map &map);
	static void parseTowns(OTB::Loader &loader, const OTB::Node &townsNode, Map &map);
	static void parseTileArea(OTB::Loader &loader, const OTB::Node &tileAreaNode, Map &map, const Position &pos, bool unload);
};

#endif // SRC_IO_IOMAP_H_
