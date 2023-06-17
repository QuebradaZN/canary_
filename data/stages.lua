-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 9,
		multiplier = 20
	},
	{
		minlevel = 10,
		maxlevel = 29,
		multiplier = 50
	},
	{
		minlevel = 30,
		maxlevel = 59,
		multiplier = 150
	},
	{
		minlevel = 60,
		maxlevel = 99,
		multiplier = 120
	},
	{
		minlevel = 100,
		maxlevel = 149,
		multiplier = 100
	},
	{
		minlevel = 150,
		maxlevel = 199,
		multiplier = 80
	},
	{
		minlevel = 200,
		maxlevel = 249,
		multiplier = 60
	},
	{
		minlevel = 250,
		maxlevel = 299,
		multiplier = 40
	},
	{
		minlevel = 300,
		maxlevel = 399,
		multiplier = 20
	},
	{
		minlevel = 400,
		maxlevel = 499,
		multiplier = 15
	},
	{
		minlevel = 500,
		maxlevel = 699,
		multiplier = 10
	},
	{
		minlevel = 700,
		maxlevel = 999,
		multiplier = 5
	},
	{
		minlevel = 1000,
		multiplier = 3
	},
}

skillsStages = {
	{
		minlevel = 10,
		maxlevel = 60,
		multiplier = 40
	}, {
		minlevel = 61,
		maxlevel = 80,
		multiplier = 30
	}, {
		minlevel = 81,
		maxlevel = 110,
		multiplier = 15
	}, {
		minlevel = 111,
		maxlevel = 125,
		multiplier = 10
	}, {
		minlevel = 126,
		multiplier = 5
	}
}

magicLevelStages = {
	{
		minlevel = 0,
		maxlevel = 60,
		multiplier = 6
	}, {
		minlevel = 61,
		maxlevel = 80,
		multiplier = 15
	}, {
		minlevel = 81,
		maxlevel = 100,
		multiplier = 10
	}, {
		minlevel = 101,
		multiplier = 5
	}
}
