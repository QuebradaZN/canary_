---@class Zone
---@method getName
---@method addArea
---@method getPositions
---@method getTiles
---@method getCreatures
---@method getPlayers
---@method getMonsters
---@method getNpcs
---@method getItems

function Zone:randomPosition()
	local positions = self:getPositions()
	local destination = positions[math.random(1, #positions)]
	local tile = destination:getTile()
	while not tile or not tile:isWalkable(false, false, false, false, true) do
		destination = positions[math.random(1, #positions)]
		tile = destination:getTile()
	end
	return destination
end

---@class ZoneEvent
---@field public zone Zone
---@field public onEnter function
---@field public onLeave function
ZoneEvent = {}

setmetatable(ZoneEvent, {
	---@param zone Zone
	__call = function(self, zone)
		local obj = {}
		setmetatable(obj, {__index = ZoneEvent})
		obj.zone = zone
		obj.onEnter = nil
		obj.onLeave = nil
		return obj
end})


function ZoneEvent:register()
	if self.onEnter then
		local onEnter = EventCallback()
		function onEnter.zoneOnCreatureEnter(zone, creature)
			if zone ~= self.zone then return true end
			return self.onEnter(zone, creature)
		end
		onEnter:register()
	end

	if self.onLeave then
		local onLeave = EventCallback()
		function onLeave.zoneOnCreatureLeave(zone, creature)
			if zone ~= self.zone then return true end
			return self.onLeave(zone, creature)
		end
		onLeave:register()
	end
end

function Zone:blockFamiliars()
	local event = ZoneEvent(self)
	function event.onEnter(_zone, creature)
		local monster = creature:getMonster()
		return not (monster and monster:getMaster() and monster:getMaster():isPlayer())
	end
	event:register()
end

function Zone:trapMonsters()
	local event = ZoneEvent(self)
	function event.onLeave(_zone, creature)
		local monster = creature:getMonster()
		return not monster
	end
	event:register()
end
