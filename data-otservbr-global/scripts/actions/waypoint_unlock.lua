local waypointUnlock = Action()

function waypointUnlock.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	player:addWaypointModal(function()
		item:remove()
	end)
	return true
end

waypointUnlock:id(12540)
waypointUnlock:register()
