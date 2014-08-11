minetest.register_node("lottother:lamp_wood",{
	drop = "",
	description = "Wooden Lamp Post",
	tiles = {"default_cobble.png"},
	inventory_image = "lottother_lamps_inv.png",
	groups = {cracky = 1},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.15,-0.5,-0.15,0.15,0.4,0.15},
			{-0.1,0.4,-0.1,0.1,0.5,0.1}
		}
	},
	pointable = false,
     on_place = function(itemstack, placer, pointed_thing)
       local pos = pointed_thing.above;
       if( minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" ) then
          minetest.chat_send_player( placer:get_player_name(), 'Not enough space for lamppost to be placed' )
          return;
       end
       if( minetest.env:get_node({x=pos.x, y=pos.y+2, z=pos.z}).name ~= "air" ) then
          minetest.chat_send_player( placer:get_player_name(), 'Not enough space for lamppost to be placed' )
          return;
       end
       return minetest.item_place(itemstack, placer, pointed_thing);
    end,
	after_place_node = function(pos,placer,itemstack)
		minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "lottother:lamp_middle_wood"})
		minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},{name = "lottother:lamp_top_wood"})
	end
})
minetest.register_node("lottother:lamp_middle_wood",{
	drop = "",
	groups = {cracky = 1, not_in_creative_inventory = 1},
	tiles = {"default_wood.png"},
	paramtype = "light",
	drawtype = "nodebox",
	pointable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,0.5,0.1}
		}
	}
})

minetest.register_node("lottother:lamp_top_wood",{
	drop = "lottother:lamp_wood",
	groups = {cracky = 1, not_in_creative_inventory = 1},
		tiles = {
		"default_wood.png",
		"default_wood.png",
		{
			image = "lottother_lamps_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		{
			image = "lottother_lamps_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}}}}},
	paramtype = "light",
	drawtype = "nodebox",
	light_source = 14,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
	selection_box = 	{
		type = "fixed",
		fixed = {
			{-0.3,0.5,-0.3,0.3,-2.5,0.3},
		}
	},
	after_dig_node = function(pos)
		minetest.remove_node({x = pos.x, y = pos.y - 1, z = pos.z})
		minetest.remove_node({x = pos.x, y = pos.y - 2, z = pos.z})
	end
})

minetest.register_node("lottother:tiny_lamp_wood",{
     description = "Wooden Tiny Lamp",
	groups = {cracky = 1},
		tiles = {
		"default_wood.png",
		"default_wood.png",
		{
			image = "lottother_lamps_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		{
			image = "lottother_lamps_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}}}}},
	paramtype = "light",
     paramtype2 = "wallmounted",
     legacy_wallmounted = true,
	drawtype = "nodebox",
	light_source = 14,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
	selection_box = 	{
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
})

minetest.register_craft({
	output = "lottother:lamp_wood",
	recipe = {
		{"","default:torch",""},
		{"","default:steel_ingot",""},
		{"","default:steel_ingot",""}
	}
})

minetest.register_craft({
	output = "lottother:tiny_lamp_wood",
	recipe = {
		{"","default:torch",""},
		{"","default:steel_ingot",""},
		{"","default:steel_ingot",""}
	}
})

---------------------------------------------

minetest.register_node("lottother:lamp_wood_alder",{
	drop = "",
	description = "Alder Wood Lamp Post",
	tiles = {"default_cobble.png"},
	inventory_image = "lottother_lamps_inv_alder.png",
	groups = {cracky = 1},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.15,-0.5,-0.15,0.15,0.4,0.15},
			{-0.1,0.4,-0.1,0.1,0.5,0.1}
		}
	},
	pointable = false,
     on_place = function(itemstack, placer, pointed_thing)
       local pos = pointed_thing.above;
       if( minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" ) then
          minetest.chat_send_player( placer:get_player_name(), 'Not enough space for lamppost to be placed' )
          return;
       end
       if( minetest.env:get_node({x=pos.x, y=pos.y+2, z=pos.z}).name ~= "air" ) then
          minetest.chat_send_player( placer:get_player_name(), 'Not enough space for lamppost to be placed' )
          return;
       end
       return minetest.item_place(itemstack, placer, pointed_thing);
    end,
	after_place_node = function(pos,placer,itemstack)
		minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "lottother:lamp_middle_wood_alder"})
		minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},{name = "lottother:lamp_top_wood_alder"})
	end
})
minetest.register_node("lottother:lamp_middle_wood_alder",{
	drop = "",
	groups = {cracky = 1, not_in_creative_inventory = 1},
	tiles = {"lottplants_alderwood.png"},
	paramtype = "light",
	drawtype = "nodebox",
	pointable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,0.5,0.1}
		}
	}
})

minetest.register_node("lottother:lamp_top_wood_alder",{
	drop = "lottother:lamp_wood_alder",
	groups = {cracky = 1, not_in_creative_inventory = 1},
		tiles = {
		"lottplants_alderwood.png",
		"lottplants_alderwood.png",
		{
			image = "lottother_lamps_active_alder.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_alder.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_alder.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		{
			image = "lottother_lamps_active_alder.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}}}}},
	paramtype = "light",
	drawtype = "nodebox",
	light_source = 14,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
	selection_box = 	{
		type = "fixed",
		fixed = {
			{-0.3,0.5,-0.3,0.3,-2.5,0.3},
		}
	},
	after_dig_node = function(pos)
		minetest.remove_node({x = pos.x, y = pos.y - 1, z = pos.z})
		minetest.remove_node({x = pos.x, y = pos.y - 2, z = pos.z})
	end
})

minetest.register_node("lottother:tiny_lamp_wood_alder",{
     description = "Alder Wood Tiny Lamp",
	groups = {cracky = 1},
		tiles = {
		"lottplants_alderwood.png",
		"lottplants_alderwood.png",
		{
			image = "lottother_lamps_active_alder.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_alder.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_alder.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		{
			image = "lottother_lamps_active_alder.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}}}}},
	paramtype = "light",
     paramtype2 = "wallmounted",
     legacy_wallmounted = true,
	drawtype = "nodebox",
	light_source = 14,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
	selection_box = 	{
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
})

minetest.register_craft({
	output = "lottother:lamp_wood_alder",
	recipe = {
		{"","default:torch",""},
		{"","default:steel_ingot",""},
		{"","default:steel_ingot",""}
	}
})

minetest.register_craft({
	output = "lottother:tiny_lamp_wood_alder",
	recipe = {
		{"","default:torch",""},
		{"","default:steel_ingot",""},
		{"","default:steel_ingot",""}
	}
})

-----------------------------------------------------

minetest.register_node("lottother:lamp_wood_birch",{
	drop = "",
	description = "Birch Wood Lamp Post",
	tiles = {"default_cobble.png"},
	inventory_image = "lottother_lamps_inv_birch.png",
	groups = {cracky = 1},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.15,-0.5,-0.15,0.15,0.4,0.15},
			{-0.1,0.4,-0.1,0.1,0.5,0.1}
		}
	},
	pointable = false,
     on_place = function(itemstack, placer, pointed_thing)
       local pos = pointed_thing.above;
       if( minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" ) then
          minetest.chat_send_player( placer:get_player_name(), 'Not enough space for lamppost to be placed' )
          return;
       end
       if( minetest.env:get_node({x=pos.x, y=pos.y+2, z=pos.z}).name ~= "air" ) then
          minetest.chat_send_player( placer:get_player_name(), 'Not enough space for lamppost to be placed' )
          return;
       end
       return minetest.item_place(itemstack, placer, pointed_thing);
    end,
	after_place_node = function(pos,placer,itemstack)
		minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "lottother:lamp_middle_wood_birch"})
		minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},{name = "lottother:lamp_top_wood_birch"})
	end
})
minetest.register_node("lottother:lamp_middle_wood_birch",{
	drop = "",
	groups = {cracky = 1, not_in_creative_inventory = 1},
	tiles = {"lottplants_birchwood.png"},
	paramtype = "light",
	drawtype = "nodebox",
	pointable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,0.5,0.1}
		}
	}
})

minetest.register_node("lottother:lamp_top_wood_birch",{
	drop = "lottother:lamp_wood_birch",
	groups = {cracky = 1, not_in_creative_inventory = 1},
		tiles = {
		"lottplants_birchwood.png",
		"lottplants_birchwood.png",
		{
			image = "lottother_lamps_active_birch.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_birch.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_birch.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		{
			image = "lottother_lamps_active_birch.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}}}}},
	paramtype = "light",
	drawtype = "nodebox",
	light_source = 14,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
	selection_box = 	{
		type = "fixed",
		fixed = {
			{-0.3,0.5,-0.3,0.3,-2.5,0.3},
		}
	},
	after_dig_node = function(pos)
		minetest.remove_node({x = pos.x, y = pos.y - 1, z = pos.z})
		minetest.remove_node({x = pos.x, y = pos.y - 2, z = pos.z})
	end
})

minetest.register_node("lottother:tiny_lamp_wood_birch",{
     description = "Birch Wood Tiny Lamp",
	groups = {cracky = 1},
		tiles = {
		"lottplants_birchwood.png",
		"lottplants_birchwood.png",
		{
			image = "lottother_lamps_active_birch.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_birch.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_birch.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		{
			image = "lottother_lamps_active_birch.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}}}}},
	paramtype = "light",
     paramtype2 = "wallmounted",
     legacy_wallmounted = true,
	drawtype = "nodebox",
	light_source = 14,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
	selection_box = 	{
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
})

minetest.register_craft({
	output = "lottother:lamp_wood_birch",
	recipe = {
		{"","default:torch",""},
		{"","default:steel_ingot",""},
		{"","default:steel_ingot",""}
	}
})

minetest.register_craft({
	output = "lottother:tiny_lamp_wood_birch",
	recipe = {
		{"","default:torch",""},
		{"","default:steel_ingot",""},
		{"","default:steel_ingot",""}
	}
})
-------------------------------------------------------

minetest.register_node("lottother:lamp_wood_lebethron",{
	drop = "",
	description = "Lebethron Wood Lamp Post",
	tiles = {"default_cobble.png"},
	inventory_image = "lottother_lamps_inv_lebethron.png",
	groups = {cracky = 1},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.15,-0.5,-0.15,0.15,0.4,0.15},
			{-0.1,0.4,-0.1,0.1,0.5,0.1}
		}
	},
	pointable = false,
     on_place = function(itemstack, placer, pointed_thing)
       local pos = pointed_thing.above;
       if( minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" ) then
          minetest.chat_send_player( placer:get_player_name(), 'Not enough space for lamppost to be placed' )
          return;
       end
       if( minetest.env:get_node({x=pos.x, y=pos.y+2, z=pos.z}).name ~= "air" ) then
          minetest.chat_send_player( placer:get_player_name(), 'Not enough space for lamppost to be placed' )
          return;
       end
       return minetest.item_place(itemstack, placer, pointed_thing);
    end,
	after_place_node = function(pos,placer,itemstack)
		minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "lottother:lamp_middle_wood_lebethron"})
		minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},{name = "lottother:lamp_top_wood_lebethron"})
	end
})
minetest.register_node("lottother:lamp_middle_wood_lebethron",{
	drop = "",
	groups = {cracky = 1, not_in_creative_inventory = 1},
	tiles = {"lottplants_lebethronwood.png"},
	paramtype = "light",
	drawtype = "nodebox",
	pointable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,0.5,0.1}
		}
	}
})

minetest.register_node("lottother:lamp_top_wood_lebethron",{
	drop = "lottother:lamp_wood_lebethron",
	groups = {cracky = 1, not_in_creative_inventory = 1},
		tiles = {
		"default_wood.png",
		"default_wood.png",
		{
			image = "lottother_lamps_active_lebethron.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_lebethron.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_lebethron.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		{
			image = "lottother_lamps_active_lebethron.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}}}}},
	paramtype = "light",
	drawtype = "nodebox",
	light_source = 14,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
	selection_box = 	{
		type = "fixed",
		fixed = {
			{-0.3,0.5,-0.3,0.3,-2.5,0.3},
		}
	},
	after_dig_node = function(pos)
		minetest.remove_node({x = pos.x, y = pos.y - 1, z = pos.z})
		minetest.remove_node({x = pos.x, y = pos.y - 2, z = pos.z})
	end
})

minetest.register_node("lottother:tiny_lamp_wood_lebethron",{
     description = "Lebethron Wood Tiny Lamp",
	groups = {cracky = 1},
		tiles = {
		"default_wood.png",
		"default_wood.png",
		{
			image = "lottother_lamps_active_lebethron.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_lebethron.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_lebethron.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		{
			image = "lottother_lamps_active_lebethron.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}}}}},
	paramtype = "light",
     paramtype2 = "wallmounted",
     legacy_wallmounted = true,
	drawtype = "nodebox",
	light_source = 14,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
	selection_box = 	{
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
})

minetest.register_craft({
	output = "lottother:lamp_wood_lebethron",
	recipe = {
		{"","default:torch",""},
		{"","default:steel_ingot",""},
		{"","default:steel_ingot",""}
	}
})

minetest.register_craft({
	output = "lottother:tiny_lamp_wood_lebethron",
	recipe = {
		{"","default:torch",""},
		{"","default:steel_ingot",""},
		{"","default:steel_ingot",""}
	}
})

---------------------------------------------

minetest.register_node("lottother:lamp_wood_mallorn",{
	drop = "",
	description = "Mallorn Wood Lamp Post",
	tiles = {"default_cobble.png"},
	inventory_image = "lottother_lamps_inv_mallorn.png",
	groups = {cracky = 1},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.15,-0.5,-0.15,0.15,0.4,0.15},
			{-0.1,0.4,-0.1,0.1,0.5,0.1}
		}
	},
	pointable = false,
     on_place = function(itemstack, placer, pointed_thing)
       local pos = pointed_thing.above;
       if( minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" ) then
          minetest.chat_send_player( placer:get_player_name(), 'Not enough space for lamppost to be placed' )
          return;
       end
       if( minetest.env:get_node({x=pos.x, y=pos.y+2, z=pos.z}).name ~= "air" ) then
          minetest.chat_send_player( placer:get_player_name(), 'Not enough space for lamppost to be placed' )
          return;
       end
       return minetest.item_place(itemstack, placer, pointed_thing);
    end,
	after_place_node = function(pos,placer,itemstack)
		minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "lottother:lamp_middle_wood_mallorn"})
		minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},{name = "lottother:lamp_top_wood_mallorn"})
	end
})
minetest.register_node("lottother:lamp_middle_wood_mallorn",{
	drop = "",
	groups = {cracky = 1, not_in_creative_inventory = 1},
	tiles = {"lottplants_mallornwood.png"},
	paramtype = "light",
	drawtype = "nodebox",
	pointable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,0.5,0.1}
		}
	}
})

minetest.register_node("lottother:lamp_top_wood_mallorn",{
	drop = "lottother:lamp_wood_mallorn",
	groups = {cracky = 1, not_in_creative_inventory = 1},
		tiles = {
		"lottplants_mallornwood.png",
		"lottplants_mallornwood.png",
		{
			image = "lottother_lamps_active_mallorn.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_mallorn.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_mallorn.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		{
			image = "lottother_lamps_active_mallorn.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}}}}},
	paramtype = "light",
	drawtype = "nodebox",
	light_source = 14,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
	selection_box = 	{
		type = "fixed",
		fixed = {
			{-0.3,0.5,-0.3,0.3,-2.5,0.3},
		}
	},
	after_dig_node = function(pos)
		minetest.remove_node({x = pos.x, y = pos.y - 1, z = pos.z})
		minetest.remove_node({x = pos.x, y = pos.y - 2, z = pos.z})
	end
})

minetest.register_node("lottother:tiny_lamp_wood_mallorn",{
     description = "Mallorn Wooden Tiny Lamp",
	groups = {cracky = 1},
		tiles = {
		"lottplants_mallornwood.png",
		"lottplants_mallornwood.png",
		{
			image = "lottother_lamps_active_mallorn.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_mallorn.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
          {
			image = "lottother_lamps_active_mallorn.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		{
			image = "lottother_lamps_active_mallorn.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}}}}},
	paramtype = "light",
     paramtype2 = "wallmounted",
     legacy_wallmounted = true,
	drawtype = "nodebox",
	light_source = 14,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
	selection_box = 	{
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
})

minetest.register_craft({
	output = "lottother:lamp_wood_mallorn",
	recipe = {
		{"","default:torch",""},
		{"","default:steel_ingot",""},
		{"","default:steel_ingot",""}
	}
})

minetest.register_craft({
	output = "lottother:tiny_lamp_wood_mallorn",
	recipe = {
		{"","default:torch",""},
		{"","default:steel_ingot",""},
		{"","default:steel_ingot",""}
	}
})

-----------------------------------