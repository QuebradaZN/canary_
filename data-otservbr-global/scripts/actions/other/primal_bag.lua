local rewards = {
	[VOCATION.BASE_ID.KNIGHT] = {
		{ id = 39147, name = "spiritthorn armor" },
		{ id = 39148, name = "spiritthorn helmet" },
		{ id = 39177, name = "charged spiritthorn ring" },
	},
	[VOCATION.BASE_ID.PALADIN] = {
		{ id = 39149, name = "alicorn headguard" },
		{ id = 39150, name = "alicorn quiver" },
		{ id = 39180, name = "charged alicorn ring" },
	},
	[VOCATION.BASE_ID.SORCERER] = {
		{ id = 39151, name = "arcanomancer regalia" },
		{ id = 39152, name = "arcanomancer folio" },
		{ id = 39183, name = "charged arcanomancer sigil" },
	},
	[VOCATION.BASE_ID.DRUID] = {
		{ id = 39153, name = "arboreal crown" },
		{ id = 39154, name = "arboreal tome" },
		{ id = 39186, name = "charged arboreal ring" }
	},
}

local primalBag = Action()

function primalBag.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then return false end
	local vocationRewards = rewards[player:getVocation():getBaseId()]

	local randId = math.random(1, #vocationRewards)
	local rewardItem = vocationRewards[randId]

	player:addItem(rewardItem.id, 1)
	item:remove(1)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You received one ' .. rewardItem.name .. '.')
	return true
end

primalBag:id(39546)
primalBag:register()
