/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2022 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "pch.hpp"

#include "items/containers/rewards/rewardchest.hpp"

RewardChest::RewardChest(uint16_t type) :
	Container(type) {
	maxSize = 32;
	unlocked = false;
	pagination = true;
}

ReturnValue RewardChest::queryAdd(int32_t, const Thing &, uint32_t, uint32_t, Creature* actor /* = nullptr*/) const {
	if (actor) {
		return RETURNVALUE_NOTPOSSIBLE;
	}

	return RETURNVALUE_NOERROR;
}

void RewardChest::postAddNotification(Thing* thing, const Cylinder* oldParent, int32_t index, CylinderLink_t) {
	if (parent != nullptr) {
		parent->postAddNotification(thing, oldParent, index, LINK_PARENT);
	}
}

void RewardChest::postRemoveNotification(Thing* thing, const Cylinder* newParent, int32_t index, CylinderLink_t) {
	if (parent != nullptr) {
		parent->postRemoveNotification(thing, newParent, index, LINK_PARENT);
	}
}

// Second argument is disabled by default because not need to send to client in the RewardChest
void RewardChest::removeItem(Thing* thing, bool /* sendToClient = false*/) {
	if (thing == nullptr) {
		return;
	}

	auto itemToRemove = thing->getItem();
	if (itemToRemove == nullptr) {
		return;
	}

	auto it = std::ranges::find(itemlist.begin(), itemlist.end(), itemToRemove);
	if (it != itemlist.end()) {
		itemlist.erase(it);
		itemToRemove->setParent(nullptr);
	}
}
