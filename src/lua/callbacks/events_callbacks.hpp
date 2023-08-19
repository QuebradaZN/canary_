/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2022 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#ifndef SRC_LUA_CALLBACKS_EVENTS_CALLBACKS_HPP_
#define SRC_LUA_CALLBACKS_EVENTS_CALLBACKS_HPP_

#include "lua/callbacks/callbacks_definitions.hpp"
#include "lua/callbacks/event_callback.hpp"
#include "lua/scripts/luascript.h"

class EventCallback;

/**
 * @class EventsCallbacks
 * @brief Class managing all event callbacks.
 *
 * @note This class is a singleton that holds all registered event callbacks.
 * @details It provides functions to add new callbacks and retrieve callbacks by type.
 */

class EventsCallbacks {
	public:
		EventsCallbacks();
		~EventsCallbacks();

		EventsCallbacks(const EventsCallbacks &) = delete;
		EventsCallbacks &operator=(const EventsCallbacks &) = delete;

		static EventsCallbacks &getInstance();

		/**
		 * @brief Adds a new event callback to the list.
		 * @param callback Pointer to the EventCallback object to add.
		 */
		void addCallback(const std::shared_ptr<EventCallback> &callback);

		/**
		 * @brief Gets all registered event callbacks.
		 * @return Vector of pointers to EventCallback objects.
		 */
		std::vector<std::shared_ptr<EventCallback>> getCallbacks() const;

		/**
		 * @brief Gets event callbacks by their type.
		 * @param type The type of callbacks to retrieve.
		 * @return Vector of pointers to EventCallback objects of the specified type.
		 */
		std::vector<std::shared_ptr<EventCallback>> getCallbacksByType(EventCallback_t type) const;

		void clear();

		template <typename CallbackFunc, typename... Args>
		void executeCallback(EventCallback_t eventType, CallbackFunc callbackFunc, Args &&... args) {
			for (const auto &callback : getCallbacksByType(eventType)) {
				if (callback && callback->isLoadedCallback()) {
					((*callback).*callbackFunc)(std::forward<Args>(args)...);
				}
			}
		}
		template <typename CallbackFunc, typename... Args>
		bool checkCallback(EventCallback_t eventType, CallbackFunc callbackFunc, Args &&... args) {
			bool allCallbacksSucceeded = true;

			for (const auto &callback : getCallbacksByType(eventType)) {
				if (callback && callback->isLoadedCallback()) { // Verifique se o callback é não nulo
					bool callbackResult = ((*callback).*callbackFunc)(std::forward<Args>(args)...);
					allCallbacksSucceeded = allCallbacksSucceeded && callbackResult;
				}
			}
			return allCallbacksSucceeded;
		}

	private:
		// Container for storing registered event callbacks.
		std::vector<std::shared_ptr<EventCallback>> m_callbacks;
};

constexpr auto g_callbacks = EventsCallbacks::getInstance;

#endif // SRC_LUA_CALLBACKS_EVENTS_CALLBACKS_HPP_
