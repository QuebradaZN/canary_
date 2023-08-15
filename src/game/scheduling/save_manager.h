#ifndef SRC_GAME_SCHEDULING_SAVE_MANAGER_H_
#define SRC_GAME_SCHEDULING_SAVE_MANAGER_H_

#include "utils/thread_holder_base.h"
#include <unordered_set>

class SaveManager : public ThreadHolder<SaveManager> {
	public:
		SaveManager() = default;

		SaveManager(const SaveManager &) = delete;
		void operator=(const SaveManager &) = delete;

		static SaveManager &getInstance();

		void schedulePlayer(Player* player);
		void unschedulePlayer(Player* player);

	private:
		phmap::btree_map<uint32_t, std::chrono::steady_clock::time_point> playerMap;
};

constexpr auto g_saveManager = SaveManager::getInstance;

#endif // SRC_GAME_SCHEDULING_SAVE_MANAGER_H_
