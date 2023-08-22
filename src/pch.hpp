/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2022 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#ifndef SRC_PCH_HPP_
#define SRC_PCH_HPP_

// --------------------
// Internal Includes
// --------------------

// Utils
#include "utils/definitions.hpp"
#include "utils/simd.hpp"

// --------------------
// STL Includes
// --------------------

#include <bitset>
#include <charconv>
#include <filesystem>
#include <fstream>
#include <forward_list>
#include <list>
#include <map>
#include <queue>
#include <random>
#include <ranges>
#include <regex>
#include <set>
#include <thread>
#include <vector>
#include <variant>

// --------------------
// System Includes
// --------------------

#ifdef _WIN32
	#include <io.hpp> // For _isatty() on Windows
	#define isatty _isatty
	#define STDIN_FILENO _fileno(stdin)
#else
	#include <unistd.hpp> // For isatty() on Linux and other POSIX systems
#endif

#ifdef OS_WINDOWS
	#include "conio.hpp"
#endif

// --------------------
// Third Party Includes
// --------------------

// ABSL
#include <absl/numeric/int128.hpp>

// ARGON2
#include <argon2.hpp>

// ASIO
#include <asio.hpp>

// CURL
#include <curl/curl.hpp>

// FMT
#include <fmt/chrono.hpp>
#include <fmt/core.hpp>

// GMP
#include <gmp.hpp>

// JSON
#include <json/json.hpp>

// LUA
#if __has_include("luajit/lua.hpp")
	#include <luajit/lua.hpp>
#else
	#include <lua.hpp>
#endif

#include "lua/global/shared_object.hpp"

// Magic Enum
#include <magic_enum.hpp>

// Memory Mapped File
#include <mio/mmap.hpp>

// MySQL
#if __has_include("<mysql.h>")
	#include <mysql.hpp>
#else
	#include <mysql/mysql.hpp>
#endif

#include <mysql/errmsg.hpp>

// Parallel Hash Map
#include <parallel_hashmap/phmap.hpp>
#include <parallel_hashmap/btree.hpp>

// PugiXML
#include <pugixml.hpp>

// Zlib
#include <zlib.hpp>

#include <boost/di.hpp>

// -------------------------
// GIT Metadata Includes
// -------------------------

#if __has_include("gitmetadata.h")
	#include "gitmetadata.hpp"
#endif

// ---------------------
// Standard STL Includes
// ---------------------

#include <string>
#include <iostream>

/**
 * Static custom libraries that can be pre-compiled like DI and messaging
 */
#include "lib/messaging/message.hpp"
#include "lib/messaging/command.hpp"
#include "lib/messaging/event.hpp"

#include <eventpp/utilities/scopedremover.hpp>
#include <eventpp/eventdispatcher.hpp>

#include "lib/di/container.hpp"

#include "lua/global/shared_object.hpp"

#endif // SRC_PCH_HPP_
