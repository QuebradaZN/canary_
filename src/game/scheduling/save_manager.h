#ifndef SRC_GAME_SCHEDULING_SAVE_MANAGER_H_
#define SRC_GAME_SCHEDULING_SAVE_MANAGER_H_

#include "lib/thread/thread_pool.hpp"

class SaveManager {
	public:
		explicit SaveManager(ThreadPool &threadPool);

		SaveManager(const SaveManager &) = delete;
		void operator=(const SaveManager &) = delete;

		static SaveManager &getInstance();

		void schedulePlayer(Player* player);
		void unschedulePlayer(Player* player);

	private:
		phmap::parallel_flat_hash_map<uint32_t, std::chrono::steady_clock::time_point> playerMap;
		ThreadPool &threadPool;
};

constexpr auto g_saveManager = SaveManager::getInstance;

#endif // SRC_GAME_SCHEDULING_SAVE_MANAGER_H_
