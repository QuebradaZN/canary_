/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2022 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

#include "items/containers/container.hpp"

class RewardChest final : public Container {
public:
	explicit RewardChest(uint16_t type);

	RewardChest* getRewardChest() final {
		return this;
	}
	const RewardChest* getRewardChest() const final {
		return this;
	}

	// cylinder implementations
	ReturnValue queryAdd(int32_t index, const Thing &thing, uint32_t count, uint32_t flags, Creature* actor = nullptr) const final;

	void postAddNotification(Thing* thing, const Cylinder* oldParent, int32_t index, CylinderLink_t link = LINK_OWNER) final;
	void postRemoveNotification(Thing* thing, const Cylinder* newParent, int32_t index, CylinderLink_t link = LINK_OWNER) final;

	bool canRemove() const final {
		return false;
	}

	void removeItem(Thing* thing, bool sendToClient = false) override;
};
