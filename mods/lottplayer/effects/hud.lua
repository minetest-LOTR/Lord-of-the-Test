lottplayer.hud_img = {}
lottplayer.hud_bg = {}
lottplayer.hud_time = {}

lottplayer.calc_time = function(sec)
	local emin = math.floor(sec/60)
	local esec = sec - (emin*60)
	if emin > 59 then
		local ehour = math.floor(emin/60)
		emin = emin - (ehour*60)
			
		if emin < 10 then
			emin = "0"..emin
		end
			
		emin = ehour..":"..emin
	elseif emin < 10 then
		emin = "0"..emin
	end
	
	if esec < 10 then
		esec = "0"..esec
	end
	return emin..":"..esec
end

local function remove_effect_hud(player, erow)
	local name = player:get_player_name()
	player:hud_remove(lottplayer.hud_time[name.."_"..erow])
	lottplayer.hud_time[name.."_"..erow] = nil
	player:hud_remove(lottplayer.hud_bg[name.."_"..erow])
	lottplayer.hud_bg[name.."_"..erow] = nil
	player:hud_remove(lottplayer.hud_img[name.."_"..erow])
	lottplayer.hud_img[name.."_"..erow] = nil
end

lottplayer.add_effect_hud = function(player, erow, eimg, etime)
	if lottplayer.player_exists(player) then return end

	local eloc = 15 + ((tonumber(erow)-1)*20)
	local name = player:get_player_name()
	
	if lottplayer.hud_img[name.."_"..erow] == nil then
		lottplayer.hud_img[name.."_"..erow] = player:hud_add({
			hud_elem_type = "image",
			position = {x=1,y=0},
			text = eimg,
			scale = { x = 1, y = 1 },
			offset = { x = -76, y = eloc },
			direction = 1,
		})
	end
		
	if lottplayer.hud_bg[name.."_"..erow] == nil then
		lottplayer.hud_bg[name.."_"..erow] = player:hud_add({
			hud_elem_type = "image",
			position = {x=1,y=0},
			text = "gui_grey.png",
			scale = { x = 3.5, y = 1 },
			offset = { x = -35, y = eloc },
			direction = 1,
		})
	end
		
	if tonumber(etime) then
		lottplayer.hud_etime = lottplayer.calc_time(etime)
	else
		lottplayer.hud_etime = "∞"
	end
		
	if lottplayer.hud_time[name.."_"..erow] == nil then
		lottplayer.hud_time[name.."_"..erow] = player:hud_add({
			hud_elem_type = "text",
			position = {x=1,y=0},
			text = lottplayer.hud_etime,
			number = "0xFFFFFF",
			scale = { x = 1, y = 1 },
			offset = { x = -35, y = eloc },
			direction = 1,
		})
	end
end

lottplayer.update_effect = function(player)
	if lottplayer.player_exists(player) then return end

	local meta = player:get_meta()
	local name = player:get_player_name()
	local hdata = minetest.deserialize(meta:get_string("lottplayer:effects_hud"))
	for index,row in ipairs(hdata) do
		if index ~= row.erow then
			remove_effect_hud(player, row.erow)
			-- update row number
			row.erow = index
			meta:set_string("lottplayer:effects_hud", minetest.serialize(hdata))
			-- re-add huds
			lottplayer.add_effect_hud(player, index, row.eimg, row.etime)
		end
	end
end

lottplayer.add_effect = function(player, ename, etime, edesc, eimg)
	if lottplayer.player_exists(player) then return end
	
	local meta = player:get_meta()
	local name = player:get_player_name()
	local hdata = minetest.deserialize(meta:get_string("lottplayer:effects_hud"))
	local id = math.random(1,999)
	
	table.insert(hdata, {ename=ename, etime=etime, edesc=edesc, eimg=eimg, erow=0, id=id})
	meta:set_string("lottplayer:effects_hud", minetest.serialize(hdata))
	
	local hdata = minetest.deserialize(meta:get_string("lottplayer:effects_hud"))
	for index,row in ipairs(hdata) do
		row.erow = index
		meta:set_string("lottplayer:effects_hud", minetest.serialize(hdata))
		-- add hud
		lottplayer.add_effect_hud(player, index, eimg, etime)
	end
	
	if tonumber(etime) then
	-- Update HUD Element
	for i = 1,tonumber(etime) do
		minetest.after(i, function()
			if lottplayer.player_exists(player) then return end
			local hdata = minetest.deserialize(meta:get_string("lottplayer:effects_hud"))
			for index,row in ipairs(hdata) do
				if row.erow ~= 0 then
				if row.ename == ename and row.edesc == edesc and row.eimg == eimg and row.id == id then
					if tonumber(row.etime) then
						-- update stored time
						row.etime = row.etime - 1
						meta:set_string("lottplayer:effects_hud", minetest.serialize(hdata))
						-- update hud time
						player:hud_change(lottplayer.hud_time[name.."_"..row.erow], "text", lottplayer.calc_time(row.etime))
					end
				end
				end
			end
		end)
	end
	
	-- Remove HUD Element
	minetest.after(etime, function()
		if lottplayer.player_exists(player) then return end
		local hdata = minetest.deserialize(meta:get_string("lottplayer:effects_hud"))
		for index,row in ipairs(hdata) do
			if row.ename == ename and row.edesc == edesc and row.eimg == eimg and row.id == id then
				remove_effect_hud(player, row.erow)
				table.remove(hdata, index)
				meta:set_string("lottplayer:effects_hud", minetest.serialize(hdata))
				
				lottplayer.update_effect(player)
			end
		end
	end)
	end
	
	return id
end

lottplayer.remove_effect = function(player, ename, id)
	if lottplayer.player_exists(player) then return end
	
	local meta = player:get_meta()
	local name = player:get_player_name()
	local hdata = minetest.deserialize(meta:get_string("lottplayer:effects_hud"))
	for index,row in ipairs(hdata) do
		if id == nil then
			id = row.id
		end
		
		if row.ename == ename and row.id == id then
			remove_effect_hud(player, row.erow)
			table.remove(hdata, index)
			meta:set_string("lottplayer:effects_hud", minetest.serialize(hdata))
				
			lottplayer.update_effect(player)
		end
	end
end

minetest.register_on_joinplayer(function(player)
	local meta = player:get_meta()
	local hdata = minetest.deserialize(meta:get_string("lottplayer:effects_hud"))
	local hdata_base = {}
	meta:set_string("lottplayer:effects_hud", minetest.serialize(hdata_base))
end)