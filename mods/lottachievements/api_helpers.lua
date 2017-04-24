function lottachievements.tbv(tb,value,default)
	if not default then
		default = {}
	end
	if not tb or type(tb) ~= "table" then
		if not value then
			value = "[NULL]"
		end
		minetest.log("error", "lottachievements.tbv - table "..dump(value).." is null, or not a table! Dump: "..dump(tb))
		return
	end
	if not value then
		error("[ERROR] lottachievements.tbv was not used correctly!\n"..
			"Value: '"..dump(value).."'\n"..
			"Dump:"..dump(tb))
		return
	end
	if not tb[value] then
		tb[value] = default
	end
end

function lottachievements.assertPlayer(playern)
	lottachievements.tbv(lottachievements.players, playern)
	lottachievements.tbv(lottachievements.players[playern], "name", playern)
	lottachievements.tbv(lottachievements.players[playern], "unlocked")
	lottachievements.tbv(lottachievements.players[playern], "place")
	lottachievements.tbv(lottachievements.players[playern], "count")
	lottachievements.tbv(lottachievements.players[playern], "craft")
	lottachievements.tbv(lottachievements.players[playern], "eat")
	lottachievements.tbv(lottachievements.players[playern], "deaths", 0)
	lottachievements.tbv(lottachievements.players[playern], "joins", 0)
	lottachievements.tbv(lottachievements.players[playern], "chats", 0)
end

function lottachievements.player(name)
	return lottachievements.players[name]
end

function lottachievements._order_lottachievements(name)
	local done = {}
	local retval = {}
	local retval2 = {}
	local player = lottachievements.player(name)
	local c = 0
	if player and player.unlocked then
		for _,got in pairs(player.unlocked) do
			if lottachievements.def[got] then
				done[got] = true
				table.insert(retval,{name=got,got=true})
			end
		end
	end
	table.sort(retval, function(a,b)
		return (lottachievements.def[b.name].id > lottachievements.def[a.name].id)
	end)
	for _,def in pairs(lottachievements.def) do
		if not done[def.name] then
			table.insert(retval2,{name=def.name,got=false})
		end
	end
	table.sort(retval2, function(a,b)
		return (lottachievements.def[b.name].id > lottachievements.def[a.name].id)
	end)
	for i,v in pairs(retval2) do
		table.insert(retval,v)
	end
	return retval
end

function lottachievements.completed_achievements(name)
	local completed = {}
	local player = lottachievements.player(name)
	if player and player.unlocked then
		for _, got in pairs(player.unlocked) do
			if lottachievements.def[got] then
				completed[got] = true
			end
		end
	end
	return completed
end
