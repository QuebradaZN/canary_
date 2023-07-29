local callback = EventCallback()

function callback.monsterOnDropLoot(monster, corpse)
	if monster:getName():lower() ~= Game.getBoostedCreature():lower() then return end
	local player = Player(corpse:getCorpseOwner())
	if player and player:getStamina() <= 840 then return end
	local mType = monster:getType()
	if not mType then return end

	local factor = player and player:calculateLootFactor(monster).factor or 1.0
	local msgSuffix = " (boosted loot)"
	corpse:addLoot(mType:generateLootRoll({ factor = factor, gut = false, }, {}))

	local existingSuffix = corpse:getAttribute(ITEM_ATTRIBUTE_LOOTMESSAGE_SUFFIX) or ""
	corpse:setAttribute(ITEM_ATTRIBUTE_LOOTMESSAGE_SUFFIX, existingSuffix .. msgSuffix)
end

callback:register()
