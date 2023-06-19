local playerfile = "data-otservbr-global/scripts/talkactions/player_commands.txt"
local godfile = "data-otservbr-global/scripts/talkactions/god_commands.txt"

local playercommands = TalkAction("!commands")
function playercommands.onSay(player, words, param)
  local commands = ""
  for line in io.lines(playerfile) do
    commands = commands..line..'\n'
  end
  player:showTextDialog(9680, commands)
  return true
end
playercommands:register()

local godcommands = TalkAction("/commands")
function godcommands.onSay(player, words, param)
  local commands = ""
  if not player:getGroup():getAccess() then
    return true
  end

  if player:getAccountType() < ACCOUNT_TYPE_GOD then
    return false
  end
  for line in io.lines(godfile) do
    commands = commands..line..'\n'
  end
  player:showTextDialog(9680, commands)
  return true
end
godcommands:register()
