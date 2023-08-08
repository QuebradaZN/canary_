local function getItemsInContainer(cont, sep)
	local text = ""
	local tsep = ""
	local count = ""
	for i = 1, sep do
		tsep = tsep .. "-"
	end
	tsep = tsep .. ">"
	for i = 0, getContainerSize(cont.uid) - 1 do
		local item = getContainerItem(cont.uid, i)
		if not isContainer(item.uid) then
			if item.type > 0 then
				count = "(" .. item.type .. "x)"
			else
				count = ""
			end
			text = text .. "\n" .. tsep .. ItemType(item.itemid):getName() .. " " .. count
		else
			if getContainerSize(item.uid) > 0 then
				text = text .. "\n" .. tsep .. ItemType(item.itemd):getName()
				text = text .. getItemsInContainer(item, sep + 2)
			else
				text = text .. "\n" .. tsep .. ItemType(item.itemid):getName()
			end
		end
	end
	return text
end

local spy = TalkAction("/spy")

function spy.onSay(cid, words, param)
	local player = Player(cid)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	-- create log
	logCommand(player, words, param)

	if (param == "") then
		player:sendCancelMessage("Write the name of the character to be spyed.")
		return false
	end

	local slotName = { "Helmet", "Amulet", "Backpack", "Armor", "Right Hand", "Left Hand", "Legs", "Boots", "Ring", "Arrow" }
	local target = Player(param)

	if target and target:isPlayer() then
		local text = "Equipments of " .. Creature(target):getName()
		for i = 1, 10 do
			text = text .. "\n\n"
			local item = target:getSlotItem(i)
			if item and item.itemid > 0 then
				if isContainer(item.uid) then
					text = text .. slotName[i] .. ": " .. ItemType(item.itemid):getName() .. getItemsInContainer(item, 1)
				else
					local count = ""
					if item.type > 0 then
						count = "(" .. item.type .. "x)"
					else
						count = ""
					end
					text = text .. slotName[i] .. ": " .. ItemType(item.itemid):getName() .. " " .. count
				end
			else
				text = text .. slotName[i] .. ": Empty"
			end
		end
		player:showTextDialog(6528, text)
	else
		player:sendCancelMessage("This player is offline or doesn't exist.")
	end
	return false
end

spy:separator(" ")
spy:register()