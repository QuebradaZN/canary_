local rewards = {
	[VOCATION.BASE_ID.KNIGHT] = {
		{ id = 34394, name = "cobra boots"},
		{ id = 34395, name = "cobra club"},
		{ id = 34396, name = "cobra axe"},
		{ id = 34397, name = "cobra hood"},
		{ id = 34398, name = "cobra sword"},
		{ id = 34154, name = "lion shield" },
		{ id = 34155, name = "lion longsword" },
		{ id = 34156, name = "lion spanglehelm" },
		{ id = 34157, name = "lion plate" },
		{ id = 34158, name = "lion amulet" },
		{ id = 28715, name = "falcon coif" },
		{ id = 28719, name = "falcon plate" },
		{ id = 28720, name = "falcon greaves" },
		{ id = 28721, name = "falcon shield" },
		{ id = 28722, name = "falcon escutcheon" },
		{ id = 28722, name = "falcon longsword" },
		{ id = 28722, name = "falcon battleaxe" },
		{ id = 28722, name = "falcon mace" },
	},
	[VOCATION.BASE_ID.PALADIN] = {
		{ id = 34393, name = "cobra crossbow" },
		{ id = 34150, name = "lion longbow" },
		{ id = 34156, name = "lion spanglehelm" },
		{ id = 34158, name = "lion amulet" },
		{ id = 28715, name = "falcon coif" },
		{ id = 28718, name = "falcon bow" },
		{ id = 28720, name = "falcon greaves" },
	},
	[VOCATION.BASE_ID.SORCERER] = {
		{ id = 34399, name = "cobra wand"},
		{ id = 34403, name = "amulet of theurgy"},
		{ id = 34152, name = "lion wand" },
		{ id = 34153, name = "lion spellbook" },
		{ id = 34158, name = "lion amulet" },
		{ id = 28714, name = "falcon circlet" },
		{ id = 28717, name = "falcon wand" },
	},
	[VOCATION.BASE_ID.DRUID] = {
		{ id = 34400, name = "cobra rod"},
		{ id = 34403, name = "amulet of theurgy"},
		{ id = 34151, name = "lion rod" },
		{ id = 34153, name = "lion spellbook" },
		{ id = 34158, name = "lion amulet" },
		{ id = 28714, name = "falcon circlet" },
		{ id = 28716, name = "falcon rod" },
	},
}

local surpriseCube = Action()

function surpriseCube.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then return false end
	local vocationRewards = rewards[player:getVocation():getBaseId()]

	local randId = math.random(1, #vocationRewards)
	local rewardItem = vocationRewards[randId]

	player:addItem(rewardItem.id, 1)
	item:remove(1)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You received a ' .. rewardItem.name .. '.')
	return true
end

surpriseCube:id(23488)
surpriseCube:register()
