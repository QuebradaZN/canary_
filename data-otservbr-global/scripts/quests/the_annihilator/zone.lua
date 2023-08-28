local zone = Zone("annihilator")

zone:addArea(Position(33217, 31654, 13), Position(33238, 31661, 13))

local event = ZoneEvent(zone)
function event.beforeEnter(_zone, creature)
	local monster = creature:getMonster()
	return not (monster and monster:getMaster() and monster:getMaster():isPlayer())
end

event:register()
