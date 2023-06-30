Chain = {}


function Chain.combat(player, initialTarget, combat, maxCreatures, maxDistance, animation, firstAnimation)
	local range = math.max(6, maxDistance * (maxCreatures + 1))
	local creatures = Game.getSpectators(player:getPosition(), false, false, range, range, range, range)
	local monsters = {}
	for _, creature in pairs(creatures) do
		if creature:isMonster() then
			table.insert(monsters, creature)
		end
	end
	local visited = { [initialTarget:getId()] = true }

	local function recursiveChain(target, previousTarget)
		if maxCreatures <= 0 then
			return 0
		end

		if not target then
			return maxCreatures
		end

		if previousTarget and animation then
			previousTarget:getPosition():sendDistanceEffect(target:getPosition(), animation)
		end
		if not combat:execute(player, Variant(target:getId())) then
			return nil
		end

		maxCreatures = maxCreatures - 1

		local eligibleMonsters = {}

		for index, monster in pairs(monsters) do
			local dist = target:getPosition():getDistance(monster:getPosition())
			if not visited[monster:getId()] and dist <= maxDistance then
				table.insert(eligibleMonsters, { monster = monster, distance = dist })
			end
		end

		table.sort(eligibleMonsters, function(a, b) return a.distance < b.distance end)

		for index, m in pairs(eligibleMonsters) do
			if not visited[m.monster:getId()] then
				visited[m.monster:getId()] = true
				maxCreatures = recursiveChain(m.monster, target)
			end
			if maxCreatures == nil or maxCreatures == 0 then
				return maxCreatures
			end
		end

		return maxCreatures
	end

	return recursiveChain(initialTarget, firstAnimation and player or nil) ~= nil
end
