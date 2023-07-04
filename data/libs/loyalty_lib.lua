local loyaltySystem = {
	enable = configManager.getBoolean(LOYALTY_SYSTEM_ENABLED),
	titles = {
		{ name = "Novice of Elysiera", points = 180 },
		{ name = "Apprentice of Elysiera", points = 360 },
		{ name = "Journeyman of Elysiera", points = 540 },
		{ name = "Adept of Elysiera", points = 720 },
		{ name = "Skilled of Elysiera", points = 900 },
		{ name = "Seasoned of Elysiera", points = 1080 },
		{ name = "Veteran of Elysiera", points = 1260 },
		{ name = "Elite of Elysiera", points = 1440 },
		{ name = "Master of Elysiera", points = 1620 },
		{ name = "Grandmaster of Elysiera", points = 1800 },
		{ name = "Champion of Elysiera", points = 1980 },
		{ name = "Hero of Elysiera", points = 2160 },
		{ name = "Legendary of Elysiera", points = 2340 },
		{ name = "Mythic of Elysiera", points = 2520 },
		{ name = "Divine of Elysiera", points = 2700 },
		{ name = "Eternal of Elysiera", points = 2880 },
		{ name = "Ascendant of Elysiera", points = 3060 },
		{ name = "Immortal of Elysiera", points = 3240 },
		{ name = "Transcendent of Elysiera", points = 3420 },
		{ name = "Supreme of Elysiera", points = 3600 },
	},
	bonus = {
		{minPoints = 180, percentage = 2.5},
		{minPoints = 360, percentage = 5},
		{minPoints = 540, percentage = 7.5},
		{minPoints = 720, percentage = 10},
		{minPoints = 900, percentage = 12.5},
		{minPoints = 1080, percentage = 15},
		{minPoints = 1260, percentage = 17.5},
		{minPoints = 1440, percentage = 20},
		{minPoints = 1620, percentage = 22.5},
		{minPoints = 1800, percentage = 25},
		{minPoints = 1980, percentage = 27.5},
		{minPoints = 2160, percentage = 30},
		{minPoints = 2340, percentage = 32.5},
		{minPoints = 2520, percentage = 35},
		{minPoints = 2700, percentage = 37.5},
		{minPoints = 2880, percentage = 40},
		{minPoints = 3060, percentage = 42.5},
		{minPoints = 3240, percentage = 45},
		{minPoints = 3420, percentage = 47.5},
		{minPoints = 3600, percentage = 50},
	},
	messageTemplate = "Due to your long-term loyalty to " .. SERVER_NAME .. " you currently benefit from a ${bonusPercentage}% bonus on all of your skills. (You have ${loyaltyPoints} loyalty points)"
}

function Player.initializeLoyaltySystem(self)
	if not loyaltySystem.enable then
		return true
	end

	-- Title
	local title = ""
	for _, titleTable in ipairs(loyaltySystem.titles) do
		if (self:getLoyaltyPoints() > titleTable.points) then
			title = titleTable.name
		end
	end
	self:setLoyaltyTitle(title)

	-- Bonus
	local bonusPercentage = 0
	for _, bonusTable in ipairs(loyaltySystem.bonus) do
		if self:getLoyaltyPoints() >= bonusTable.minPoints then
			bonusPercentage = bonusTable.percentage
		end
	end

	self:setLoyaltyBonus(bonusPercentage * configManager.getFloat(configKeys.LOYALTY_BONUS_PERCENTAGE_MULTIPLIER))

	if self:getLoyaltyBonus() ~= 0 then
		self:sendTextMessage(MESSAGE_STATUS, string.formatNamed(loyaltySystem.messageTemplate, { bonusPercentage = self:getLoyaltyBonus(), loyaltyPoints = self:getLoyaltyPoints()}))
	end

	return true
end
