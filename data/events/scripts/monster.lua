local function calculateBonus(bonus)
	local bonusCount = math.floor(bonus / 100)
	local remainder = bonus % 100
	if remainder > 0 then
		local probability = math.random(0, 100)
		bonusCount = bonusCount + (probability < remainder and 1 or 0)
	end

	return bonusCount
end

local function checkItemType(itemId)
	local itemType = ItemType(itemId):getType()
	-- Based on enum ItemTypes_t
	if (itemType > 0 and itemType < 4) or itemType == 7 or itemType == 8 or
		itemType == 11 or itemType == 13 or (itemType > 15 and itemType < 22) then
		return true
	end
	return false
end

function calculateLuckExp(chance, experience)
	-- 3% chance means no luck exp
	if chance > 3000 then
		return 0
	end
	local exp =  math.floor(250 * 0.9947 ^ chance + 0.5)
	local multiplier = experience / 2500
	return exp * multiplier
end

function Monster:onDropLoot(corpse)
	if configManager.getNumber(configKeys.RATE_LOOT) == 0 then
		return
	end

	local mType = self:getType()
	if mType:isRewardBoss() then
		corpse:registerReward()
		return
	end

	local player = Player(corpse:getCorpseOwner())
	if not player or player:getStamina() > 840 then
		local monsterLoot = mType:getLoot()
		local charmBonus = false
		local hazardMsg = false
		local wealthDuplexMsg = false
		if player and mType and mType:raceId() > 0 then
			local charm = player:getCharmMonsterType(CHARM_GUT)
			if charm and charm:raceId() == mType:raceId() then
				charmBonus = true
			end
		end

		local participants = {}
		local modifier = 1
		local vipBoost = 0
		local luckExp = 0
		local luckBoost = 0

		if player then
			participants = { player }
			if configManager.getBoolean(PARTY_SHARE_LOOT_BOOSTS) then
				local party = player:getParty()
				if party and party:isSharedExperienceEnabled() then
					participants = party:getMembers()
					table.insert(participants, party:getLeader())
				end
			end
		end

		local wealthDuplex = Concoction.find(Concoction.Ids.WealthDuplex)
		local wealthDuplexBonus = 0
		local wealthActivators = 0
		if wealthDuplex then
			for i = 1, #participants do
				local participant = participants[i]
				if participant and wealthDuplex:active(player) then
					wealthDuplexBonus = wealthDuplexBonus + wealthDuplex.config.multiplier
					wealthActivators = wealthActivators + 1
				end
			end
		else
			Spdlog.warn("[Monster:onDropLoot] - Could not find WealthDuplex concoction.")
		end
		if wealthActivators > 0 then
			wealthDuplexBonus = wealthDuplexBonus / (wealthActivators ^ 0.8)
			modifier = modifier * (1 + wealthDuplexBonus)
		end

		local vipActivators = 0
		for i = 1, #participants do
			local participant = participants[i]
			if participant:isVip() then
				local boost = configManager.getNumber(configKeys.VIP_BONUS_LOOT)
				boost = ((boost > 100 and 100) or boost) / 100
				vipBoost = vipBoost + boost
				vipActivators	= vipActivators + 1
			end
		end
		if vipActivators > 0 then
			vipBoost = vipBoost / (vipActivators ^ 0.7)
			modifier = modifier * (1 + vipBoost)
		end

		for i = 1, #participants do
			local participant = participants[i]
			luckBoost = luckBoost + participant:getLuckLootBoost()
		end
		luckBoost = luckBoost / ((#participants) ^ 0.7)
		modifier = modifier * (1 + luckBoost)

		for i = 1, #monsterLoot do
			local item = corpse:createLootItem(monsterLoot[i], charmBonus, modifier)
			if item then
				luckExp = luckExp + calculateLuckExp(monsterLoot[i].chance, mType:experience())
			end
			if self:getName():lower() == Game.getBoostedCreature():lower() then
				local itemBoosted = corpse:createLootItem(monsterLoot[i], charmBonus, modifier)
				if itemBoosted then
					luckExp = luckExp + calculateLuckExp(monsterLoot[i].chance, mType:experience())
				end
			end
			if self:hazard() and player then
				local chanceTo = math.random(1, 100)
				if chanceTo <= (2 * player:getHazardSystemPoints() * configManager.getNumber(configKeys.HAZARDSYSTEM_LOOT_BONUS_MULTIPLIER)) then
					local podItem = corpse:createLootItem(monsterLoot[i], charmBonus, preyChanceBoost)
					if podItem and #podItem > 0 then
						luckExp = luckExp + calculateLuckExp(monsterLoot[i].chance, mType:experience())
						hazardMsg = true
					end
				end
			end
		end

		local preyActivators = {}
		if #participants > 0  and player then
			local preyLootPercent = 0
			for i = 1, #participants do
				local participant = participants[i]
				local memberBoost = (participant:getPreyLootPercentage(mType:raceId()) / 1.3 ^ (i - 1))
				table.insert(preyActivators, participant:getName())
				preyLootPercent = preyLootPercent + memberBoost
			end
			-- Runs the loot again if the party gets a chance to loot in the prey
			if preyLootPercent > 0 then
				for _, loot in pairs(monsterLoot) do
					local item = corpse:createLootItem(loot, charmBonus, preyLootPercent / 100)
					if item then
						luckExp = luckExp + calculateLuckExp(loot.chance, mType:experience())
					end
				end
			end

			local boostedMessage
			local isBoostedBoss = self:getName():lower() == (Game.getBoostedBoss()):lower()
			local bossRaceIds = { player:getSlotBossId(1), player:getSlotBossId(2) }
			local isBoss = table.contains(bossRaceIds, mType:bossRaceId()) or isBoostedBoss
			if isBoss and mType:bossRaceId() ~= 0 then
				local bonus
				if mType:bossRaceId() == player:getSlotBossId(1) then
					bonus = player:getBossBonus(1)
				elseif mType:bossRaceId() == player:getSlotBossId(2) then
					bonus = player:getBossBonus(2)
				else
					bonus = configManager.getNumber(configKeys.BOOSTED_BOSS_LOOT_BONUS)
				end

				local items = corpse:getItems(true)
				for i = 1, #items do
					local itemId = items[i]:getId()
					local isValidItem = checkItemType(itemId)
					if isValidItem then
						local realBonus = calculateBonus(bonus)
						for _ = 1, realBonus do
							corpse:addItem(itemId)
							boostedMessage = true
						end
					end
				end
			end

			local contentDescription = corpse:getContentDescription(player:getClient().version < 1200)

			local text = ""
			if self:getName():lower() == (Game.getBoostedCreature()):lower() then
				text = ("Loot of %s: %s (boosted loot)"):format(mType:getNameDescription(), contentDescription)
			elseif boostedMessage then
				text = ("Loot of %s: %s (boss bonus)"):format(mType:getNameDescription(), contentDescription)
			else
				text = ("Loot of %s: %s"):format(mType:getNameDescription(), contentDescription)
			end
			if preyLootPercent > 0 then
				text = text .. " (active prey bonus for " .. table.concat(preyActivators, ", ") .. ")"
			end
			if charmBonus then
				text = text .. " (active charm bonus)"
			end
			if hazardMsg then
				text = text .. " (hazard system)"
			end
			if wealthDuplexBonus > 0  then
				text = text .. (" (active wealth duplex: %d%%)"):format((wealthDuplexBonus - 1) * 100)
			end
			if luckBoost > 0 then
				text = text .. (" (luck bonus: %d%%)"):format(math.floor(luckBoost * 100 + 0.5))
			end
			if vipBoost > 0 then
				text = text .. (" (vip bonus: %d%%)"):format(math.floor(vipBoost * 100 + 0.5))
			end

			for _, member in ipairs(participants) do
				member:addSkillTries(SKILL_LUCK, luckExp)
			end

			local party = player:getParty()
			if party then
				party:broadcastPartyLoot(text)
			else
				player:sendTextMessage(MESSAGE_LOOT, text)
			end
			player:updateKillTracker(self, corpse)
		end
	else
		local text = ("Loot of %s: nothing (due to low stamina)"):format(mType:getNameDescription())
		local party = player:getParty()
		if party then
			party:broadcastPartyLoot(text)
		else
			player:sendTextMessage(MESSAGE_LOOT, text)
		end
	end
end
