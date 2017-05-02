minetest.register_tool("lottweapons:elven_sword", {
	description = "Elven Sword",
	inventory_image = "lottweapons_elven_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.25,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=1.60, [2]=1.30, [3]=0.90}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=7.5},
	}
})

minetest.register_tool("lottweapons:orc_sword", {
	description = "Orcish Sword",
	inventory_image = "lottweapons_orc_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.75,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=2.25, [2]=1.80, [3]=1.30}, uses=17, maxlevel=3},
		},
		damage_groups = {fleshy=6.5},
	}
})

minetest.register_tool("lottweapons:balrog_whip", {
	description = minetest.colorize("orange", "Balrog Whip") ..
		minetest.get_background_escape_sequence("darkred"),
	inventory_image = "lottweapons_balrog_whip.png^[transform3",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "nothing" then
			local dir = user:get_look_dir()
			local pos = user:get_pos()
			for i = 1, 50 do
				local new_pos = {
					x = pos.x + (dir.x * i),
					y = pos.y + (dir.y * i),
					z = pos.z + (dir.z * i),
				}
				if minetest.get_node(new_pos).name == "air"	and
				not minetest.is_protected(new_pos, user:get_player_name()) then
					minetest.set_node(new_pos, {name = "fire:basic_flame"})
				end
			end
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/49)
				return itemstack
			end
		elseif pointed_thing.type == "object" then
			local obj = pointed_thing.ref
			minetest.add_particlespawner({
				amount = 40,
				time = 6,
				minpos = {x = -1, y = -1, z = -1},
				maxpos = {x = 1, y = 1, z = 1},
				minvel = {x = -2, y = -2, z = -2},
				maxvel = {x = 2, y = 2, z = 2},
				minacc = {x = -1, y = -1, z = -1},
				maxacc = {x = 1, y = 1, z = 1},
				minexptime = 1,
				maxexptime = 2,
				minsize = 1,
				maxsize = 3,
				attached = obj,
				vertical = false,
				--  ^ vertical: if true faces player using y axis only
				texture = "fire_basic_flame.png",
			})
			obj:punch(user, 1, itemstack:get_tool_capabilities())
			for i = 1, 5 do
				minetest.after(i, function()
					if obj and user and itemstack then
						obj:punch(user, 1, itemstack:get_tool_capabilities())
					end
				end)
			end
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/499)
				return itemstack
			end
		elseif pointed_thing.type == "node" then
			local pos = user:get_pos()
			local radius = 5
			for x = -radius, radius do
			for z = -radius, radius do
			for y = 10, -10, -1 do
				local new_pos = {
					x = pos.x + x,
					y = pos.y + y,
					z = pos.z + z,
				}

				local node =  minetest.get_node(new_pos)
				local nodeu = minetest.get_node({x = new_pos.x, y = new_pos.y - 1, z = new_pos.z})
				local value = x * x + z * z
				if value <= radius * radius + 1
				and node.name == "air" and nodeu.name ~= "air"
				and not minetest.is_protected(new_pos, name) then
					minetest.set_node(new_pos, {name = "fire:basic_flame"})
					break
				end
			end
			end
			end
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/49)
				return itemstack
			end
		end
	end,
	tool_capabilities = {
		full_punch_interval = 0.25,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=1.60, [2]=1.30, [3]=0.90}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	}
})
