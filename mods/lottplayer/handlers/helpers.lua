local function change_clouds(player, cloud_def)
	local clouds_changing = player:get_attribute("lottplayer:clouds_changing")
	if clouds_changing == "true" then
		return false
	end
	local current_clouds = player:get_clouds()
	for i = 0, 40, 2 do
		minetest.after(i, function()
			if not player then
				return
			end
			local clouds = {}
			if cloud_def.density then
				local d = current_clouds.density +
					(cloud_def.density - current_clouds.density) * (i / 40)
				clouds.density = d
			end
			if cloud_def.thickness then
				local t = current_clouds.thickness +
					(cloud_def.thickness - current_clouds.thickness) * (i / 40)
				clouds.thickness = t
			end
			if cloud_def.height then
				local h = current_clouds.height +
					(cloud_def.height - current_clouds.height) * (i / 40)
				clouds.height = h
			end
			if cloud_def.color then
				local parts = {"r", "g", "b", "a"}
				local new_color = {}
				for _, c in pairs(parts) do
					local nc = current_clouds.color[c] +
						(cloud_def.color[c] - current_clouds.color[c]) * (i / 40)
					new_color[c] = nc
				end
				clouds.color = new_color
			end
			player:set_clouds(clouds)
			if i == 40 then
				player:set_attribute("lottplayer:clouds_changing", "false")
				local new_biome = player:get_attribute("lottplayer:cloud_change")
				if new_biome ~= "" then
					new_biome = tonumber(new_biome)
					if lottmapgen.biome[new_biome]
					and lottmapgen.biome[new_biome].clouds then
						change_clouds(player, lottmapgen.biome[new_biome].clouds)
					end
					player:set_attribute("lottplayer:cloud_change", "")
				end
			end
		end)
	end
	player:set_attribute("lottplayer:clouds_changing", "true")
	return true
end

local huds = {}
local biomes = {}

local t = 0
local t2 = 0
minetest.register_globalstep(function(dtime)
	t = t + dtime
	t2 = t2 + dtime
	if t > 5 then
		t = 0
		for _, player in pairs(minetest.get_connected_players()) do
			local id, biome = lottmapgen.get_biome_at_pos(player:get_pos())
			if not id or not biome then
				return
			end
			local name = player:get_player_name()
			if not biomes[name] then
				biomes[name] = id
			end
			if biomes[name] ~= id and huds[name] then
				biomes[name] = id
				player:hud_change(huds[name], "text", "Current Biome: " .. biome)
				if lottmapgen.biome[id] and lottmapgen.biome[id].clouds then
					local res = change_clouds(player, lottmapgen.biome[id].clouds)
					if not res then
						player:set_attribute("lottplayer:cloud_change", id)
					end
				else
					change_clouds(player, {density = 0.4, thickness = 16, color = {
						r = 255,
						g = 240,
						b = 240,
						a = 229}, height = 120
					})
				end
			end
			if not huds[name] then
				huds[name] = player:hud_add({
					hud_elem_type = "text",
					position = {x=0.13, y=0.9},
					name = "biome",
					text = "Current Biome: " .. biome,
					number = 0xFFFFFF,
				})
			end
		end
	end
end)