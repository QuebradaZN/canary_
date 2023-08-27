/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2022 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "pch.hpp"

#include "zone.hpp"
#include "game/game.hpp"
#include "creatures/monsters/monster.hpp"
#include "creatures/npcs/npc.hpp"
#include "creatures/players/player.hpp"

phmap::parallel_flat_hash_map<std::string, std::shared_ptr<Zone>> Zone::zones = {};
std::mutex Zone::zonesMutex = {};
const static std::shared_ptr<Zone> nullZone = nullptr;

std::shared_ptr<Zone> Zone::addZone(const std::string &name) {
	std::lock_guard lock(zonesMutex);
	if (name == "default") {
		g_logger().error("Zone name {} is reserved", name);
		return nullZone;
	}
	if (zones[name]) {
		g_logger().error("Zone {} already exists", name);
		return nullZone;
	}
	zones[name] = std::make_shared<Zone>(name);
	return zones[name];
}

void Zone::addArea(Area area) {
	for (const Position &pos : area) {
		positions.insert(pos);
		Tile* tile = g_game().map.getTile(pos);
		if (tile) {
			tilesCache.insert(tile);
			for (auto item : *tile->getItemList()) {
				itemAdded(item);
			}
			for (auto creature : *tile->getCreatures()) {
				creatureAdded(creature);
			}
		}
	}
}

void Zone::subtractArea(Area area) {
	for (const Position &pos : area) {
		positions.erase(pos);
		Tile* tile = g_game().map.getTile(pos);
		if (tile) {
			tilesCache.erase(tile);
			for (auto item : *tile->getItemList()) {
				itemRemoved(item);
			}
			for (auto creature : *tile->getCreatures()) {
				creatureRemoved(creature);
			}
		}
	}
}

bool Zone::isPositionInZone(const Position &pos) const {
	return positions.contains(pos);
}

std::shared_ptr<Zone> Zone::getZone(const std::string &name) {
	std::lock_guard lock(zonesMutex);
	return zones[name];
}

const phmap::parallel_flat_hash_set<Position> &Zone::getPositions() const {
	return positions;
}

const phmap::parallel_flat_hash_set<Tile*> &Zone::getTiles() const {
	return tilesCache;
}

const phmap::parallel_flat_hash_set<Creature*> &Zone::getCreatures() const {
	return creaturesCache;
}

const phmap::parallel_flat_hash_set<Player*> &Zone::getPlayers() const {
	return playersCache;
}

const phmap::parallel_flat_hash_set<Monster*> &Zone::getMonsters() const {
	return monstersCache;
}

const phmap::parallel_flat_hash_set<Npc*> &Zone::getNpcs() const {
	return npcsCache;
}

const phmap::parallel_flat_hash_set<Item*> &Zone::getItems() const {
	return itemsCache;
}

void Zone::removeMonsters() const {
	// copy monsters because removeCreature will remove monster from monsters
	phmap::parallel_flat_hash_set<Monster*> monstersCopy = monstersCache;
	for (auto monster : monstersCopy) {
		g_game().removeCreature(monster);
	}
}

void Zone::removeNpcs() const {
	// copy npcs because removeCreature will remove npc from npcs
	phmap::parallel_flat_hash_set<Npc*> npcsCopy = npcsCache;
	for (auto npc : npcsCopy) {
		g_game().removeCreature(npc);
	}
}

void Zone::refresh() {
	std::lock_guard lock(zonesMutex);
	itemsCache.clear();
	creaturesCache.clear();
	playersCache.clear();
	monstersCache.clear();
	npcsCache.clear();
	tilesCache.clear();
	for (auto position : positions) {
		const auto &tile = g_game().map.getTile(position);
		if (tile) {
			tilesCache.insert(tile);
			for (auto item : *tile->getItemList()) {
				itemAdded(item);
			}
			for (auto creature : *tile->getCreatures()) {
				creatureAdded(creature);
			}
		}
	}
}

void Zone::clearZones() {
	std::lock_guard lock(zonesMutex);
	zones.clear();
}

phmap::parallel_flat_hash_set<std::shared_ptr<Zone>> Zone::getZones(const Position postion) {
	std::lock_guard lock(zonesMutex);
	phmap::parallel_flat_hash_set<std::shared_ptr<Zone>> zonesSet;
	for (const auto &[_, zone] : zones) {
		if (zone && zone->isPositionInZone(postion)) {
			zonesSet.insert(zone);
		}
	}
	return zonesSet;
}

const phmap::parallel_flat_hash_set<std::shared_ptr<Zone>> &Zone::getZones() {
	static phmap::parallel_flat_hash_set<std::shared_ptr<Zone>> zonesSet;
	zonesSet.clear();
	for (const auto &[_, zone] : zones) {
		if (zone) {
			zonesSet.insert(zone);
		}
	}
	return zonesSet;
}

void Zone::creatureAdded(Creature* creature) {
	creaturesCache.insert(creature);
	if (creature->getPlayer()) {
		playersCache.insert(creature->getPlayer());
	}
	if (creature->getMonster()) {
		monstersCache.insert(creature->getMonster());
	}
	if (creature->getNpc()) {
		npcsCache.insert(creature->getNpc());
	}
}

void Zone::creatureRemoved(Creature* creature) {
	creaturesCache.erase(creature);
	if (creature->getPlayer()) {
		playersCache.erase(creature->getPlayer());
	}
	if (creature->getMonster()) {
		monstersCache.erase(creature->getMonster());
	}
	if (creature->getNpc()) {
		npcsCache.erase(creature->getNpc());
	}
}

void Zone::itemAdded(Item* item) {
	itemsCache.insert(item);
}

void Zone::itemRemoved(Item* item) {
	itemsCache.erase(item);
}
