#include "pch.hpp"

#include "game/game.h"
#include "game/scheduling/save_manager.h"
#include "io/iologindata.h"

SaveManager &SaveManager::getInstance() {
	return inject<SaveManager>();
}

void SaveManager::schedulePlayer(Player* player) {
	auto playerId = player->getID();
	auto scheduledAt = std::chrono::steady_clock::now();
	playerMap[playerId] = scheduledAt;
	g_logger().debug("Scheduling player {} for saving.", player->getName());

	addLoad([this, playerId, scheduledAt]() {
		bool shouldSave = scheduledAt == playerMap[playerId];
		if (!shouldSave) {
			g_logger().debug("Skipping save for player {} because another save has been scheduled.", playerId);
			return;
		}
		auto player = g_game().getPlayerByID(playerId);
		if (!player) {
			g_logger().debug("Skipping save for player {} because player is no longer online.", playerId);
			return;
		}
		g_logger().debug("Saving player {}.", player->getName());
		bool saveSuccess = IOLoginData::savePlayer(player);
		if (!saveSuccess) {
			g_logger().error("Failed to save player {}.", player->getName());
		}
		playerMap.erase(playerId);
	});
}

void SaveManager::unschedulePlayer(Player* player) {
	g_logger().debug("Unscheduling player {} from saving.", player->getName());
	playerMap.erase(player->getID());
}
