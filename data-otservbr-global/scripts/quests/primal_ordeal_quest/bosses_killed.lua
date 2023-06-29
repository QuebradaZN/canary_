local bosses = {
	["magma bubble"] = {storage = Storage.Quest.U12_90.PrimalOrdeal.Bosses.MagmaBubbleKilled},
	["the primal menace"] = {storage = Storage.Quest.U12_90.PrimalOrdeal.Bosses.ThePrimalMenaceKilled},
}

local bossesPrimeOrdeal = CreatureEvent("PrimeOrdealKill")
function bossesPrimeOrdeal.onKill(creature, target)
	local targetMonster = target:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end
	local bossConfig = bosses[targetMonster:getName():lower()]
	if not bossConfig then
		return true
	end
	for key, value in pairs(targetMonster:getDamageMap()) do
		local attackerPlayer = Player(key)
		if attackerPlayer then
			if bossConfig.storage then
				attackerPlayer:setStorageValue(bossConfig.storage, 1)
			end
		end
	end
	return true
end
bossesPrimeOrdeal:register()
