#include "pch.hpp"

#include "game/game.h"
#include "game/scheduling/save_manager.h"
#include "io/iologindata.h"

void SaveManager::threadMain() {
	while (getState() != THREAD_STATE_TERMINATED) {
		std::unique_lock<std::mutex> taskLockUnique(taskLock);
		taskSignal.wait(taskLockUnique, [this] { return !playerQueue.empty() || getState() == THREAD_STATE_TERMINATED; });

		if (getState() == THREAD_STATE_TERMINATED)
			break;

		Player* player = playerQueue.front();
		playerQueue.pop_front();
		playerSet.erase(player);
		taskLockUnique.unlock();

		if (player) {
			if (isDevMode()) {
				SPDLOG_INFO("Saving player {}.", player->getName());
			}
			bool saveSuccess = IOLoginData::savePlayer(player);
			if (!saveSuccess) {
				SPDLOG_ERROR("Failed to save player {}.", player->getName());
			}
		}
	}
}

void SaveManager::schedulePlayer(Player* player) {
	std::lock_guard<std::mutex> taskLockGuard(taskLock);
	if (playerSet.insert(player).second) {
		if (isDevMode()) {
			SPDLOG_INFO("Scheduling player {} for saving.", player->getName());
		}
		playerQueue.push_back(player);
		taskSignal.notify_all();
	} else {
		if (isDevMode()) {
			SPDLOG_INFO("Player {} is already scheduled for saving. Pushing to the back of the queue.", player->getName());
		}
		playerQueue.erase(std::remove(playerQueue.begin(), playerQueue.end(), player), playerQueue.end());
		playerQueue.push_back(player);
	}
}

void SaveManager::unschedulePlayer(Player* player) {
	std::lock_guard<std::mutex> taskLockGuard(taskLock);
	if (playerSet.contains(player)) {
		if (isDevMode()) {
			SPDLOG_INFO("Unscheduling player {} from saving.", player->getName());
		}
		playerSet.erase(player);
		playerQueue.erase(std::remove(playerQueue.begin(), playerQueue.end(), player), playerQueue.end());
	}
}

void SaveManager::shutdown() {
	std::lock_guard<std::mutex> taskLockGuard(taskLock);
	setState(THREAD_STATE_TERMINATED);
	taskSignal.notify_all();
}
