local playerLogin = CreatureEvent("VipLogin")

function playerLogin.onLogin(player)
	if configManager.getBoolean(configKeys.VIP_SYSTEM_ENABLED) then
		local wasVip = player:getStorageValue(Storage.VipSystem.IsVip) == 1
		if wasVip and not player:isVip() then player:onRemoveVip() end
		if player:isVip() then player:onAddVip(player:getVipDays(), wasVip) end
		CheckPremiumAndPrint(player, MESSAGE_LOGIN)
	end
	return true
end

playerLogin:register()
