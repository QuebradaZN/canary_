local callback = EventCallback()

local function calculateLuckExp(chance, experience)
	-- 3% chance means no luck exp
	if chance > 3000 then
		return 0
	end
	local exp =  math.floor(250 * 0.9947 ^ chance + 0.5)
	local multiplier = experience / 2500
	return exp * multiplier
end

local function itemListContains(itemList, itemId)
	for _, item in ipairs(itemList) do
		if item:getId() == itemId then
			return true
		end
	end
	return false
end

function callback.monsterPostDropLoot(monster, corpse)
	local player = Player(corpse:getCorpseOwner())
	if not player then return end
	if player:getStamina() <= 840 then return end
	local mType = monster:getType()
	if not mType then return end

	local participants = { player }
	local party = player:getParty()
	if party and party:isSharedExperienceEnabled() then
		participants = party:getMembers()
		table.insert(participants, party:getLeader())
	end

	local droppedItems = corpse:getItems()
	local luckExp = 0
	local possibleLoot = mType:getLoot()
	for _, item in ipairs(possibleLoot) do
		if itemListContains(droppedItems, item.itemId) then
			luckExp = luckExp + calculateLuckExp(item.chance, mType:experience())
		end
	end

	for _, participant in ipairs(participants) do
		if participant then
			Spdlog.info("adding luck exp: " .. luckExp .. " to " .. participant:getName())
			participant:addSkillTries(SKILL_LUCK, luckExp)
		end
	end
end

callback:register()
