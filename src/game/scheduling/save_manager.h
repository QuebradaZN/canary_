#ifndef SRC_GAME_SCHEDULING_SAVE_MANAGER_H_
#define SRC_GAME_SCHEDULING_SAVE_MANAGER_H_

#include "utils/thread_holder_base.h"
#include <unordered_set>

class SaveManager : public ThreadHolder<SaveManager> {
	public:
		SaveManager() = default;

		SaveManager(const SaveManager &) = delete;
		void operator=(const SaveManager &) = delete;

		static SaveManager &getInstance() {
			// Guaranteed to be destroyed
			static SaveManager instance;
			// Instantiated on first use
			return instance;
		}

		void shutdown();

		void threadMain();

		void schedulePlayer(Player* player);
		void unschedulePlayer(Player* player);

	private:
		std::mutex taskLock;
		std::condition_variable taskSignal;
		std::deque<Player*> playerQueue;
		std::unordered_set<Player*> playerSet;
};

constexpr auto g_saveManager = &SaveManager::getInstance;

#endif // SRC_GAME_SCHEDULING_SAVE_MANAGER_H_
