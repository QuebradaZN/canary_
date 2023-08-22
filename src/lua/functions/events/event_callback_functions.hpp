/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2022 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#ifndef SRC_LUA_FUNCTIONS_EVENTS_EVENT_CALLBACK_FUNCTIONS_HPP_
#define SRC_LUA_FUNCTIONS_EVENTS_EVENT_CALLBACK_FUNCTIONS_HPP_

#include "lua/scripts/luascript.hpp"

/**
 * @class EventCallbackFunctions
 * @brief Class providing Lua functions for manipulating event callbacks.
 *
 * @note This class is derived from LuaScriptInterface and defines several static functions that are exposed to the Lua environment.
 * @details It allows Lua scripts to create, configure, and register event callbacks.
 *
 * @see LuaScriptInterface
 */
class EventCallbackFunctions : public LuaScriptInterface {
	public:
		/**
		 * @brief Initializes the Lua state with the event callback functions.
		 *
		 * This function registers the event callback-related functions with the given Lua state,
		 * making them accessible to Lua scripts.
		 *
		 * @param luaState The Lua state to initialize.
		 */
		static void init(lua_State* luaState);

		/**
		 * @brief Send the load of callbacks to lua
		 * @param luaState The Lua state to initialize.
		 */
		static int luaEventCallbackLoad(lua_State* luaState);

	private:
		static int luaEventCallbackCreate(lua_State* luaState);
		static int luaEventCallbackType(lua_State* luaState);
		static int luaEventCallbackRegister(lua_State* luaState);

		/**
		 * @note here end the lua binder functions }
		 */
};

#endif // SRC_LUA_FUNCTIONS_EVENTS_EVENT_CALLBACK_FUNCTIONS_HPP_
