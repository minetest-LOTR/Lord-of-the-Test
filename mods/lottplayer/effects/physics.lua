
lottplayer.persist_base = {speed=0, jump=0, gravity=0, sneak=nil, sneak_glitch=nil}
lottplayer.temp_base = {speed=0, speed_time=0, jump=0, jump_time=0, gravity=0, gravity_time=0, sneak=nil, sneak_time=0, sneak_glitch=nil, sneak_glitch_time=0}
lottplayer.addit_base = {}

-- Base Physics
lottplayer.base_physics = function(player, elist)
	local meta = player:get_meta()
	meta:set_string("lottplayer:base_physics", minetest.serialize(elist))
end

lottplayer.empty_physics = function(player)
	local meta = player:get_meta()
	local pdata = minetest.deserialize(meta:get_string("lottplayer:persist_physics")) -- persistent data
	local tdata = minetest.deserialize(meta:get_string("lottplayer:temp_physics")) -- temp data
	local adata = minetest.deserialize(meta:get_string("lottplayer:addit_physics")) -- temp data
	
	if pdata == nil then
		meta:set_string("lottplayer:persist_physics", minetest.serialize(lottplayer.persist_base))
	end
	if tdata == nil then
		meta:set_string("lottplayer:temp_physics", minetest.serialize(lottplayer.temp_base))
	end
	if adata == nil then
		meta:set_string("lottplayer:addit_physics", minetest.serialize(lottplayer.addit_base))
	end
end

lottplayer.empty_sneak_physics = function(player, etype, amt)
	local meta = player:get_meta()
	local bdata = minetest.deserialize(meta:get_string("lottplayer:base_physics")) -- base data
	local pdata = minetest.deserialize(meta:get_string("lottplayer:persist_physics")) -- persistent data
	local tdata = minetest.deserialize(meta:get_string("lottplayer:temp_physics")) -- temp data
	local adata = minetest.deserialize(meta:get_string("lottplayer:addit_physics")) -- temp data
	
	if pdata[etype] ~= nil then
		player:set_physics_override({[etype]=pdata[etype]})
	elseif tdata[etype] ~= nil then
		player:set_physics_override({[etype]=tdata[etype]})
	elseif adata[etype] ~= nil then
		player:set_physics_override({[etype]=adata[etype]})
	elseif pdata[etype] == nil and tdata[etype] == nil and adata[etype] == nil then
		player:set_physics_override({[etype]=bdata[etype]})
	end
end

lottplayer.get_full_physics = function(player, etype)
	local name = player:get_player_name()
	aeffect = {}
	aeffect[etype] = {}
	aeffect[etype][name] = 0
	local meta = player:get_meta()
	local bdata = minetest.deserialize(meta:get_string("lottplayer:base_physics")) -- base data
	local pdata = minetest.deserialize(meta:get_string("lottplayer:persist_physics")) -- persistent data
	local tdata = minetest.deserialize(meta:get_string("lottplayer:temp_physics")) -- temp data
	local adata = minetest.deserialize(meta:get_string("lottplayer:addit_physics")) -- addit data
	-- combine all existing additive physics
	for _,row in pairs(adata) do
		if row.etype == etype then
			aeffect[etype][name] = aeffect[etype][name] + tonumber(row.amt)
		end
	end
	
	-- combine all physics types
	local total_effects = bdata[etype] + pdata[etype] + tdata[etype] + aeffect[etype][name]
	return total_effects
end

-- Persistent Physics
lottplayer.persist_physics = function(player, etype, amt)
	local meta = player:get_meta()
	local bdata = minetest.deserialize(meta:get_string("lottplayer:base_physics")) -- base data
	local pdata = minetest.deserialize(meta:get_string("lottplayer:persist_physics")) -- persistent data
	local tdata = minetest.deserialize(meta:get_string("lottplayer:temp_physics")) -- temp data
	local adata = minetest.deserialize(meta:get_string("lottplayer:addit_physics")) -- temp data
	
	if etype == "speed" or etype == "jump" or etype == "gravity" then
		local pnew = pdata[etype] + amt -- new persistent data = persistent data + newaddition
		pdata[etype] = tonumber(pnew)
		meta:set_string("lottplayer:persist_physics", minetest.serialize(pdata)) -- store new persistent data
		
		local enew = lottplayer.get_full_physics(player, etype)
		player:set_physics_override({[etype]=enew}) -- set new speed
	elseif etype == "sneak" or etype == "sneak_glitch" then
		pdata[etype] = amt -- new sneak = boolean
		meta:set_string("lottplayer:persist_physics", minetest.serialize(pdata)) -- store new persistent data
		player:set_physics_override({[etype]=amt})
	end
end

-- Temporary Physics
lottplayer.temp_physics = function(player, etype, amt, etime, override)
	if lottplayer.player_exists(player) then return end

	local meta = player:get_meta()
	local bdata = minetest.deserialize(meta:get_string("lottplayer:base_physics")) -- base data
	local pdata = minetest.deserialize(meta:get_string("lottplayer:persist_physics")) -- persistent data
	local tdata = minetest.deserialize(meta:get_string("lottplayer:temp_physics")) -- temp data
	local adata = minetest.deserialize(meta:get_string("lottplayer:addit_physics")) -- temp data
	
	if override == false then -- if override is disabled, return if affected valids aren't empty
		if etype == "speed" or etype == "jump" or etype == "gravity" then
			if tdata[etype] ~= 0 then
				return true
			end
		elseif etype == "sneak" or etype == "sneak_glitch" then
			if tdata[etype] ~= nil then
				return true
			end
		end
	end
	
	if etype == "speed" or etype == "jump" or etype == "gravity" then
		tdata[etype] = tonumber(amt)
		tdata[etype.."_time"] = tonumber(etime)
		meta:set_string("lottplayer:temp_physics", minetest.serialize(tdata)) -- store new temporary data
		
		local enew = lottplayer.get_full_physics(player, etype)
		player:set_physics_override({[etype]=enew}) -- set new speed
		
		for i = 1,etime do
			minetest.after(i, function()
				if lottplayer.player_exists(player) then return end
				
				if tdata[etype.."_time"] > 0 then
					local tdata = minetest.deserialize(meta:get_string("lottplayer:temp_physics"))
					tdata[etype.."_time"] = tonumber(tdata[etype.."_time"]) - 1
					meta:set_string("lottplayer:temp_physics", minetest.serialize(tdata))
					
					if tdata[etype.."_time"] <= 0 then
						local tdata = minetest.deserialize(meta:get_string("lottplayer:temp_physics"))
						tdata[etype.."_time"] = 0
						tdata[etype] = 0
						meta:set_string("lottplayer:temp_physics", minetest.serialize(tdata))
						
						local enew = lottplayer.get_full_physics(player, etype)
						player:set_physics_override({[etype]=enew})
					end
				else return
				end
			end)
		end
		
	elseif etype == "sneak" or etype == "sneak_glitch" then
		tdata[etype] = amt
		tdata[etype.."_time"] = tonumber(etime)
		meta:set_string("lottplayer:temp_physics", minetest.serialize(tdata)) -- store new temporary data
		player:set_physics_override({[etype]=amt})
		
		for i = 1,tonumber(etime) do
			minetest.after(i, function()
				if lottplayer.player_exists(player) then return end
			
				if tdata[etype] > 0 then
					local tdata = minetest.deserialize(meta:get_string("lottplayer:temp_physics"))
					tdata[etype.."_time"] = tonumber(tdata[etype.."_time"]) - 1
					meta:set_string("lottplayer:temp_physics", minetest.serialize(tdata))
					
					if tdata[etype.."_time"] <= 0 then
						local tdata = minetest.deserialize(meta:get_string("lottplayer:temp_physics"))
						tdata[etype.."_time"] = 0
						tdata[etype] = lottplayer.temp_base[etype]
						meta:set_string("lottplayer:temp_physics", minetest.serialize(tdata))
						
						lottplayer.empty_sneak_physics(player, etype, amt)
					end
				else return
				end
			end)
		end
	end
end

lottplayer.addit_physics = function(player, ename, etype, amt, etime, egroup, resumeid)
	if lottplayer.player_exists(player) then return end
	
	local meta = player:get_meta()
	local bdata = minetest.deserialize(meta:get_string("lottplayer:base_physics")) -- base data
	local pdata = minetest.deserialize(meta:get_string("lottplayer:persist_physics")) -- persistent data
	local tdata = minetest.deserialize(meta:get_string("lottplayer:temp_physics")) -- temp data
	local adata = minetest.deserialize(meta:get_string("lottplayer:addit_physics")) -- addit data
	local id = resumeid or math.random(1,999)
	
	if etype == "speed" or etype == "jump" or etype == "gravity" then
		--store data
		if resumeid == nil then
			table.insert(adata, {ename=ename, etype=etype, amt=amt, etime=etime, egroup=egroup, id=id})
			meta:set_string("lottplayer:addit_physics", minetest.serialize(adata))
		end
		
		local enew = lottplayer.get_full_physics(player, etype)
		player:set_physics_override({[etype]=enew})
		
		if etime == nil then
			return
		end
		
		-- modify and store time values
		for i = 1,tonumber(etime) do
			minetest.after(i, function()
				if lottplayer.player_exists(player) then return end
						
				local adata = minetest.deserialize(meta:get_string("lottplayer:addit_physics"))
				for index,row in ipairs(adata) do
					-- check if effect still exists
					if ename == row.ename and id == row.id then
						if row.etime > 0 then
							row.etime = row.etime - 1
							meta:set_string("lottplayer:addit_physics", minetest.serialize(adata))
						end
					end
				end
						
			end)
		end
				
		-- revert physics and remove stored physics values when physics duration ends
		minetest.after(etime, function()
			local adata = minetest.deserialize(meta:get_string("lottplayer:addit_physics"))
			-- check if effect still exists
			for index,row in ipairs(adata) do
				if row.ename == ename and row.id == id then
					table.remove(adata, index)
					meta:set_string("lottplayer:addit_physics", minetest.serialize(adata))
					
					local enew = lottplayer.get_full_physics(player, etype)
					player:set_physics_override({[etype]=enew})
				end
			end
		end)
	end
end

lottplayer.clear_physics = function(player, ecat, etype, egroup)
	local meta = player:get_meta()
	local bdata = minetest.deserialize(meta:get_string("lottplayer:base_physics"))
	local pdata = minetest.deserialize(meta:get_string("lottplayer:persist_physics"))
	local tdata = minetest.deserialize(meta:get_string("lottplayer:temp_physics"))
	local adata = minetest.deserialize(meta:get_string("lottplayer:addit_physics"))
	
	if ecat == "all" then
		meta:set_string("lottplayer:persist_physics", minetest.serialize(lottplayer.persist_base))
		meta:set_string("lottplayer:temp_physics", minetest.serialize(lottplayer.temp_base))
		meta:set_string("lottplayer:addit_physics", minetest.serialize(lottplayer.addit_base))
		player:set_physics_override(bdata)
	elseif ecat == "persist" then
		if etype == "all" then
			meta:set_string("lottplayer:persist_physics", minetest.serialize(lottplayer.persist_base))
		elseif etype == "speed" or etype == "jump" or etype == "gravity" then
		elseif etype == "sneak" or etype == "sneak_glitch" then
		end
	elseif ecat == "temp" then
		if etype == "all" then
			meta:set_string("lottplayer:temp_physics", minetest.serialize(lottplayer.temp_base))
		elseif etype == "speed" or etype == "jump" or etype == "gravity" then
		elseif etype == "sneak" or etype == "sneak_glitch" then
		end
	elseif ecat == "addit" then
		if etype == "all" then
			meta:set_string("lottplayer:addit_physics", minetest.serialize(lottplayer.addit_base))
		elseif etype == "speed" or etype == "jump" or etype == "gravity" then
		elseif etype == "sneak" or etype == "sneak_glitch" then
		elseif egroup ~= nil then
		end
	end
end

minetest.register_on_joinplayer(function(player)
	lottplayer.empty_physics(player)
	local meta = player:get_meta()
	local bdata = minetest.deserialize(meta:get_string("lottplayer:base_physics"))
	local pdata = minetest.deserialize(meta:get_string("lottplayer:persist_physics"))
	local tdata = minetest.deserialize(meta:get_string("lottplayer:temp_physics"))
	local adata = minetest.deserialize(meta:get_string("lottplayer:addit_physics"))
	lottplayer.base_physics(player, {speed=1, jump=1, gravity=1, sneak=true, sneak_glitch=false})
	
	-- resume temporary physics
	local physics_resume_list = {
		{"speed", "speed_time"},
		{"jump", "jump_time"},
		{"gravity", "gravity_time"},
		{"sneak", "sneak_time"},
		{"sneak_glitch", "sneak_glitch_time"},
	}
	
	for _,row in ipairs(physics_resume_list) do
		local etype = row[1]
		local etime = row[2]
		if tdata[etime] > 0 then
			lottplayer.temp_physics(player, etype, tdata[etype], tdata[etime])
		end
	end
	
	-- resume additive physics
	for index,row in ipairs(adata) do
		lottplayer.addit_physics(player, row.ename, row.etype, row.amt, row.etime, row.egroup, row.id)
	end
	
	-- ================== TESTING AREA ========================
	--local meta = player:get_meta()
	--lottplayer.clear_physics(player, "all")
	
	
	--lottplayer.addit_physics(player, "lottplayer:test", "speed", 2, 20)
	--[[minetest.after(5, function()
		lottplayer.addit_physics(player, "lottplayer:test2", "speed", 5, 10)
	end)
	minetest.after(10, function()
		lottplayer.addit_physics(player, "lottplayer:test3", "jump", 3, 10)
	end)
	minetest.after(15, function()
		lottplayer.addit_physics(player, "lottplayer:test4", "speed", 5, 10)
	end)]]
	
	--lottplayer.persist_physics(player, "speed", 9)
	
	
	--local foo = {}
	--table.insert(foo, {hi = 5, ty = 5})
	--table.insert(foo, {hi = 3, ty = 2})
	--print(minetest.serialize(foo))
	
	--table.remove(foo, 2)
	--print(minetest.serialize(foo))
	-- ========================================================

end)
