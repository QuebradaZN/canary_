function onUpdateDatabase()
	Spdlog.info("Updating database to version 34 (add primary keys)")
	db.query([[
		ALTER TABLE `player_prey`
		ADD PRIMARY KEY (`player_id`, `slot`);
	]])
	db.query([[
		ALTER TABLE `player_taskhunt`
		ADD PRIMARY KEY (`player_id`, `slot`);
	]])
	db.query([[
		ALTER TABLE `player_items`
		ADD PRIMARY KEY (`player_id`, `sid`);
	]])
	db.query([[
		ALTER TABLE `player_spells`
		ADD PRIMARY KEY (`player_id`, `name`);
	]])
	db.query([[
		ALTER TABLE `player_stash`
		ADD PRIMARY KEY (`player_id`, `item_id`);
	]])
	return true
end
