-- Core settings
-- Note: If you want to use datapack folder canary (custom), put only "data-canary"
-- If you want to use the global datapack folder, put "data-otservbr-global"
-- If "useAnyDatapackFolder" is set to true then you can choose any datapack folder for your server
useAnyDatapackFolder = false
dataPackDirectory = "data-otservbr-global"
-- Don't change this unless you know what you're doing
coreDirectory = "data"
-- Enable/disable development mode
-- NOTE: In development mode, additional logs will be enabled, for deputation and testing purposes.
developmentMode = false

-- Combat settings
-- NOTE: valid values for worldType are: "pvp", "no-pvp" and "pvp-enforced"
worldType = "no-pvp"
hotkeyAimbotEnabled = true
protectionLevel = 7
pzLocked = 20 * 1000
removeChargesFromRunes = true
removeChargesFromPotions = true
removeWeaponAmmunition = true
removeWeaponCharges = true
timeToDecreaseFrags = 24 * 60 * 60 * 1000
whiteSkullTime = 15 * 60 * 1000
stairJumpExhaustion = 500 -- miliseconds
experienceByKillingPlayers = false
expFromPlayersLevelRange = 75
dayKillsToRedSkull = 3
weekKillsToRedSkull = 5
monthKillsToRedSkull = 10
redSkullDuration = 1
blackSkullDuration = 3
orangeSkullDuration = 7

onlyInvitedCanMoveHouseItems = true
onlySubownerCanMoveHouseItems = true
cleanProtectionZones = false

-- Connection Config
-- NOTE: allowOldProtocol can allow login on 10x protocol. (11.00)
-- NOTE: maxPlayers set to 0 means no limit
-- NOTE: MaxPacketsPerSeconds if you change you will be subject to bugs by WPE, keep the default value of 25
ip = "127.0.0.1"
allowOldProtocol = false
bindOnlyGlobalAddress = false
loginProtocolPort = 7171
gameProtocolPort = 7172
statusProtocolPort = 7171
maxPlayers = 0
serverName = "Elysiera"
serverMotd = "Welcome to Elysiera!"
onePlayerOnlinePerAccount = true
statusTimeout = 5 * 1000
replaceKickOnLogin = true
maxPacketsPerSecond = 25
maxItem = 2000
maxContainer = 100

-- Packet Compression
-- Minimize network bandwith and reduce ping
-- Levels: 0 = disabled, 1 = best speed, 9 = best compression
packetCompressionLevel = 6

-- Depot Limit
freeDepotLimit = 2000
premiumDepotLimit = 10000
depotBoxes = 20

-- Prey system
-- NOTE: preyRerollPricePerLevel: Price multiplier in gold coin for rerolling prey list.
-- NOTE: preySelectListPrice: Price to manually select creature on list and to lock prey slot.
-- NOTE: preyBonusRerollPrice: Price to manually reroll bonus type and to enable automatic reroll.
-- NOTE: preyBonusTime: Time in seconds that players will have of prey bonus.
-- NOTE: preyFreeRerollTime: Time in seconds that players will have to wait to get a new free prey list.
preySystemEnabled = true
preyFreeThirdSlot = false
preyRerollPricePerLevel = 200
preySelectListPrice = 5
preyBonusRerollPrice = 1
preyBonusTime = 2 * 60 * 60
preyFreeRerollTime = 10 * 60 * 60

-- Task hunting system
-- NOTE: taskHuntingLimitedTasksExhaust: Time to wait to select a new creature on the task hunting slot after claiming the reward.
-- NOTE: taskHuntingRerollPricePerLevel: Price multiplier in gold coin for rerolling task hunting list.
-- NOTE: taskHuntingFreeRerollTime: Time in seconds that players will have to wait to get a new free task hunting list.
taskHuntingSystemEnabled = true
taskHuntingFreeThirdSlot = false
taskHuntingLimitedTasksExhaust = 10 * 60 * 60
taskHuntingRerollPricePerLevel = 200
taskHuntingSelectListPrice = 5
taskHuntingBonusRerollPrice = 1
taskHuntingFreeRerollTime = 10 * 60 * 60

-- Forge system
-- NOTE: forgeAmountMultiplier, amount dusts multiplies of influenced monsters, default 3
-- NOTE: forgeMinSlivers, min slivers from influenced monsters
-- NOTE: forgeMaxSlivers, max slivers from influenced monsters
-- NOTE: forgeInfluencedLimit, limit of influenced monsters that will be created in interval type and time
-- NOTE: forgeFiendishLimit, limit of diabolic monsters that will be created in interval type and time, less than forgeInfluencedLimit
-- NOTE: forgeFiendishIntervalType: "hour", "minute" or "second"
forgeMaxItemTier = 10
forgeCostOneSliver = 20
forgeSliverAmount = 3
forgeCoreCost = 50
forgeMaxDust = 225
forgeFusionCost = 100
forgeTransferCost = 100
forgeBaseSuccessRate = 50
forgeBonusSuccessRate = 15
forgeTierLossReduction = 50
forgeAmountMultiplier = 3
forgeMinSlivers = 3
forgeMaxSlivers = 7
forgeInfluencedLimit = 300
forgeFiendishLimit = 3
forgeFiendishIntervalType = "hour"
forgeFiendishIntervalTime = "1"

-- Bestiary & Bosstiary system
-- NOTE: bestiaryKillMultiplier, multiplier value of monster killed, default 1
-- NOTE: bosstiaryKillMultiplier, multiplier value of boss killed, default 1
bestiaryKillMultiplier = 2
bosstiaryKillMultiplier = 2
bestiaryRateCharmShopPrice  = 1.0
boostedBossSlot = true
boostedBossLootBonus = 250
boostedBossKillBonus = 5

-- Hazard system
toogleHazardSystem = true
hazardCriticalInterval = 2000
hazardCriticalMultiplier = 25
hazardDamageMultiplier = 200
hazardDodgeMultiplier = 85
hazardPodsDropMultiplier = 87
hazardPodsTimeToDamage = 2000
hazardPodsTimeToSpawn = 4000
hazardExpBonusMultiplier = 2
hazardLootBonusMultiplier = 2
hazardPodsDamage = 5
hazardSpawnPlunderMultiplier = 25

-- Tibiadrome concoctions
partyShareLootBoosts = true
tibiadromeConcoctionCooldown = 10 * 60 * 60 -- 24 hours
tibiadromeConcoctionDuration = 60 * 60 -- 1 hour
tibiadromeConcoctionTickType = "experience" -- "online" | "experience"

-- Familiar system
-- NOTE: the time will be divided by 2 to get half the value, the familiar lasts 15 minutes by default and the cooldown of the spell is 30 minutes
-- Only change it here if you know what you are doing or to make testing easier with familiars
familiarTime = 30

-- NOTE: Access only for Premium Account
onlyPremiumAccount = false

-- Customs
-- NOTE: weatherRain = true, activates weather raining effects
-- NOTE: thunderEffect = true, activates thunder effects
-- NOTE: allConsoleLog = true, show all message logs
-- NOTE: stashMoving = true, stow an container inside your stash
-- NOTE: depotChest, the non-stackable items will be moved to the selected depot chest(I - XVIII).
-- NOTE: autoBank = true, the dropped coins from monsters will be automatically deposited to your bank account.
-- NOTE: toggleGoldPouchAllowAnything will allow players to move items or gold to gold pouch
-- NOTE: toggleServerIsRetroPVP will make this server as retro, setting PARTY_PROTECTION and ADVANCED_SECURE_MODE to 0
-- NOTE: toggleTravelsFree will make all travels from boat free
weatherRain = false
thunderEffect = false
allConsoleLog = false
stashMoving = false
depotChest = 4
autoLoot = true
autoBank = true
toggleGoldPouchAllowAnything = true
toggleGoldPouchQuickLootOnly = true
toggleServerIsRetroPVP = false
toggleTravelsFree = false

-- Teleport summon
-- Set to true will never remove the summon
teleportSummons = false

-- Stamina in Trainers
staminaTrainer = false
staminaTrainerDelay = 5
staminaTrainerGain = 1
-- Stamina in PZ
staminaPz = true
staminaOrangeDelay = 1
staminaGreenDelay = 5
staminaPzGain = 1
-- Max players allowed on a dummy.
maxAllowedOnADummy = 12

-- Save interval per time
-- NOTE: toggleSaveInterval: true = enable the save interval, false = disable the save interval
-- NOTE: saveIntervalType: "minute", "second" or "hour"
-- NOTE: toggleSaveIntervalCleanMap: true = enable the clean map, false = disable the clean map
-- NOTE: saveIntervalTime: time based on what was set in "saveIntervalType"
toggleSaveInterval = true
saveIntervalType = "hour"
toggleSaveIntervalCleanMap = false
saveIntervalTime = 1

-- Imbuement
toggleImbuementShrineStorage = false

-- Free quests
-- Add quest access to player when logging in
-- NOTE: Only quests that are in the "freequests.lua" script table will work
-- toggleFreeQuest = enable/disable the system
-- freeQuestStage = if you add more quests to the table, change this value to run freeQuest again
toggleFreeQuest = true
freeQuestStage = 7

-- Deaths
-- NOTE: Leave deathLosePercent as -1 if you want to use the default
-- death penalty formula. For the old formula, set it to 10. For
-- no skill/experience loss, set it to 0.
deathLosePercent = -1

-- Houses
-- NOTE: set housePriceEachSQM to -1 to disable the ingame buy house functionality
-- NOTE: set houseBuyLevel to 0 to disable the min level purchase functionality.
-- Periods: daily/weekly/monthly/yearly/never
housePriceEachSQM = 1000
houseRentPeriod = "never"
houseOwnedByAccount = false
houseBuyLevel = 100

-- Item Usage
timeBetweenActions = 200
timeBetweenExActions = 1000

-- Push
-- NOTE: pushDelay: interval for every push
-- NOTE: pushDistanceDelay: delay for every distance push
-- NOTE: pushWhenAttacking: true = enable the push during attack, false = disable the push during attack
pushDelay = 1000
pushDistanceDelay = 1500
pushWhenAttacking = false

-- Map
-- NOTE: set mapName WITHOUT .otbm at the end
-- NOTE: If toggleDownloadMap if false, then the mapDownloadUrl will not be used
-- NOTE: If a map with the name already exists in the world folder, the map will not be downloaded even if the toggleDownloadMap is true
toggleDownloadMap = true
mapName = "otservbr"
mapDownloadUrl = "https://github.com/opentibiabr/canary/releases/download/v2.6.1/otservbr.otbm"
mapAuthor = "OpenTibiaBR"

-- Party List limitations
-- max distance in which players in party list are visible
-- NOTE partyListMaxDistance set to 0 means no limit
partyListMaxDistance = 30

-- Custom Map
-- NOTE: toggleMapCustom set to true will load all maps in custom map folder
toggleMapCustom = true

-- Market
marketOfferDuration = 30 * 24 * 60 * 60
premiumToCreateMarketOffer = true
checkExpiredMarketOffersEachMinutes = 60
maxMarketOffersAtATimePerPlayer = 100

-- Session Auth
authType = "session" -- 'session' | 'password'
resetSessionsOnStartup = false

-- Misc.
-- NOTE: experienceDisplayRates: set to false to ignore exp rate or true to include exp rate
allowChangeOutfit = true
freePremium = true
kickIdlePlayerAfterMinutes = 15
maxMessageBuffer = 4
emoteSpells = false
allowWalkthrough = true
coinPacketSize = 10
coinImagesURL = "https://elysiera.com/images/store/"
classicAttackSpeed = false
showScriptsLogInConsole = false
-- configure maximum value of critical imbuement
criticalChance = 50
inventoryGlowOnFiveBless = 100
adventurersBlessingLevel = 100
experienceDisplayRates = false

-- Global server Save
-- NOTE: globalServerSaveNotifyDuration in minutes
globalServerSaveNotifyMessage = true
globalServerSaveNotifyDuration = 5
globalServerSaveCleanMap = false
globalServerSaveClose = false
globalServerSaveShutdown = true
globalServerSaveTime = "23:55:00"

-- Sort loot by chance, most rare items drop first
-- it is good to be setted when you have a higher
-- rateLoot to avoid losing all rare items when
-- the corpse size is less than the total of loots
-- the monster can drop
sortLootByChance = true

-- Rates
-- NOTE: rateExp, rateSkill and rateMagic is used when 'rateUseStages = false' - or a fallback only
-- To configure rates see file data/stages.lua
rateUseStages = true
rateExp = 1
rateSkill = 1
rateLoot = 3
rateMagic = 1
rateSpawn = 2

-- Killing in the name of Quest
rateKillingInTheNameOfPoints = 1

-- Today regeneration condition over an loop every 1 second,
-- So values which should regenerated less then 1 second or won't will work
rateHealthRegen = 10.0
rateHealthRegenSpeed = 5.0
rateManaRegen = 10.0
rateManaRegenSpeed = 5.0
rateSoulRegen = 1.0
rateSoulRegenSpeed = 1.0

rateSpellCooldown = 1.0
rateAttackSpeed = 1.0
rateOfflineTrainingSpeed = rateAttackSpeed
rateExerciseTrainingSpeed = rateAttackSpeed

-- Monster rates
rateMonsterHealth = 1.5
rateMonsterAttack = 1.2
rateMonsterDefense = 1.0

-- Boss rates
rateBossHealth = 1.0
rateBossAttack = 1.2
rateBossDefense = 1.0

-- Monsters
deSpawnRange = 2
deSpawnRadius = 50
minElementalResistance = -200
maxElementalResistance = 30
maxDamageReflection = 10

-- Stamina
staminaSystem = true

-- Scripts
warnUnsafeScripts = true
convertUnsafeScripts = true

-- Startup
-- NOTE: defaultPriority only works on Windows and sets process
-- priority, valid values are: "normal", "above-normal", "high"
defaultPriority = "high"
startupDatabaseOptimization = true

-- Status server information
ownerName = "Ardent"
ownerEmail = "ardent@elysiera.com"
url = "https://elysiera.com/"
location = "North America"

-- Sends Discord webhook notifications on startup, raids and shutdown.
-- The URL layout is https://discord.com/api/webhooks/:id/:token
-- Leave empty if you wish to disable.
discordWebhookURL = ""

-- Loyalty system
loyaltyEnabled = true
loyaltyPointsPerCreationDay = 3
loyaltyPointsPerPremiumDaySpent = 3
loyaltyPointsPerPremiumDayPurchased = 6
loyaltyBonusPercentageMultiplier = 2.0

-- VIP System
-- NOTE: set vipSystemEnabled to true to enable the vip system functionalities (this overrides premium checks)
-- NOTE: vipBonusExp = 0 is deactivated, active changing value between 1 and 100 (percent xp bonus to gain. ex: 3 = 3%, 30 = 30%)
-- NOTE: vipBonusLoot = 0 is deactivated, active changing value between 1 and 100 (percent loot bonus to gain. ex: 3 = 3%, 30 = 30%)
-- NOTE: vipBonusSkill = 0 is deactivated, active changing value between 1 and 100 (percent skill bonus to gain. ex: 3 = 3%, 30 = 30%)
-- NOTE: vipStayOnline = when this config is activated, players vip will be kicked after 'kickIdlePlayerAfterMinutes' config minutes too
-- NOTE: vipAutoLootVipOnly = activates only vip to get automatic loot, config 'autoLoot' need to be enabled, for this config works
vipSystemEnabled = true
vipBonusExp = 20
vipBonusLoot = 20
vipBonusSkill = 20
vipAutoLootVipOnly = false
vipStayOnline = true
vipFamiliarTimeCooldownReduction = 15 * 60 * 1000

-- Runic
runicMultiplier = 1/500

-- Wheel of destiny system
-- NOTE: set wheelSystemEnabled = false to disable the wheel of destiny
-- NOTE: only the wheel points are modified, all other data is on the client executable and cannot be modified
wheelSystemEnabled = true
wheelPointsPerLevel = 1

bossCooldownTime = 10 * 60 * 60 -- 10 hours
