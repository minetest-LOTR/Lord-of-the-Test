minetest.register_craftitem("olvar:pipeweed_seed", {
	description = "Pipeweed Seeds",
	inventory_image = "olvar_pipeweed_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "olvar:pipeweed_1")
	end,
})

minetest.register_node("olvar:pipeweed_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_pipeweed_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:pipeweed_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_pipeweed_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+8/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:pipeweed_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_pipeweed_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+13/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:pipeweed_4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"olvar_pipeweed_4.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'olvar:pipeweed_seed'} },
			{ items = {'olvar:pipeweed_seed'}, rarity = 2},
			{ items = {'olvar:pipeweed_seed'}, rarity = 5},
			{ items = {'olvar:pipeweed'} },
			{ items = {'olvar:pipeweed'}, rarity = 2 },
			{ items = {'olvar:pipeweed'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("olvar:pipeweed", {
	description = "Pipeweed",
	inventory_image = "olvar_pipeweed.png",
})

farming:add_plant("olvar:pipeweed_4", {"olvar:pipeweed_1", "olvar:pipeweed_2", "olvar:pipeweed_3"}, 50, 20)

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "olvar:pipeweed_cooked",
	recipe = "olvar:pipeweed"
})

minetest.register_craftitem("olvar:pipeweed_cooked", {
	description = "Cooked Pipeweed",
	inventory_image = "olvar_pipeweed_cooked.png",
})

minetest.register_craft({
	output = 'olvar:pipe',
	recipe = {
		{'', '', 'group:stick'},
		{'group:wood', 'group:stick', ''},
		{'group:stick', '', ''},
	}
})

pipeweed = {
	{"olvar:pipeweed_cooked"},
}

minetest.register_tool("olvar:pipe", {
	description = "Pipe",
	inventory_image = "olvar_pipe.png",
     on_use = function(itemstack, player)
     for _,arrow in ipairs(pipeweed) do
          if player:get_inventory():get_stack("main", player:get_wield_index()+1):get_name() == arrow[1] then
               player:set_hp(player:get_hp()+2)
			if not minetest.setting_getbool("creative_mode") then
				player:get_inventory():remove_item("main", arrow[1])
			end
			local pos = player:getpos()
			local dir = player:get_look_dir()
			minetest.add_particle({
   				pos = {x=pos.x,y=pos.y+1.5,z=pos.z},
    			vel = {x=dir.x*.3, y=.2, z=dir.z*.3},
  	 			acc = {x=dir.x*.01, y=.1, z=dir.z*.01},
  		  		expirationtime = 5,
    			size = .75,
    			collisiondetection = false,
    			vertical = false,
    			texture = "olvar_smoke_ring.png",
			})
		end
	end
end})
