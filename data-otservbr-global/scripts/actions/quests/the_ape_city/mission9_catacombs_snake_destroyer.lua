local theApeMiss9 = Action()
function theApeMiss9.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid ~= 4850 then
		return false
	end

	if player:getStorageValue(Storage.TheApeCity.Questline) ~= 17
			or player:getStorageValue(Storage.TheApeCity.SnakeDestroyer) == 1 then
		return false
	end

	player:setStorageValue(Storage.TheApeCity.SnakeDestroyer, 1)
	item:remove()
	target:transform(4851)
	target:decay()
	toPosition:sendMagicEffect(CONST_ME_FIREAREA)
	return true
end

theApeMiss9:id(4835)
theApeMiss9:register()
