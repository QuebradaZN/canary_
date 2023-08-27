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

function Zone:sendTextMessage(...)
	local players = self:getPlayers()
	for _, player in ipairs(players) do
		player:sendTextMessage(...)
	end
end

function Zone:countMonsters(name)
	local count = 0
	for _, monster in ipairs(self:getMonsters()) do
		if not name or monster:getName():lower() == name:lower() then
			count = count + 1
		end
	end
	return count
end

function Zone:countPlayers(notFlag)
	local players = self:getPlayers()
	local count = 0
	for _, player in ipairs(players) do
		if notFlag then
			if not player:hasGroupFlag(notFlag) then
				count = count + 1
			end
		else
			count = count + 1
		end
	end
	return count
end

function Zone:isInZone(position)
	local zones = position:getZones()
	if not zones then return false end
	for _, zone in ipairs(zones) do
		if zone == self then
			return true
		end
	end
	return false
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
		setmetatable(obj, { __index = ZoneEvent })
		obj.zone = zone
		obj.onEnter = nil
		obj.onLeave = nil
		return obj
	end
})

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
