-- Minetest 0.4 mod: bones
-- See README.txt for licensing and other information. 

local function is_owner(pos, name)
	local owner = minetest.get_meta(pos):get_string("owner")
	if owner == "" or owner == name then
		return true
	end
	return false
end

minetest.register_node("bones:bones", {
	description = "Bones Block",
	tiles = {
		"bones_top.png",
		"bones_bottom.png",
		"bones_side.png",
		"bones_side.png",
		"bones_rear.png",
		"bones_front.png"
	},
	paramtype2 = "facedir",
	groups = {dig_immediate=3},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
	
	can_dig = function(pos, player)
		local inv = minetest.get_meta(pos):get_inventory()
		return is_owner(pos, player:get_player_name()) and inv:is_empty("main")
	end,
	
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if is_owner(pos, player:get_player_name()) then
			return count
		end
		return 0
	end,
	
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		return 0
	end,
	
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if is_owner(pos, player:get_player_name()) then
			return stack:get_count()
		end
		return 0
	end,
	
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if meta:get_string("owner") ~= "" and meta:get_inventory():is_empty("main") then
			meta:set_string("infotext", meta:get_string("owner").."'s old bones")
			meta:set_string("formspec", "")
			meta:set_string("owner", "")
		end
	end,
	
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local time = meta:get_int("time")+elapsed
		local publish = 1200
		if tonumber(minetest.setting_get("share_bones_time")) then
			publish = tonumber(minetest.setting_get("share_bones_time"))
		end
		if publish == 0 then
			return
		end
		if time >= publish then
			meta:set_string("infotext", meta:get_string("owner").."'s old bones")
			meta:set_string("owner", "")
		else
			return true
		end
	end,
	
	on_punch = function(pos, node, player)
		if(not is_owner(pos, player:get_player_name())) then
			return
		end
		
		local inv = minetest.get_meta(pos):get_inventory()
		local player_inv = player:get_inventory()
		local has_space = true
		
		for i=1,inv:get_size("main") do
			local stk = inv:get_stack("main", i)
			if player_inv:room_for_item("main", stk) then
				inv:set_stack("main", i, nil)
				player_inv:add_item("main", stk)
			else
				has_space = false
				break
			end
		end
	end,
})

minetest.register_on_dieplayer(function(player)
	if minetest.setting_getbool("creative_mode") then
		return
	end
	
	local pos = player:getpos()
	pos.x = math.floor(pos.x+0.5)
	pos.y = math.floor(pos.y+0.5)
	pos.z = math.floor(pos.z+0.5)
	local param2 = minetest.dir_to_facedir(player:get_look_dir())
	
	local nn = minetest.get_node(pos).name
	if minetest.registered_nodes[nn].can_dig and
		not minetest.registered_nodes[nn].can_dig(pos, player) then
		local player_inv = player:get_inventory()

		for i=1,player_inv:get_size("main") do
			player_inv:set_stack("main", i, nil)
		end
		for i=1,player_inv:get_size("craft") do
			player_inv:set_stack("craft", i, nil)
		end
		return
	end
	
	minetest.dig_node(pos)
	minetest.add_node(pos, {name="bones:bones", param2=param2})
	
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local player_inv = player:get_inventory()
	inv:set_size("main", 8*4)
	
	local empty_list = inv:get_list("main")
	inv:set_list("main", player_inv:get_list("main"))
	player_inv:set_list("main", empty_list)
	
	for i=1,player_inv:get_size("craft") do
		inv:add_item("main", player_inv:get_stack("craft", i))
		player_inv:set_stack("craft", i, nil)
	end
	
	meta:set_string("formspec", "size[8,9;]"..
			"list[current_name;main;0,0;8,4;]"..
			"list[current_player;main;0,5;8,4;]")
	meta:set_string("infotext", player:get_player_name().."'s fresh bones")
	meta:set_string("owner", player:get_player_name())
	meta:set_int("time", 0)
	
	local timer  = minetest.get_node_timer(pos)
	timer:start(10)
end)

local function growgen(pointed_thing)
pos = pointed_thing.under
n = minetest.env:get_node(pos)
if n.name == "" then return end
if n.name == "lottfarming:turnips_1" then
	minetest.env:set_node(pos, {name="lottfarming:turnips_2"})
elseif n.name == "lottfarming:turnips_2" then
	minetest.env:set_node(pos, {name="lottfarming:turnips_3"})
elseif n.name == "lottfarming:turnips_3" then
	minetest.env:set_node(pos, {name="lottfarming:turnips_4"})
elseif n.name == "lottfarming:athelas_1" then
	minetest.env:set_node(pos, {name="lottfarming:athelas_2"})
elseif n.name == "lottfarming:athelas_2" then
	minetest.env:set_node(pos, {name="lottfarming:athelas_3"})
elseif n.name == "lottfarming:barley_1" then
	minetest.env:set_node(pos, {name="lottfarming:barley_2"})
elseif n.name == "lottfarming:barley_2" then
	minetest.env:set_node(pos, {name="lottfarming:barley_3"})
elseif n.name == "lottfarming:berries_1" then
	minetest.env:set_node(pos, {name="lottfarming:berries_2"})
elseif n.name == "lottfarming:berries_2" then
	minetest.env:set_node(pos, {name="lottfarming:berries_3"})
elseif n.name == "lottfarming:berries_3" then
	minetest.env:set_node(pos, {name="lottfarming:berries_4"})
elseif n.name == "lottfarming:blue_mushroom_1" then
	minetest.env:set_node(pos, {name="lottfarming:blue_mushroom_2"})
elseif n.name == "lottfarming:blue_mushroom_2" then
	minetest.env:set_node(pos, {name="lottfarming:blue_mushroom_3"})
elseif n.name == "lottfarming:blue_mushroom_3" then
	minetest.env:set_node(pos, {name="lottfarming:blue_mushroom_4"})
elseif n.name == "lottfarming:brown_mushroom_1" then
	minetest.env:set_node(pos, {name="lottfarming:brown_mushroom_2"})
elseif n.name == "lottfarming:brown_mushroom_2" then
	minetest.env:set_node(pos, {name="lottfarming:brown_mushroom_3"})
elseif n.name == "lottfarming:brown_mushroom_3" then
	minetest.env:set_node(pos, {name="lottfarming:brown_mushroom_4"})
elseif n.name == "lottfarming:cabbage_1" then
	minetest.env:set_node(pos, {name="lottfarming:cabbage_2"})
elseif n.name == "lottfarming:cabbage_2" then
	minetest.env:set_node(pos, {name="lottfarming:cabbage_3"})
elseif n.name == "lottfarming:green_mushroom_1" then
	minetest.env:set_node(pos, {name="lottfarming:green_mushroom_2"})
elseif n.name == "lottfarming:green_mushroom_2" then
	minetest.env:set_node(pos, {name="lottfarming:green_mushroom_3"})
elseif n.name == "lottfarming:green_mushroom_3" then
	minetest.env:set_node(pos, {name="lottfarming:green_mushroom_4"})
elseif n.name == "lottfarming:melon_1" then
	minetest.env:set_node(pos, {name="lottfarming:melon_2"})
elseif n.name == "lottfarming:melon_2" then
	minetest.env:set_node(pos, {name="lottfarming:melon_3"})
elseif n.name == "lottfarming:pipeweed_1" then
	minetest.env:set_node(pos, {name="lottfarming:pipeweed_2"})
elseif n.name == "lottfarming:pipeweed_2" then
	minetest.env:set_node(pos, {name="lottfarming:pipeweed_3"})
elseif n.name == "lottfarming:pipeweed_3" then
	minetest.env:set_node(pos, {name="lottfarming:pipeweed_4"})
elseif n.name == "lottfarming:potato_1" then
	minetest.env:set_node(pos, {name="lottfarming:potato_2"})
elseif n.name == "lottfarming:potato_2" then
	minetest.env:set_node(pos, {name="lottfarming:potato_3"})
elseif n.name == "lottfarming:red_mushroom_1" then
	minetest.env:set_node(pos, {name="lottfarming:red_mushroom_2"})
elseif n.name == "lottfarming:red_mushroom_2" then
	minetest.env:set_node(pos, {name="lottfarming:red_mushroom_3"})
elseif n.name == "lottfarming:red_mushroom_3" then
	minetest.env:set_node(pos, {name="lottfarming:red_mushroom_4"})
elseif n.name == "lottfarming:tomatoes_1" then
	minetest.env:set_node(pos, {name="lottfarming:tomatoes_2"})
elseif n.name == "lottfarming:tomatoes_2" then
	minetest.env:set_node(pos, {name="lottfarming:tomatoes_3"})
elseif n.name == "lottfarming:tomatoes_3" then
	minetest.env:set_node(pos, {name="lottfarming:tomatoes_4"})
elseif n.name == "lottfarming:corn_1" then
	minetest.env:set_node(pos, {name="lottfarming:corn_2"})
elseif n.name == "lottfarming:corn_2" then
	minetest.env:set_node(pos, {name="lottfarming:corn_21"})
elseif n.name == "lottfarming:corn_21" then
	minetest.env:set_node(pos, {name="lottfarming:corn_32"})
elseif n.name == "farming:wheat_1" then
	minetest.env:set_node(pos, {name="farming:wheat_2"})
elseif n.name == "farming:wheat_2" then
	minetest.env:set_node(pos, {name="farming:wheat_3"})
elseif n.name == "farming:wheat_3" then
	minetest.env:set_node(pos, {name="farming:wheat_4"})
elseif n.name == "farming:wheat_4" then
	minetest.env:set_node(pos, {name="farming:wheat_5"})
elseif n.name == "farming:wheat_5" then
	minetest.env:set_node(pos, {name="farming:wheat_6"})
elseif n.name == "farming:wheat_6" then
	minetest.env:set_node(pos, {name="farming:wheat_7"})
elseif n.name == "farming:wheat_7" then
	minetest.env:set_node(pos, {name="farming:wheat_8"})
elseif n.name == "farming:cotton_1" then
	minetest.env:set_node(pos, {name="farming:cotton_2"})
elseif n.name == "farming:cotton_2" then
	minetest.env:set_node(pos, {name="farming:cotton_3"})
elseif n.name == "farming:cotton_3" then
	minetest.env:set_node(pos, {name="farming:cotton_4"})
elseif n.name == "farming:cotton_4" then
	minetest.env:set_node(pos, {name="farming:cotton_5"})
elseif n.name == "farming:cotton_5" then
	minetest.env:set_node(pos, {name="farming:cotton_6"})
elseif n.name == "farming:cotton_6" then
	minetest.env:set_node(pos, {name="farming:cotton_7"})
elseif n.name == "farming:cotton_7" then
	minetest.env:set_node(pos, {name="farming:cotton_8"})
     end
end

minetest.register_craftitem("bones:bonedust", {
	description = "Bone Dust",
	inventory_image = "bones_bonedust.png",
	liquids_pointable = false,
	stack_max = 99,
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
			growgen(pointed_thing)
			itemstack:take_item()
			return itemstack
		end
	end,
})

minetest.register_craftitem("bones:bone", {
	description = "Bone",
	inventory_image = "bones_bone.png",
})

minetest.register_craft({
	type = "fuel",
	recipe = "bones:bonedust",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "bones:bone",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "bones:bones",
	burntime = 36,
})

minetest.register_craft({
	output = 'bones:bones',
	recipe = {
		{'bones:bone', 'bones:bone', 'bones:bone'},
		{'bones:bone', 'bones:bone', 'bones:bone'},
		{'bones:bone', 'bones:bone', 'bones:bone'},
	}
})

minetest.register_craft({
	output = 'bones:bone 9',
	recipe = {
		{'bones:bones'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "bones:bonedust 2",
	recipe = "bones:bone",
})

minetest.register_tool("bones:bone_scythe", {
	description = "Bone Scythe",
	inventory_image = "bones_scythe.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	}
})

minetest.register_craft({
	output = 'bones:bone_scythe',
	recipe = {
		{'bones:skeleton_body', 'bones:skeleton_body', ''},
		{'', 'default:stick', ''},
		{'', 'default:stick',''},
	}
})

minetest.register_craft({
	output = 'bones:skeleton_body',
	recipe = {
		{'bones:bones', 'bones:bones', 'bones:bones'},
		{'bones:bones', 'bones:bones', 'bones:bones'},
		{'bones:bones', 'bones:bones', 'bones:bones'},
	}
})

minetest.register_node("bones:skeleton", {
	description = "Skeleton Head",
     drawtype = "nodebox",
	tiles = {
		"bones_skeleton_top.png",
		"bones_skeleton_bottom.png",
		"bones_skeleton_side.png",
		"bones_skeleton_side.png",
		"bones_skeleton_rear.png",
		"bones_skeleton_front.png"
	},
	paramtype2 = "facedir",
     paramtype = "light",
	groups = {dig_immediate=2},
     drop = "bones:bonedust",
     node_box = {
		type = "fixed",
		fixed = {
			{-0.3125,0.3125,-0.3125,0.3125,0.5,0.3125},
			{ -0.5,0.25,-0.5,0.5,0.415385,0.5},
			{-0.5,-0.1875,-0.5,0.5,0.375,0.5}, 
			{-0.375,-0.5,-0.3125,0.375,0.125,0.3125}, 
		},
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
     }),
})

minetest.register_node("bones:skeleton_body", {
	description = "Skeleton",
     drawtype = "nodebox",
     stack_max = 1,
	tiles = {"bones_skeleton_top.png"},
     inventory_image = "bones_skeleton.png",
    wield_image     = "bones_skeleton.png",
     paramtype = "light",
	groups = {dig_immediate=2},
     node_box = {
		type = "fixed",
		fixed = {
			{-0.0625,-0.0625,-0.0625,0.125,0.5,0.0625},
			{-0.25,-0.3125,-0.25,0.3125,-0.0625,0.25},
			{-0.25,-0.5,-0.0625,-0.125,-0.0625,0.125},
			{0.3125,-0.5,-0.0625,0.1875,-0.0625,0.125},
			{-0.3125,0,-0.375,0.375,0.125,0.375},
			{-0.3125,0.375,-0.375,0.375,0.5,0.375},
			{-0.3125,0.1875,-0.375,0.375,0.3125,0.375},
               {0.375,-0.0625,-0.0625,0.5,0.5,0.1875},
               {-0.3125,-0.0625,-0.0625,-0.4375,0.5,0.1875},
		},
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
     on_place = function(itemstack, placer, pointed_thing)
        local above = pointed_thing.above
        if minetest.env:get_node({x = above.x, y = above.y + 1, z = above.z}).name ~= "air" then
            return itemstack
        end
        local fdir = 0
        local placer_pos = placer:getpos()
        if placer_pos then
            dir = {
                x = above.x - placer_pos.x,
                y = above.y - placer_pos.y,
                z = above.z - placer_pos.z
            }
            fdir = minetest.dir_to_facedir(dir)
        end
        minetest.env:add_node(above, {name = "bones:skeleton_body", param2 = fdir})
        minetest.env:add_node({x = above.x, y = above.y + 1, z = above.z}, {name = "bones:skeleton", param2 = fdir})
        return ItemStack("")
    end,
    on_destruct = function(pos)
            local p = {x=pos.x, y=pos.y+1, z=pos.z}
	    minetest.env:remove_node(p)
    end
})
