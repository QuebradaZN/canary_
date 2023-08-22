#include "pch.hpp"

#include "game/game.hpp"
#include "game/scheduling/save_manager.hpp"
#include "io/iologindata.hpp"

SaveManager::SaveManager(ThreadPool &threadPool) :
	threadPool(threadPool) { }

SaveManager &SaveManager::getInstance() {
	return inject<SaveManager>();
}

void SaveManager::schedulePlayer(Player* player) {
	auto scheduledAt = std::chrono::steady_clock::now();
	auto playerId = player->getID();

	{
		Player::PlayerLock lock(*player);
		playerMap[playerId] = scheduledAt;
	}
	g_logger().debug("Scheduling player {} for saving.", player->getName());

	threadPool.addLoad([this, playerId, scheduledAt]() {
		auto player = g_game().getPlayerByID(playerId);
		if (!player) {
			g_logger().debug("Skipping save for player {} because player is no longer online.", playerId);
			return;
		}
		Player::PlayerLock lock(*player);
		bool shouldSave = scheduledAt == playerMap[playerId];
		if (!shouldSave) {
			g_logger().debug("Skipping save for player {} because another save has been scheduled.", playerId);
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
